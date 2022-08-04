pub mod webnovel_reader_proto {
    tonic::include_proto!("webnovel_reader");
}
pub mod user_account_proto {
    tonic::include_proto!("user_account");
}
pub mod error;
pub mod user_account;
pub mod webnovel_reader;

use crate::user_account::UserAccountService;
use crate::webnovel_reader::WebnovelReaderService;
use crate::webnovel_reader_proto::webnovel_reader_server::WebnovelReaderServer;
use fern::colors::{Color, ColoredLevelConfig};
use log::info;
use serde::Deserialize;
use sqlx::{Pool, Sqlite};
use std::fs;
use tonic::transport::Server as TonicServer;
use user_account_proto::user_account_server::UserAccountServer;

#[derive(Deserialize)]
struct Config {
    port: u16,
    log_file: String,
    sqlite_file: String,
}

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let config = get_config();
    setup_logger(&config.log_file);
    info!("Starting server at port {}", config.port);
    let address_string = format!("127.0.0.1:{}", config.port);
    let addr = address_string.parse().unwrap();
    let pool = get_sqlite_pool(&config).await;
    let webnovel_server = WebnovelReaderServer::new(WebnovelReaderService::new());
    let web_webnovel_service = tonic_web::enable(webnovel_server);
    let user_account_server = UserAccountServer::new(UserAccountService::new(pool));
    let web_user_account_service = tonic_web::enable(user_account_server);
    TonicServer::builder()
        .accept_http1(true)
        .add_service(web_webnovel_service)
        .add_service(web_user_account_service)
        .serve(addr)
        .await?;
    Ok(())
}

fn get_config() -> Config {
    let config_file = "config.toml";
    let config_string = fs::read_to_string(config_file).unwrap();
    toml::from_str(&config_string).unwrap()
}

fn setup_logger(log_file: &str) {
    let colors = ColoredLevelConfig::new()
        .info(Color::Green)
        .warn(Color::Magenta)
        .error(Color::Red);
    fern::Dispatch::new()
        .format(move |out, message, record| {
            out.finish(format_args!(
                "{}[{}][{}] {}",
                chrono::Local::now().format("[%Y-%m-%d][%H:%M:%S]"),
                record.target(),
                colors.color(record.level()),
                message
            ))
        })
        .level(log::LevelFilter::Warn)
        .chain(std::io::stdout())
        .chain(fern::log_file(log_file).unwrap())
        .apply()
        .unwrap();
}

async fn get_sqlite_pool(config: &Config) -> Pool<Sqlite> {
    let connection_options = sqlx::sqlite::SqliteConnectOptions::new()
        .create_if_missing(true)
        .filename(&config.sqlite_file);
    let pool = sqlx::Pool::connect_with(connection_options).await.unwrap();
    sqlx::migrate!("./migrations").run(&pool).await.unwrap();
    pool
}
