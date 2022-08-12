import { ChangeDetectionStrategy, Component, OnDestroy } from "@angular/core";
import {
  Chapter,
  GetChapterInput,
  ChapterId,
} from "../../generated/webnovel_reader_pb";
import { WebnovelReaderClient } from "../../generated/Webnovel_readerServiceClientPb";
import { ActivatedRoute } from "@angular/router";
import { Subject, BehaviorSubject } from "rxjs";
import { takeUntil } from "rxjs/operators";

@Component({
  selector: "chapter",
  templateUrl: "./chapter.component.html",
  styleUrls: ["./chapter.component.scss"],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class ChapterComponent implements OnDestroy {
  readonly client: WebnovelReaderClient;
  readonly chapter = new BehaviorSubject(new Chapter());
  readonly chapterMap = new Map<string, Chapter>();
  readonly destroy = new Subject<void>();

  constructor(private route: ActivatedRoute) {
    this.client = new WebnovelReaderClient("api");
    this.route.params.pipe(takeUntil(this.destroy)).subscribe(async () => {
      const book = this.route.snapshot.paramMap.get("book");
      const chapter = this.route.snapshot.paramMap.get("chapter");
      const id = new ChapterId();
      id.setBookId(book ?? "");
      id.setChapterId(chapter ?? "");
      await this.loadChapter(id, true);
    });
  }

  ngOnDestroy(): void {
    this.destroy.next();
  }

  async loadChapter(id: ChapterId, changeView: boolean) {
    const idString = this.getChapterUrl(id);
    let chapter = this.chapterMap.get(idString);
    if (chapter === undefined) {
      const input = new GetChapterInput();
      input.setChapterId(id);
      const response = await this.client.getChapter(input, null);
      chapter = response.getChapter() ?? new Chapter();
      this.chapterMap.set(idString, chapter);
    }
    if (changeView) {
      this.chapter.next(chapter);
      await this.loadNextChapters(chapter);
    }
    return chapter;
  }

  async loadNextChapters(chapter: Chapter) {
    for (let i = 0; i < 10; i++) {
      chapter = await this.loadChapter(
        chapter.getNextChapterId() ?? new ChapterId(),
        false
      );
    }
  }

  getNextChapterUrl(): string {
    return this.getChapterUrl(
      this.chapter.value.getNextChapterId() ?? new ChapterId()
    );
  }

  getPreviousChapterUrl(): string {
    return this.getChapterUrl(
      this.chapter.value.getPreviousChapterId() ?? new ChapterId()
    );
  }

  getChapterUrl(chapterId: ChapterId): string {
    return `/book/${chapterId.getBookId()}/chapter/${chapterId.getChapterId()}`;
  }
}
