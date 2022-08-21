use std::convert::From;
use std::error::Error as StdError;
use std::fmt::{Debug, Display, Formatter, Result as FmtResult};
use std::result::Result as StdResult;
use std::sync::PoisonError;

pub type Result<T> = StdResult<T, ErrorType>;

#[derive(Debug)]
pub enum ErrorType {
    // Server Error
    PoisonError,
    CSSError,
    IoError,
    SqlxError(sqlx::Error),
    ReqwestError(reqwest::Error),
    // Generic Error
    DoesNotExist,
    InvalidArgument,
    InternalError,
    // User Account
    UsernameExists,
    TokenNotProvided,
    SessionDoesNotExist,
    // Webnovel Reader
    ChapterContentNotFound,
    UnexpectedChapterUrl,
    ChapterTitleNotFound,
    BookTitleNotFound,
}

impl Display for ErrorType {
    fn fmt(&self, f: &mut Formatter<'_>) -> FmtResult {
        Debug::fmt(&self, f)
    }
}

impl StdError for ErrorType {}

impl<T> From<PoisonError<T>> for ErrorType {
    fn from(_: PoisonError<T>) -> Self {
        Self::PoisonError
    }
}

impl From<reqwest::Error> for ErrorType {
    fn from(error: reqwest::Error) -> Self {
        Self::ReqwestError(error)
    }
}

impl<T> From<cssparser::ParseError<'_, T>> for ErrorType {
    fn from(_: cssparser::ParseError<'_, T>) -> Self {
        Self::InternalError
    }
}

impl From<sqlx::Error> for ErrorType {
    fn from(err: sqlx::Error) -> Self {
        Self::SqlxError(err)
    }
}
