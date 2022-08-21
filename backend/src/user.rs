use crate::error::{ErrorType, Result};
use crate::user_account_proto::user_account_server::UserAccount;
use crate::user_account_proto::{AuthenticationToken, Empty, UserCredential, UserDetails};
use log::warn;
use sqlx::{Pool, Row, Sqlite};
use std::result::Result as StdResult;
use tonic::metadata::MetadataMap;
use tonic::{Request, Response, Status};

type TonicResult<T> = StdResult<Response<T>, Status>;

pub struct UserAccountService {
    pool: Pool<Sqlite>,
}

#[tonic::async_trait]
impl UserAccount for UserAccountService {
    async fn register(&self, request: Request<UserCredential>) -> TonicResult<AuthenticationToken> {
        let result = self.register(request.get_ref()).await?;
        Ok(Response::new(result))
    }

    async fn login(&self, request: Request<UserCredential>) -> TonicResult<AuthenticationToken> {
        let result = self.login(request.get_ref()).await?;
        Ok(Response::new(result))
    }

    async fn get_user_details(
        &self,
        request: Request<AuthenticationToken>,
    ) -> TonicResult<UserDetails> {
        warn!("test");
        let result = self.get_user_details(request.get_ref()).await?;
        Ok(Response::new(result))
    }

    async fn logout(&self, request: Request<AuthenticationToken>) -> TonicResult<Empty> {
        self.logout(request.get_ref()).await?;
        Ok(Response::new(Empty {}))
    }
}

impl UserAccountService {
    pub fn new(pool: Pool<Sqlite>) -> Self {
        UserAccountService { pool }
    }

    async fn register(&self, user_credential: &UserCredential) -> Result<AuthenticationToken> {
        let query = "
        INSERT OR IGNORE INTO user_account (username, password)
        VALUES(?1, ?2)";
        let count = sqlx::query(query)
            .bind(&user_credential.username)
            .bind(&user_credential.password)
            .execute(&self.pool)
            .await?;
        if count.rows_affected() == 1 {
            self.login(user_credential).await
        } else {
            Err(ErrorType::UsernameExists)
        }
    }

    async fn login(&self, user_credential: &UserCredential) -> Result<AuthenticationToken> {
        let get_query = "
        SELECT password, user_id
        FROM user_account
        WHERE username = ?1";
        let result = sqlx::query(get_query)
            .bind(&user_credential.username)
            .fetch_optional(&self.pool)
            .await?
            .ok_or(ErrorType::DoesNotExist)?;
        let password: String = result.get("password");
        let user_id: i64 = result.get("user_id");
        if &password != &user_credential.password {
            Err(ErrorType::InvalidArgument)?;
        }
        let token = uuid::Uuid::new_v4().to_string();
        let insert_query = "
        INSERT INTO user_session (session_id, user_id)
        VALUES (?1, ?2)";
        sqlx::query(insert_query)
            .bind(&token)
            .bind(user_id)
            .execute(&self.pool)
            .await?;
        Ok(AuthenticationToken { token })
    }

    async fn get_user_details(
        &self,
        authentication_token: &AuthenticationToken,
    ) -> Result<UserDetails> {
        let query = "
        SELECT username, user_session.user_id as user_id
        FROM user_session
        LEFT JOIN user_account
            ON user_session.user_id = user_account.user_id
        WHERE session_id = ?1";
        let result = sqlx::query(query)
            .bind(&authentication_token.token)
            .fetch_optional(&self.pool)
            .await?
            .ok_or(ErrorType::InvalidArgument)?;
        let username: String = result.get("username");
        let user_id: i64 = result.get("user_id");
        Ok(UserDetails { username, user_id })
    }

    async fn logout(&self, authentication_token: &AuthenticationToken) -> Result<()> {
        let query = "
        DELETE FROM user_session
        WHERE session_id = ?1";
        sqlx::query(query)
            .bind(&authentication_token.token)
            .execute(&self.pool)
            .await?;
        Ok(())
    }

    pub async fn get_user_id(&self, metadata_map: &MetadataMap) -> Result<i64> {
        let token = metadata_map
            .get("token")
            .ok_or(ErrorType::TokenNotProvided)?
            .to_str()?;
        let query = "
        SELECT user_id
        FROM user_session
        WHERE session_id = ?1";
        let user_id = sqlx::query(query)
            .bind(token)
            .fetch_optional(&self.pool)
            .await?
            .ok_or(ErrorType::SessionDoesNotExist)?
            .get("user_id");
        Ok(user_id)
    }
}
