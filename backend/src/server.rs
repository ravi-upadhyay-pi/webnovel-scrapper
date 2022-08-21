use async_trait::async_trait;
use log::{info, warn};
use service::models;
use service::Api;
use service::CreateAuthenticationTokenResponse;
use service::UserDeleteResponse;
use service::UserGetResponse;
use service::UserPutResponse;
use sqlx::{Pool, Sqlite};
use swagger::ApiError;
use swagger::{Has, XSpanIdString};

#[derive(Clone)]
pub struct Server {
    pub pool: Pool<Sqlite>,
}

#[async_trait]
impl<C> Api<C> for Server
where
    C: Has<XSpanIdString> + Send + Sync,
{
    async fn create_authentication_token(
        &self,
        user_credential: models::UserCredential,
        context: &C,
    ) -> Result<CreateAuthenticationTokenResponse, ApiError> {
        let context = context.clone();
        info!(
            "create_authentication_token({:?}) - X-Span-ID: {:?}",
            user_credential,
            context.get().0.clone()
        );
        Err(ApiError("Generic failure".into()))
    }

    /// Invalidates authentication token
    async fn user_delete(
        &self,
        get_user_request: models::GetUserRequest,
        context: &C,
    ) -> Result<UserDeleteResponse, ApiError> {
        let context = context.clone();
        info!(
            "user_delete({:?}) - X-Span-ID: {:?}",
            get_user_request,
            context.get().0.clone()
        );
        Err(ApiError("Generic failure".into()))
    }

    /// Get user details using authentication token
    async fn user_get(
        &self,
        get_user_request: models::GetUserRequest,
        context: &C,
    ) -> Result<UserGetResponse, ApiError> {
        let context = context.clone();
        info!(
            "user_get({:?}) - X-Span-ID: {:?}",
            get_user_request,
            context.get().0.clone()
        );
        Err(ApiError("Generic failure".into()))
    }

    /// Add a new user
    async fn user_put(
        &self,
        user_credential: models::UserCredential,
        context: &C,
    ) -> Result<UserPutResponse, ApiError> {
        let context = context.clone();
        warn!(
            "user_put({:?}) - X-Span-ID: {:?}",
            user_credential,
            context.get().0.clone()
        );
        Err(ApiError("Generic failure".into()))
    }
}
