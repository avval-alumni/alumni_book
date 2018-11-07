
import {Component, ViewChild} from '@angular/core';
import {MatCheckboxModule, PageEvent} from '@angular/material';
import {ActivatedRoute, Router} from '@angular/router';

import {UserService} from '../services/user.service';
import {UserUrlService} from '../services/user_url.service';
import {UserPage} from '../models/page/user_page';
import {User} from '../models/user';

@Component({
  selector: 'users-component',
  templateUrl: 'users.component.html',
  styleUrls: ['./users.component.less'],
})

export class UsersComponent {
  length = 1000;
  pageSize = 10;
  email: string;
  password: string;
  error_message: string;
  page = 0;
  sub = undefined;

  pageEvent: PageEvent;
  users: UserPage;

  constructor(
    private userService: UserService,
    private userUrlService: UserUrlService,
    private route: ActivatedRoute,
    private router: Router,
  ) {}

  ngOnInit() {
    this.sub = this.route
      .queryParams
      .subscribe(params => {
        this.page = +params['page'] || 0;
        this.getUsers(this.page);
      });
  }

  ngOnDestroy() {
    this.sub.unsubscribe();
  }

  getUsers(index): void {
    this.userService.getUsers(index, this.pageSize)
    .subscribe(userPage => {
      this.users = userPage;
      if(userPage) {
        this.length = userPage.total;
      } else {
        this.length = 0;
      }
    });
  }

  eventGetUsers(event): void {
    this.router.navigate(['/users'], { queryParams: this.getQueryParamsForPage(event.pageIndex) });
    this.getUsers(event.pageIndex);
  }

  // removeUser(user_id): void {
  //   this.userService.removeUser(user_id)
  //   .subscribe(response => {
  //     this.getUsers(this.page);
  //   });
  // }

  getQueryParamsForPage(pageIndex: number): Object {
    var params = {};
    if(pageIndex != 0) {
      params['page'] = pageIndex;
    }
    return params;
  }

  openFacebookProfile(user_id: string) {
    this.userUrlService.getFacebookUrl(user_id)
    .subscribe(response => {
      console.log(response)
      if(response && response.url) {
        window.open(response.url, "_blank");
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
