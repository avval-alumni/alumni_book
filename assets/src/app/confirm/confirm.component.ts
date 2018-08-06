
import {Component}   from '@angular/core';
import {ActivatedRoute} from '@angular/router';
import {CookieService} from 'ngx-cookie-service';
import {Router} from '@angular/router';

import {AuthService} from '../authentication/auth.service';
import {UserService} from '../services/user.service';
import {User} from '../models/user';

@Component({
    selector: 'confirm-component',
    templateUrl: 'confirm.component.html',
    styleUrls: ['./confirm.component.less'],
})

export class ConfirmComponent {
  message: string;
  sub = undefined;

  constructor(
    public authService: AuthService,
    private cookieService: CookieService,
    private userService: UserService,
    private route: ActivatedRoute,
    private router: Router,
  ) {}

  ngOnInit() {
    this.message = "Validating your account.";

    this.sub = this.route
      .queryParams
      .subscribe(params => {
        this.message = "Account validated.";
        let token = params['token'];
        console.log(token);
        this.authService.setToken(token);

        this.router.navigate(['/dashboard']);
      });
  }

  ngOnDestroy() {
    this.sub.unsubscribe();
  }
}
