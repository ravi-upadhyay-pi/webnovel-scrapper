use crate::error::{ErrorType, Result};
use crate::webnovel_reader_proto::webnovel_reader_server::WebnovelReader;
use crate::webnovel_reader_proto::{Chapter, ChapterId};
use crate::webnovel_reader_proto::{GetChapterInput, GetChapterOutput};
use scraper::Html;
use scraper::Selector;
use std::result::Result as StdResult;
use tonic::{Request, Response, Status};

type TonicResult<T> = StdResult<Response<T>, Status>;

pub struct WebnovelReaderService {}

#[tonic::async_trait]
impl WebnovelReader for WebnovelReaderService {
    async fn get_chapter(
        &self,
        request: Request<GetChapterInput>,
    ) -> TonicResult<GetChapterOutput> {
        let chapter = self.get_chapter(&request.get_ref().chapter_id).await?;
        Ok(Response::new(GetChapterOutput { chapter }))
    }
}

impl WebnovelReaderService {
    pub fn new() -> Self {
        Self {}
    }

    async fn get_chapter(&self, chapter_id: &ChapterId) -> Result<Chapter> {
        let chapter = get_chapter(chapter_id).await?;
        Ok(chapter)
    }
}

async fn get_chapter(chapter_id: &ChapterId) -> Result<Chapter> {
    let chapter_url = format!(
        "https://novelfull.com/{}/{}.html",
        &chapter_id.book_id, &chapter_id.chapter_id
    );
    let html_string = reqwest::get(chapter_url).await?.text().await?;
    let html = Html::parse_fragment(&html_string);
    Ok(Chapter {
        next_chapter_id: get_chapter_id(&html, true)?,
        previous_chapter_id: get_chapter_id(&html, false)?,
        book_title: get_book_title(&html)?.to_string(),
        chapter_title: get_chapter_title(&html)?,
        html_content: get_chapter_content(&html)?,
    })
}

fn get_book_title(fragment: &Html) -> Result<&str> {
    let selector = Selector::parse(".truyen-title")?;
    let element = fragment
        .select(&selector)
        .next()
        .ok_or(ErrorType::BookTitleNotFound.to_error())?;
    let title = element
        .text()
        .next()
        .ok_or(ErrorType::BookTitleNotFound.to_error())?;
    Ok(title)
}

fn get_chapter_title(fragment: &Html) -> Result<String> {
    let selector = Selector::parse(".chapter-text")?;
    let title = fragment
        .select(&selector)
        .next()
        .map_or(String::new(), |f| f.text().collect());
    Ok(title)
}

fn get_chapter_content(fragment: &Html) -> Result<String> {
    let selector = Selector::parse("#chapter-content")?;
    let content = fragment
        .select(&selector)
        .next()
        .ok_or(ErrorType::ChapterContentNotFound.to_error())?
        .inner_html();
    Ok(content)
}

fn get_chapter_id(fragment: &Html, next: bool) -> Result<ChapterId> {
    let url = get_chapter_url(fragment, next)?;
    let book_id = url
        .split("/")
        .nth(1)
        .ok_or(ErrorType::UnexpectedChapterUrl.to_error())?
        .to_string();
    let chapter_id = url
        .split("/")
        .nth(2)
        .ok_or(ErrorType::UnexpectedChapterUrl.to_error())?
        .split(".html")
        .next()
        .ok_or(ErrorType::UnexpectedChapterUrl.to_error())?
        .to_string();
    Ok(ChapterId {
        book_id,
        chapter_id,
    })
}

fn get_chapter_url(fragment: &Html, next: bool) -> Result<&str> {
    let id = format!("#{}_chap", if next { "next" } else { "prev" });
    let selector = Selector::parse(&id)?;
    let url = fragment
        .select(&selector)
        .next()
        .ok_or(ErrorType::UnexpectedChapterUrl.to_error())?
        .value()
        .attr("href")
        .ok_or(ErrorType::UnexpectedChapterUrl.to_error())?;
    Ok(url)
}
