import {Injectable, Inject} from '@angular/core';
import {
  ActivatedRouteSnapshot,
  CanActivate,
  CanActivateChild,
  Router,
  RouterStateSnapshot
} from '@angular/router';
import {CookieService} from 'ngx-cookie-service';
import {AuthService} from './auth.service';
import {SESSION_STORAGE, WebStorageService} from 'angular-webstorage-service';

@Injectable()
export class AuthGuard implements CanActivate, CanActivateChild {
  constructor(
    @Inject(SESSION_STORAGE) private storage: WebStorageService,
    private cookieService: CookieService,
    private authService: AuthService,
    private router: Router
  ) {}

  canActivate(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): boolean {
    let url: string = state.url;
    console.log(route, state);
    return this.checkLogin(url);
  }

  canActivateChild(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): boolean {
    return this.canActivate(route, state);
  }

  checkLogin(url: string): boolean {
    console.log("Logged ? ", this.authService.isLoggedIn)

    if (this.authService.isLoggedIn) {
      console.log("Check URL ", url)

      if(
        url.startsWith("/users") ||
        url.startsWith("/myself")
        ) {
        return true;
      }

      if(url.startsWith("/login")){
        this.router.navigate(['/dashboard']);
        return true;
      }

      if(url.startsWith("/home")){
        this.router.navigate(['/dashboard']);
        return true;
      }

      if(url.startsWith("/dashboard")) {
        return true;
      }
      return false;
    }

    if(url.startsWith("/login")){
      return true;
    }

    if(url.startsWith("/home")){
      return true;
    }

    // Store the attempted URL for redirecting
    this.authService.redirectUrl = url;

    // Navigate to the login page with extras
    this.router.navigate(['/home']);
    return false;
  }
}
