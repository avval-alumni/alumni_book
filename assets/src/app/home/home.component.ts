
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
  constructor(
    public router: Router
  ) {}

  // signin() {
    
  // }

  // signup() {

  // }
}