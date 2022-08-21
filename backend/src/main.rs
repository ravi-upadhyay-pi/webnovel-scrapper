use axum::{routing::get, Router};
use fern::colors::{Color, ColoredLevelConfig};
use log::info;
use serde::Deserialize;
use service::server::context::MakeAddContext;
use service::server::MakeService;
use sqlx::{Pool, Sqlite};
use std::fs;

#[derive(Deserialize)]
struct Config {
    port: u16,
    log_file: String,
    sqlite_file: String,
}

#[tokio::main]
async fn main() -> Result<(), ()> {
    let config = get_config();
    setup_logger(&config.log_file);
    info!("Server will be started at port {}", config.port);
    let address = format!("0.0.0.0:{}", config.port);
    let pool = get_sqlite_pool(&config).await;
    let app = Router::new().route(
        "/",
        get({
            let pool = pool.clone();
            move || handle(pool)
        }),
    );
    axum::Server::bind(&address.parse().unwrap())
        .serve(app.into_make_service())
        .await
        .unwrap();
    Ok(())
}

async fn handle(_pool: Pool<Sqlite>) -> Result<&'static str, ()> {
    Ok("Hello World!")
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
        .level(log::LevelFilter::Info)
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
    pool
}
