
import {APP_BASE_HREF}    from '@angular/common';
import {
  HttpClientModule,
  HTTP_INTERCEPTORS
} from '@angular/common/http';
import {NgModule}         from '@angular/core';
import {FormsModule}      from '@angular/forms';
import {BrowserModule}    from '@angular/platform-browser';
import {AppComponent}     from './app.component';
import {
  MatButtonModule,
  MatCardModule,
  MatCheckboxModule,
  MatDatepickerModule,
  MatDialogModule,
  MatIconModule,
  MatInputModule,
  MatListModule,
  MatMenuModule,
  MatPaginatorModule,
  MatSelectModule,
  MatSidenavModule,
  MatSlideToggleModule,
  MatTableModule,
  MatToolbarModule
  } from '@angular/material';
import {MatRadioModule} from '@angular/material/radio';
import {MatStepperModule} from '@angular/material/stepper';
import {BrowserAnimationsModule} from '@angular/platform-browser/animations';

import {
  MomentDateAdapter,
  MatMomentDateModule,
  MAT_MOMENT_DATE_FORMATS
} from '@angular/material-moment-adapter';

import {
  DateAdapter,
  MAT_DATE_LOCALE,
  MAT_DATE_FORMATS
} from '@angular/material/core';

import {RouterModule, Routes}    from '@angular/router';
import {CookieService}           from 'ngx-cookie-service';
import {StorageServiceModule}    from 'angular-webstorage-service';

import {AppRoutingModule}        from './app-routing.module';
import {SocketModule}            from './socket.module';

import {ConfirmComponent}        from './confirm/confirm.component';
import {DashboardComponent}      from './dashboard/dashboard.component';
import {LoginComponent}          from './login/login.component';
import {MyselfComponent}         from './myself/myself.component';
import {RightsComponent}         from './users/rights.component';
import {UsersComponent}          from './users/users.component';

import {AuthService}             from './authentication/auth.service';
import {UserService}             from './services/user.service';
import {UserUrlService}          from './services/user_url.service';

import {UserTypePipe}          from './pipes/user_type.pipe';

import {TokenInterceptor}        from './authentication/token.interceptor';
import {ErrorInterceptor}        from './authentication/error.interceptor';

import 'hammerjs/hammer'; // for MatSlideToggleModule
import * as moment from 'moment';

const SUBTIL_DATE_FORMATS = {
  parse: {
    dateInput: 'LL',
  },
  display: {
    dateInput: 'LL',
    monthYearLabel: 'MMM YYYY',
    dateA11yLabel: 'LL',
    monthYearA11yLabel: 'MMMM YYYY',
  },
};

@NgModule({
  exports: [
    RouterModule
  ],
  imports: [
    AppRoutingModule,
    BrowserAnimationsModule,
    BrowserModule,
    FormsModule,
    HttpClientModule,
    MatButtonModule,
    MatCardModule,
    MatCheckboxModule,
    MatDatepickerModule,
    MatDialogModule,
    MatIconModule,
    MatInputModule,
    MatListModule,
    MatMenuModule,
    MatMomentDateModule,
    MatPaginatorModule,
    MatRadioModule,
    MatSelectModule,
    MatSidenavModule,
    MatSlideToggleModule,
    MatStepperModule,
    MatTableModule,
    MatToolbarModule,
    SocketModule,
    StorageServiceModule,
  ],
  declarations: [
    AppComponent,
    ConfirmComponent,
    DashboardComponent,
    MyselfComponent,
    LoginComponent,
    RightsComponent,
    UsersComponent,
    UserTypePipe,
  ],
  entryComponents: [
    RightsComponent,
  ],
  providers: [
    {
      provide: APP_BASE_HREF,
      useValue: '/'
    },
    {
      provide: MAT_DATE_LOCALE,
      useValue: 'fr-FR'
    },
    {
      provide: DateAdapter,
      useClass: MomentDateAdapter,
      deps: [MAT_DATE_LOCALE]
    },
    {
      provide: MAT_DATE_FORMATS,
      useValue: SUBTIL_DATE_FORMATS
    },
    {
      provide: HTTP_INTERCEPTORS,
      useClass: TokenInterceptor,
      multi: true
    },
    {
      provide: HTTP_INTERCEPTORS,
      useClass: ErrorInterceptor,
      multi: true
    },
    AuthService,
    CookieService,
    UserService,
    UserUrlService,
  ],
  bootstrap: [
    AppComponent
  ]
})

export class AppModule { }
