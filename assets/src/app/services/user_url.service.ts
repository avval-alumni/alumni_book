import { Injectable } from '@angular/core';
import { HttpClient, HttpParams, HttpHeaders } from '@angular/common/http';
import { Observable, of } from 'rxjs';
import { catchError, map, tap } from 'rxjs/operators';

import {UserUrl} from '../models/user';

@Injectable()
export class UserUrlService {

  constructor(private http: HttpClient) { }

  getGithubUrl(user_id: string): Observable<UserUrl> {
    return this.http.get<UserUrl>("api/users/" + user_id + "/github_url")
      .pipe(
        tap(userPage => this.log('fetched UserUrl')),
        catchError(this.handleError('getGithubUrl', undefined))
      );
  }

  getLinkedinUrl(user_id: string): Observable<UserUrl> {
    return this.http.get<UserUrl>("api/users/" + user_id + "/linkedin_url")
      .pipe(
        tap(userPage => this.log('fetched UserUrl')),
        catchError(this.handleError('getGithubUrl', undefined))
      );
  }

  private handleError<T> (operation = 'operation', result?: T) {
    return (error: any): Observable<T> => {
      this.log(`${operation} failed: ${error.message}`);
      return of(result as T);
    };
  }

  private log(message: string) {
    console.log('UserUrlService: ' + message);
  }
}
