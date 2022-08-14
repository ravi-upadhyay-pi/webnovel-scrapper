import { ChangeDetectionStrategy, Component } from "@angular/core";
import { FormControl, Validators } from "@angular/forms";
import { ActivatedRoute, Router } from "@angular/router";
import { UserAccountClient } from "../../generated/User_accountServiceClientPb";
import {
  AuthenticationToken,
  UserCredential,
} from "../../generated/user_account_pb";
import { BehaviorSubject } from "rxjs";
import { RpcError } from "grpc-web";
import { UserService } from "../user_service";
import { Title } from "@angular/platform-browser";

@Component({
  selector: "app-login",
  templateUrl: "./login.component.html",
  styleUrls: ["./login.component.scss"],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class LoginComponent {
  readonly username = new FormControl<string>("", Validators.required);
  readonly password = new FormControl<string>("", Validators.required);
  readonly type: "Login" | "Register";
  readonly userAccountClient = new UserAccountClient("api");
  readonly disableSubmit = new BehaviorSubject(false);
  readonly error = new BehaviorSubject<string | null>(null);

  constructor(
    activatedRoute: ActivatedRoute,
    private userService: UserService,
    private router: Router,
    title: Title
  ) {
    this.type =
      activatedRoute.snapshot.url[0]?.path === "signup" ? "Register" : "Login";
    title.setTitle(this.type);
  }

  async submit() {
    this.error.next(null);
    this.disableSubmit.next(true);
    const userCredential = new UserCredential();
    userCredential.setUsername(this.username.value ?? "");
    userCredential.setPassword(this.password.value ?? "");
    let authenticationToken: AuthenticationToken;
    try {
      if (this.type === "Register") {
        authenticationToken = await this.userAccountClient.register(
          userCredential,
          null
        );
      } else {
        authenticationToken = await this.userAccountClient.login(
          userCredential,
          null
        );
      }
      this.userService.saveToken(authenticationToken.getToken());
      await this.router.navigateByUrl("");
    } catch (err) {
      this.error.next(
        err instanceof RpcError ? err.message : "Request Failed."
      );
    }
    this.disableSubmit.next(false);
  }
}
