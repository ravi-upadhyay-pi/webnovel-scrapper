use std::convert::From;
use std::error::Error;
use std::fmt::{Debug, Display, Formatter, Result as FmtResult};
use std::sync::PoisonError;
use tonic::{Code as TonicCode, Status as TonicStatus};

#[derive(Debug)]
pub enum SErrorType {
    PoisonError,
    CSSError,
    IoError,
}

impl Display for SErrorType {
    fn fmt(&self, f: &mut Formatter<'_>) -> FmtResult {
        Debug::fmt(&self, f)
    }
}

impl From<&SErrorType> for TonicCode {
    fn from(error_type: &SErrorType) -> TonicCode {
        match error_type {
            SErrorType::PoisonError | SErrorType::CSSError | SErrorType::IoError => {
                TonicCode::Internal
            }
        }
    }
}

#[derive(Debug)]
pub struct SError {
    error_type: SErrorType,
    source: Option<Box<dyn Error + Send + Sync + 'static>>,
}

/** Server Result */
pub type SResult<T> = Result<T, SError>;

impl Display for SError {
    fn fmt(&self, f: &mut Formatter<'_>) -> FmtResult {
        match self.source.as_ref() {
            Some(source) => write!(f, "{}: {}", self.error_type, source),
            None => write!(f, "{}", self.error_type),
        }
    }
}

impl Error for SError {}

impl From<SError> for TonicStatus {
    fn from(error: SError) -> Self {
        TonicStatus::new(TonicCode::from(&error.error_type), error.to_string())
    }
}

impl<T> From<PoisonError<T>> for SError {
    fn from(_: PoisonError<T>) -> SError {
        Self {
            error_type: SErrorType::PoisonError,
            source: None,
        }
    }
}

impl From<reqwest::Error> for SError {
    fn from(error: reqwest::Error) -> SError {
        Self {
            error_type: SErrorType::IoError,
            source: Some(Box::new(error)),
        }
    }
}

impl<T> From<cssparser::ParseError<'_, T>> for SError {
    fn from(_: cssparser::ParseError<'_, T>) -> Self {
        Self {
            error_type: SErrorType::CSSError,
            source: None,
        }
    }
}
