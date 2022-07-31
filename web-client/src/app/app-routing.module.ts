import { NgModule } from "@angular/core";
import { RouterModule, Routes } from "@angular/router";
import { ChapterComponent } from "./chapter/chapter.component";
import { BookComponent } from "./book/book.component";

const routes: Routes = [
  { path: "book/:book/chapter/:chapter", component: ChapterComponent },
  { path: "book/:book", component: BookComponent },
];
@NgModule({
  imports: [
    RouterModule.forRoot(routes, {
      scrollPositionRestoration: "enabled",
    }),
  ],
  exports: [RouterModule],
})
export class AppRoutingModule {}
