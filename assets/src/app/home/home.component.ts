
import {Component}   from '@angular/core';
import {
  NavigationExtras,
  Router,
} from '@angular/router';
import {FormControl, Validators} from '@angular/forms';

@Component({
    selector: 'home-component',
    templateUrl: 'home.component.html',
    styleUrls: ['./home.component.less'],
})

export class HomeComponent {
  menu = "home"

  constructor(
    public router: Router
  ) {}

  home() {
    this.menu = "home"
  }

  register() {
    this.menu = "register"
  }

  connect() {
    this.menu = "connect"
  }
}
