export class NovelFull {
    currentChapterEl: JQuery<HTMLElement>;

    constructor(private $: JQueryStatic, rawChapterEl: JQuery<HTMLElement>) {
        this.currentChapterEl = rawChapterEl;
    }

    getChapterLink(): string {
        return "https://novelfull.com" + this.currentChapterEl.find('.chapter-title').attr('href');
    }

    getBookTitle(): string {
        return this.currentChapterEl.find('.truyen-title').text();
    }

    getChapterTitle(): string {
        return this.currentChapterEl.find('.chapter-text').text();
    }

    async nextChapter(): Promise<boolean> {
        const nextChapterUrl = this.currentChapterEl.find("#next_chap").attr("href");
        if (nextChapterUrl == undefined) {
            return false;
        }
        this.currentChapterEl = this.$(await this.$.ajax(nextChapterUrl)).find('#chapter');
        return true;
    }

    getChapterParagraphEls(): HTMLElement[] {
        const paragraphEls = [];
        const contentEl = this.currentChapterEl.find("#chapter-content");
        const children = contentEl.children();
        for (let i = 0; i < children.length; i++) {
            const child = children[i];
            const classList = child.classList;
            if (classList.contains(".ads") ||
                classList.contains(".adsbygoogle") ||
                child.tagName === "script" ||
                child.getAttribute("align") === "left" ||
                child.textContent === this.getChapterTitle()
            ) {
                continue;
            } else if (child.textContent === '❄️❄️❄️') {
                paragraphEls.push(this.$(`<div class="intermission">#</div>`));
            } else {
                paragraphEls.push(child);
            }
        }
        return paragraphEls;
    }
}
