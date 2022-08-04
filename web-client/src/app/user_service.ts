import { Injectable } from "@angular/core";
import { Metadata } from "grpc-web";
import { UserAccountClient } from "../generated/User_accountServiceClientPb";
import { AuthenticationToken, UserDetails } from "../generated/user_account_pb";

@Injectable({
  providedIn: "root",
})
export class UserService {
  readonly tokenKey = "auth-token";
  readonly userAccountClient = new UserAccountClient("api");

  saveToken(token: string) {
    window.localStorage.setItem(this.tokenKey, token);
  }

  getTokenMetadata(): Metadata {
    return {
      ["auth-token"]: window.localStorage.getItem(this.tokenKey) ?? "",
    };
  }

  async getUserDetails(): Promise<UserDetails | null> {
    const token = window.localStorage.getItem(this.tokenKey) ?? "";
    if (token === "") {
      return null;
    }
    const authenticationToken = new AuthenticationToken();
    authenticationToken.setToken(token);
    return await this.userAccountClient.getUserDetails(
      authenticationToken,
      null
    );
  }

  async logout() {
    const token = window.localStorage.getItem(this.tokenKey) ?? "";
    if (token === "") {
      return;
    }
    const authenticationToken = new AuthenticationToken();
    authenticationToken.setToken(token);
    return await this.userAccountClient.logout(authenticationToken, null);
  }
}
