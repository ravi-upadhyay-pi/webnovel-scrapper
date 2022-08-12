import { ChangeDetectionStrategy, Component } from "@angular/core";

@Component({
  selector: "app-root",
  template: "<router-outlet></router-outlet>",
  styleUrls: [],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class AppComponent {}
