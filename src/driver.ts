import * as fs from "fs";
import { NovelFull } from './novelfull';
import { css } from './css';
import { DOMWindow } from "jsdom";

export class Driver {
  contentEl: JQuery<HTMLElement>;
  indexEl: JQuery<HTMLElement>;
  novelFull: NovelFull;

  constructor(private window: DOMWindow, private $: JQueryStatic, private chapterCount: number) {
    const { contentEl, indexEl, rawChapterEl } = this.initializePage();
    this.contentEl = contentEl;
    this.indexEl = indexEl;
    this.novelFull = new NovelFull($, rawChapterEl);
  }

  async fetch() {
    this.indexEl.append(this.getBookTitleIndexEl());
    this.contentEl.append(this.getBookTitleEl());
    let i = 1;
    for (; i <= this.chapterCount; i++) {
      this.contentEl.append(this.getChapterEl(i));
      this.indexEl.append(this.chapterIndexEl(i));
      if (i == this.chapterCount || !await this.novelFull.nextChapter()) {
        continue;
      }
    }
    this.contentEl.append(this.getEndEl(i));
    let html = this.window.document.documentElement.outerHTML;
    const cssFragment = `<style>${css}</style>`;
    html = html.replace(`__STYLE_PLACEHOLDER__`, cssFragment);
    const scriptText = fs.readFileSync('./out/script.js', 'utf8');
    html = html.replace('__SCRIPT_PLACEHOLDER__', scriptText);
    fs.writeFileSync(this.novelFull.getBookTitle() + ".html", html);
  }

  initializePage() {
    const rawChapterEl = this.$('body').find('#chapter');
    this.$('body').remove();
    this.$('head').remove();
    const html = this.$('html');
    const headEl = this.$(`<head></head>`);
    headEl.append(this.$(`<meta charset="utf-8">`));
    headEl.append('__STYLE_PLACEHOLDER__');
    const body = this.$(`<body></body>`);
    const contentEl = this.$(`<div class="content"></div>`);
    const indexEl = this.$(`<div class="index"></div>`);
    const scriptEl = this.$(`<script></script>`);
    scriptEl.text('__SCRIPT_PLACEHOLDER__');
    html.append(headEl);
    body.append(indexEl);
    body.append(contentEl);
    body.append(scriptEl);
    html.append(body);
    return { contentEl, indexEl, rawChapterEl };
  }

  getBookTitleIndexEl(): JQuery<HTMLElement> {
    return this.$(`<a class="index-item" href="#cover">Cover</a>`);
  }

  getBookTitleEl(): JQuery<HTMLElement> {
    const title = this.novelFull.getBookTitle();
    return this.$(`<div class="book-title" id="cover">${title}</div>`);
  }

  getChapterContentEl() {
    const chapterContentEl = this.$(`<div class="chapter-content"></div>`);
    for (const paragraphEl of this.novelFull.getChapterParagraphEls()) {
      chapterContentEl.append(this.$(`<div class="selector"></div>`));
      chapterContentEl.append(paragraphEl);
    }
    return chapterContentEl;
  }

  getChapterNavEl(i: number, position: 'top' | 'bottom') {
    const chapterNavEl = this.$(`<div class="chapter-nav-${position}"></div>`);
    chapterNavEl.append(this.$(`<a class="button" href="#${i - 1}">Previous Chapter</a>`));
    chapterNavEl.append(this.$(`<a class="button" href="#${i + 1}">Next Chapter</a>`));
    return chapterNavEl;
  }

  getChapterEl(i: number): JQuery<HTMLElement> {
    const chapterEl = this.$(`<div id="${i}" class="chapter"></div>`);
    chapterEl.append(this.getChapterNavEl(i, 'top'));
    chapterEl.append(this.$(`<div class="chapter-title">${this.novelFull.getChapterTitle()}</div>`));
    chapterEl.append(this.$(`<a class="chapter-link" href="${this.novelFull.getChapterLink()}">Link</a>`));
    chapterEl.append(this.getChapterContentEl());
    chapterEl.append(this.getChapterNavEl(i, 'bottom'));
    return chapterEl;
  }

  chapterIndexEl(i: number): JQuery<HTMLElement> {
    const title = this.novelFull.getChapterTitle();
    return this.$(`<a class="index-item" href="#${i}">${title}</a>`);
  }

  getEndEl(i: number) {
    return this.$(`<div id="${i}" class="end">End</div>`);
  }
}
