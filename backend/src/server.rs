use crate::proto::webnovel_reader_server::WebnovelReader;
use crate::proto::{GetChapterInput, GetChapterOutput};
use crate::service::get_chapter;
use tonic::{Request, Response, Status};

pub struct Server {}

type TonicResult<T> = Result<Response<T>, Status>;

#[tonic::async_trait]
impl WebnovelReader for Server {
    async fn get_chapter(
        &self,
        request: Request<GetChapterInput>,
    ) -> TonicResult<GetChapterOutput> {
        let chapter = get_chapter(&request.get_ref().chapter_id).await?;
        Ok(Response::new(GetChapterOutput { chapter }))
    }
}
