use crate::error::SResult;
use crate::proto::{Chapter, ChapterId};
use scraper::Html;
use scraper::Selector;
use selectors::attr::CaseSensitivity;

pub async fn get_chapter(chapter_id: &ChapterId) -> SResult<Chapter> {
    let chapter_url = format!(
        "https://novelfull.com/{}/{}.html",
        &chapter_id.book_id, &chapter_id.chapter_id
    );
    let html_string = reqwest::get(chapter_url).await?.text().await?;
    let html = Html::parse_fragment(&html_string);
    Ok(Chapter {
        next_chapter_id: get_chapter_id(&html, true)?,
        previous_chapter_id: get_chapter_id(&html, false)?,
        book_title: get_book_title(&html)?,
        chapter_title: get_chapter_title(&html)?,
        paragraphs: get_chapter_paragraphs(&html)?,
    })
}

fn get_book_title(fragment: &Html) -> SResult<String> {
    let selector = Selector::parse(".truyen-title")?;
    let title = fragment
        .select(&selector)
        .next()
        .map_or(String::new(), |f| f.text().collect());
    Ok(title)
}

fn get_chapter_title(fragment: &Html) -> SResult<String> {
    let selector = Selector::parse(".chapter-text")?;
    let title = fragment
        .select(&selector)
        .next()
        .map_or(String::new(), |f| f.text().collect());
    Ok(title)
}

fn get_chapter_paragraphs(fragment: &Html) -> SResult<Vec<String>> {
    let selector = Selector::parse("#chapter-content > *")?;
    let chapter_title = get_chapter_title(fragment)?;
    let paragraphs = fragment
        .select(&selector)
        .filter(|fragment| {
            !fragment
                .value()
                .has_class("ads", CaseSensitivity::AsciiCaseInsensitive)
        })
        .map(|fragment| fragment.text().collect())
        .filter(|text: &String| {
            let text = text.trim();
            !text.is_empty()
                && !text.starts_with("If you find any errors")
                && text != chapter_title.as_str()
        })
        .map(|text| match text.as_str() {
            "❄️❄️❄️" => "".to_string(),
            _ => text,
        })
        .collect();
    Ok(paragraphs)
}

fn get_chapter_id(fragment: &Html, next: bool) -> SResult<ChapterId> {
    let url = get_chapter_url(fragment, next)?;
    let mut parts = url.split("/");
    parts.next();
    let book_id = parts.next().unwrap_or_default().to_string();
    let chapter_id = parts
        .next()
        .unwrap_or_default()
        .split(".html")
        .next()
        .unwrap_or_default()
        .to_string();
    Ok(ChapterId {
        book_id,
        chapter_id,
    })
}

fn get_chapter_url(fragment: &Html, next: bool) -> SResult<String> {
    let id = format!("#{}_chap", if next { "next" } else { "prev" });
    let selector = Selector::parse(&id)?;
    let url = fragment
        .select(&selector)
        .next()
        .map_or(String::new(), |f| {
            f.value()
                .attr("href")
                .map(|str| str.to_string())
                .unwrap_or_default()
        });
    Ok(url)
}
