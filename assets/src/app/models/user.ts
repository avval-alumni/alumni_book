
export class Info {
  detail: string;
}

export class Confirm {
  info: Info;
}

export class UserUrl {
  url: string;
}

export class User {
  avatar: string;
  email: string;
  github_id: string;
  linkedin_id: string;
  rights: any;
}

export class Redirect {
  redirect_url: string;
}