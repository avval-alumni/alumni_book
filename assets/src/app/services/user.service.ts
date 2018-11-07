import { Injectable } from '@angular/core';
import { HttpClient, HttpParams, HttpHeaders } from '@angular/common/http';
import { Observable, of } from 'rxjs';
import { catchError, map, tap } from 'rxjs/operators';

import {UserPage} from '../models/page/user_page';
import {User, Confirm, Redirect} from '../models/user';

@Injectable()
export class UserService {
  private usersUrl = 'api/users';
  private myselfUrl = 'api/myself';

  constructor(private http: HttpClient) { }

  getUsers(page: number, per_page: number): Observable<UserPage> {
    let params = new HttpParams();
    params = params.append('per_page', per_page.toString());
    if(page > 0) {
      params = params.append('page', String(page + 1));
    }

    return this.http.get<UserPage>(this.usersUrl, {params: params})
      .pipe(
        tap(userPage => this.log('fetched UserPage')),
        catchError(this.handleError('getUsers', undefined))
      );
  }

  getMyself(): Observable<User> {
    return this.http.get<User>(this.myselfUrl)
      .pipe(
        tap(userPage => this.log('fetched UserPage')),
        catchError(this.handleError('getMyself', undefined))
      );
  }

  updateMyself(user_info: any): Observable<User> {
    return this.http.put<User>(this.myselfUrl, {user: user_info})
      .pipe(
        tap(userPage => this.log('fetched UserPage')),
        catchError(this.handleError('updateMyself', undefined))
      );
  }

  linkWithGithub(): Observable<Redirect> {
    return this.http.get<Redirect>("/api/link/github")
      .pipe(
        tap(userPage => this.log('fetched UserUrl')),
        catchError(this.handleError('linkWithGithub', undefined))
      );
  }

  private handleError<T> (operation = 'operation', result?: T) {
    return (error: any): Observable<T> => {
      this.log(`${operation} failed: ${error.message}`);
      return of(result as T);
    };
  }

  private log(message: string) {
    console.log('UserService: ' + message);
  }
}
