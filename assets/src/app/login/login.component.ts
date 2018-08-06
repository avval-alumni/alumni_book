
import {Component}   from '@angular/core';
import {
  NavigationExtras,
  Router,
} from '@angular/router';
import {AuthService} from '../authentication/auth.service';

@Component({
    selector: 'login-component',
    templateUrl: 'login.component.html',
    styleUrls: ['./login.component.less'],
})

export class LoginComponent {
  username: string;
  password: string;
  message: string;

  constructor(
    public authService: AuthService,
    public router: Router
  ) {}

  logout() {
    this.authService.logout();
  }
}
