import { Component, OnInit } from "@angular/core";
import { BehaviorSubject } from "rxjs";
import { UserDetails } from "../../generated/user_account_pb";
import { UserService } from "../user_service";
import { Title } from "@angular/platform-browser";

@Component({
  selector: "app-home",
  templateUrl: "./home.component.html",
  styleUrls: ["./home.component.scss"],
})
export class HomeComponent implements OnInit {
  readonly userDetails = new BehaviorSubject<UserDetails | null>(null);

  constructor(readonly userService: UserService, title: Title) {
    title.setTitle("Webnovels");
  }

  async ngOnInit() {
    const userDetails = await this.userService.getUserDetails();
    this.userDetails.next(userDetails);
    console.log(userDetails);
  }

  async logout() {
    this.userDetails.next(null);
    await this.userService.logout();
  }
}
