fn main() -> Result<(), Box<dyn std::error::Error>> {
    tonic_build::configure().build_server(true).compile(
        &[
            "../proto/webnovel_reader.proto",
            "../proto/user_account.proto",
        ],
        &["../proto/"],
    )?;
    println!("cargo:rerun-if-changed=migrations");
    Ok(())
}
