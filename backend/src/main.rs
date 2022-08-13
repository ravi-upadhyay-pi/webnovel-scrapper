pub mod webnovel_reader_proto {
    tonic::include_proto!("webnovel_reader");
}

pub mod error;
pub mod webnovel_reader;

use crate::webnovel_reader::WebnovelReaderService;
use crate::webnovel_reader_proto::webnovel_reader_server::WebnovelReaderServer;
use fern::colors::{Color, ColoredLevelConfig};
use log::info;
use serde::Deserialize;
use std::fs;
use tonic::transport::Server as TonicServer;

#[derive(Deserialize)]
struct Config {
    port: u16,
    log_file: String,
}

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let config = get_config();
    setup_logger(&config.log_file);
    info!("Starting server at port {}", config.port);
    let addr = format!("127.0.0.1:{}", config.port).parse().unwrap();
    let webnovel_server = WebnovelReaderServer::new(WebnovelReaderService::new());
    let web_webnovel_service = tonic_web::enable(webnovel_server);
    TonicServer::builder()
        .accept_http1(true)
        .add_service(web_webnovel_service)
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
        .level(log::LevelFilter::Info)
        .chain(std::io::stdout())
        .chain(fern::log_file(log_file).unwrap())
        .apply()
        .unwrap();
}
