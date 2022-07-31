pub mod proto {
    tonic::include_proto!("webnovel_reader");
}
pub mod error;
pub mod server;
pub mod service;

use crate::server::Server;
use proto::webnovel_reader_server::WebnovelReaderServer;
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
    let server = Server {};
    let service = WebnovelReaderServer::new(server);
    let web_serevice = tonic_web::enable(service);
    TonicServer::builder()
        .accept_http1(true)
        .add_service(web_serevice)
        .serve(addr)
        .await?;
    Ok(())
}
