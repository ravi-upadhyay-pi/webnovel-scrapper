pub mod webnovel_reader_proto {
    tonic::include_proto!("webnovel_reader");
}

pub mod error;
pub mod webnovel_reader;

use crate::webnovel_reader::WebnovelReaderService;
use crate::webnovel_reader_proto::webnovel_reader_server::WebnovelReaderServer;
use serde::Deserialize;
use std::fs;
use tonic::transport::Server as TonicServer;

#[derive(Deserialize)]
struct Config {
    port: u16,
}

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let config_string = fs::read_to_string("Config.toml").unwrap();
    let config: Config = toml::from_str(&config_string).unwrap();
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
