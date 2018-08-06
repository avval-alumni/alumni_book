
import {Component} from '@angular/core';
import {ActivatedRoute, Router} from '@angular/router';

import {UserService} from '../services/user.service';
import {User} from '../models/user';

@Component({
  selector: 'myself-component',
  templateUrl: 'myself.component.html',
  styleUrls: ['./myself.component.less'],
})

export class MyselfComponent {
  myself: User;

  usertypes = [
    {
      "id": "student",
      "label": "Student"
    },
    {
      "id": "alumni",
      "label": "Alumni"
    },
    {
      "id": "professor",
      "label": "Professor"
    },
  ];

  constructor(
    private userService: UserService,
    private route: ActivatedRoute,
    private router: Router
  ) {}

  ngOnInit() {
    this.userService.getMyself()
    .subscribe(myself => {
      this.myself = myself;
    });
  }

  updateUser(event: any) {
    this.userService.updateMyself(event)
    .subscribe(response => {
    });
  }

  connect_linkedin() {
    window.open("/api/link/linkedin");//, "_blank");
  }

  disconnect_linkedin() {
  }

  connect_github() {
  }

  disconnect_github() {
  }
}