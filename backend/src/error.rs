use std::convert::From;
use std::error::Error as StdError;
use std::fmt::{Debug, Display, Formatter, Result as FmtResult};
use std::result::Result as StdResult;
use std::sync::PoisonError;
use tonic::{Code as TonicCode, Status as TonicStatus};

#[derive(Debug)]
pub enum ErrorType {
    // Server Error
    PoisonError,
    CSSError,
    IoError,
    SqlxError,
    // Generic Error
    DoesNotExist,
    InvalidArgument,
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

impl ErrorType {
    pub fn to_error(self) -> Error {
        Error {
            error_type: self,
            source: None,
        }
    }
}

impl From<&ErrorType> for TonicCode {
    fn from(error_type: &ErrorType) -> TonicCode {
        match error_type {
            ErrorType::PoisonError
            | ErrorType::CSSError
            | ErrorType::IoError
            | ErrorType::SqlxError => TonicCode::Internal,
            ErrorType::DoesNotExist => TonicCode::NotFound,
            _ => TonicCode::InvalidArgument,
        }
    }
}

#[derive(Debug)]
pub struct Error {
    error_type: ErrorType,
    source: Option<Box<dyn StdError + Send + Sync + 'static>>,
}

/** Server Result */
pub type Result<T> = StdResult<T, Error>;

impl Display for Error {
    fn fmt(&self, f: &mut Formatter<'_>) -> FmtResult {
        match self.source.as_ref() {
            Some(source) => write!(f, "{}: {}", self.error_type, source),
            None => write!(f, "{}", self.error_type),
        }
    }
}

impl StdError for Error {}

impl From<Error> for TonicStatus {
    fn from(error: Error) -> Self {
        TonicStatus::new(TonicCode::from(&error.error_type), error.to_string())
    }
}

impl<T> From<PoisonError<T>> for Error {
    fn from(_: PoisonError<T>) -> Error {
        Self {
            error_type: ErrorType::PoisonError,
            source: None,
        }
    }
}

impl From<reqwest::Error> for Error {
    fn from(error: reqwest::Error) -> Error {
        Self {
            error_type: ErrorType::IoError,
            source: Some(Box::new(error)),
        }
    }
}

impl<T> From<cssparser::ParseError<'_, T>> for Error {
    fn from(_: cssparser::ParseError<'_, T>) -> Self {
        Self {
            error_type: ErrorType::CSSError,
            source: None,
        }
    }
}

impl From<sqlx::Error> for Error {
    fn from(err: sqlx::Error) -> Self {
        Self {
            error_type: ErrorType::SqlxError,
            source: Some(Box::new(err)),
        }
    }
}

impl From<tonic::metadata::errors::ToStrError> for Error {
    fn from(err: tonic::metadata::errors::ToStrError) -> Self {
        Self {
            error_type: ErrorType::InvalidArgument,
            source: Some(Box::new(err)),
        }
    }
}
