import { NgModule } from "@angular/core";
import { RouterModule, Routes } from "@angular/router";
import { ChapterComponent } from "./chapter/chapter.component";
import { BookComponent } from "./book/book.component";
import { LoginComponent } from "./login/login.component";
import { HomeComponent } from "./home/home.component";

const routes: Routes = [
  { path: "book/:book/chapter/:chapter", component: ChapterComponent },
  { path: "book/:book", component: BookComponent },
  { path: "login", component: LoginComponent },
  { path: "signup", component: LoginComponent },
  { path: "", component: HomeComponent },
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
