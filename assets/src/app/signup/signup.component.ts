
import {Component}   from '@angular/core';
import {
  NavigationExtras,
  Router,
} from '@angular/router';
import {AuthService} from '../authentication/auth.service';

@Component({
    selector: 'signup-component',
    templateUrl: 'signup.component.html',
    styleUrls: ['./signup.component.less'],
})

export class SignupComponent {
  // username: string;
  // password: string;
  // message: string;
  checked = false;
  disabled = false;

  constructor(
    public router: Router
  ) {}

  continue() {
    this.router.navigate(['/dashboard']);
  }

  select() {
    
  }
  // logout() {
  //   this.authService.logout();
  // }
}
