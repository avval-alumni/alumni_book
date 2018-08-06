
import {Component} from '@angular/core';
import {BreakpointObserver, Breakpoints} from '@angular/cdk/layout';
import {AuthService} from './authentication/auth.service';
import {UserService} from './services/user.service';
import {User} from './models/user';
import {Subscription} from 'rxjs';

@Component({
    selector: 'app-component',
    templateUrl: 'app.component.html',
    styleUrls: [ './app.component.less' ],
})

export class AppComponent {
  loggedIn: boolean;
  menu_opened: boolean = false;
  right_panel_opened: boolean = false;
  myself : User;

  subIn: Subscription;
  subOut: Subscription;

  constructor(
    public authService: AuthService,
    public userService: UserService,
    public breakpointObserver: BreakpointObserver) {
  }

  ngOnInit() {
    this.subIn = this.authService.userLoggedIn$.subscribe(
      username => {
        this.loggedIn = true;
        this.menu_opened = !this.breakpointObserver.isMatched('(max-width: 599px)');
        this.userService.getMyself()
        .subscribe(myself => {
          this.myself = myself;
        });
      });
    this.subOut = this.authService.userLoggedOut$.subscribe(
      username => {
        this.loggedIn = false;
        this.menu_opened = false;
      });

    if(this.authService.isLoggedIn) {
      this.loggedIn = true;
      this.menu_opened = !this.breakpointObserver.isMatched('(max-width: 599px)');
      this.userService.getMyself()
        .subscribe(myself => {
          this.myself = myself;
        });
    }
  }

  switchMenu() {
    this.menu_opened = !this.menu_opened;
  }

  openRightPanel() {
    this.right_panel_opened = !this.right_panel_opened;
  }

  logout() {
    this.right_panel_opened = false;
    this.authService.logout();
  }
}
