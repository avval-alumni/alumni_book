
import {Component, Inject} from '@angular/core';
import {AuthService}    from '../authentication/auth.service';
import {Subscription}   from 'rxjs';
import {CookieService} from 'ngx-cookie-service';
import {SESSION_STORAGE, WebStorageService} from 'angular-webstorage-service';
import {UserService} from '../services/user.service';
import {UserUrlService} from '../services/user_url.service';
import {UserPage} from '../models/page/user_page';

@Component({
    selector: 'dashboard-component',
    templateUrl: 'dashboard.component.html',
    styleUrls: ['./dashboard.component.less'],
})

export class DashboardComponent {
  length = 1000;
  pageSize = 10;
  page = 0;
  users: UserPage;

  constructor(
    @Inject(SESSION_STORAGE) private storage: WebStorageService,
    private cookieService: CookieService,
    public authService: AuthService,
    private userService: UserService,
    private userUrlService: UserUrlService,
  ) {}

  ngOnInit() {
    let key = this.cookieService.get('_alumni_book_key');
    console.log("dashboard", this.authService.isLoggedIn);

    this.userService.getUsers(this.page, this.pageSize)
    .subscribe(userPage => {
      this.users = userPage;
      if(userPage) {
        this.length = userPage.total;
      } else {
        this.length = 0;
      }
    });
  }

  openLinkedinProfile(user_id: string) {
    this.userUrlService.getLinkedinUrl(user_id)
    .subscribe(response => {
      console.log(response)
      if(response && response.url) {
        window.open(response.url, "_blank");
      }
    });
  }

  openGithubProfile(user_id: string) {
    this.userUrlService.getGithubUrl(user_id)
    .subscribe(response => {
      if(response && response.url) {
        window.open(response.url, "_blank");
      }
    });
  }
}
