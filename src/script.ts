// This is not used to generate the page. But instead, this is transpiled to javascript, and then
// is inserted as text inside a script tag.

const chapters = document.getElementsByClassName("chapter");
for (let i = 0; i < chapters.length; i++) {
    const children = chapters[i].querySelectorAll('.chapter-content > .selector');
    for (let j = 0; j < children.length; j++) {
        children[j].addEventListener('click', handleParagraphClick);
    }
}

function handleParagraphClick(event) {
    const chapterContainer = event.target.parentElement.parentElement;
    const bottomNav = chapterContainer.querySelector('.chapter-nav-bottom');
    const selection = window.getSelection();
    selection.removeAllRanges();
    const range = document.createRange();
    range.setStart(event.target, 0);
    range.setEndBefore(bottomNav);
    selection.addRange(range);
}
