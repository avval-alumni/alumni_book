import {Injectable, Component, OnDestroy} from '@angular/core';
import {Router} from '@angular/router';
import {HttpClient, HttpParams, HttpHeaders} from '@angular/common/http';
import {CookieService} from 'ngx-cookie-service';
import {Observable, of, Subject, Subscription} from 'rxjs';
import {catchError, map, tap} from 'rxjs/operators';
import {Token} from '../models/token';
import 'rxjs/add/operator/do';

@Injectable()
export class AuthService {
  isLoggedIn = false;
  token : string;
  redirectUrl: string;

  private userLoggedInSource = new Subject<string>();
  private userLoggedOutSource = new Subject<string>();
  private rightPanelSwitchSource = new Subject<string>();

  userLoggedIn$ = this.userLoggedInSource.asObservable();
  userLoggedOut$ = this.userLoggedOutSource.asObservable();
  rightPanelSwitch$ = this.rightPanelSwitchSource.asObservable();

  subPanelSwitch: Subscription;

  constructor(
    private cookieService: CookieService,
    private http: HttpClient,
    public router: Router
  ) {
    var currentUser = this.cookieService.get('currentUser');
    if(currentUser != undefined && currentUser != "") {
      this.isLoggedIn = true;
      var parsedUser = JSON.parse(currentUser);
      this.token = parsedUser.token;
    }
  }

  switchRightPanel() {
    this.rightPanelSwitchSource.next("switch");
  }

  logout(): void {
    this.isLoggedIn = false;
    this.token = undefined;
    this.userLoggedOutSource.next("");
    this.cookieService.delete('currentUser');
    this.rightPanelSwitchSource.next("close");
    this.router.navigate(["/login"]);
  }

  setToken(token: string) {
    this.token = token;
    this.cookieService.set('currentUser', JSON.stringify({
      token: token
    }));
    this.isLoggedIn = true;
    let email = "arnaud.marcantoine@gmail.com";
    this.userLoggedInSource.next(email);
  }

  getToken(): string {
    return this.token;
  }

  private handleError<T> (operation = 'operation', result?: T) {
    return (error: any): Observable<T> => {
      console.error(error);
      this.log(`${operation} failed: ${error.message}`);
      return of(result as T);
    };
  }

  private log(message: string) {
    console.log('LoginService: ' + message);
  }
}
