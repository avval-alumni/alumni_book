# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :alumni_book, AlumniBookWeb.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  render_errors: [accepts: ~w(html json)],
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  pubsub: [name: AlumniBook.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure the Ecto Repos
config :alumni_book, ecto_repos: [AlumniBook.Repo]

# Phauxth authentication configuration
config :phauxth,
  token_salt: "KBPzeh/8",
  endpoint: ExSubtilBackendWeb.Endpoint

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

config :ueberauth, Ueberauth,
  providers: [
    facebook: { Ueberauth.Strategy.Facebook, [] },
    github: { Ueberauth.Strategy.Github, [default_scope: "user"] },
    google: { Ueberauth.Strategy.Google, [] },
    identity: { Ueberauth.Strategy.Identity, [
        callback_methods: ["POST"],
        uid_field: :username,
        nickname_field: :username,
      ] },
    linkedin: {Ueberauth.Strategy.LinkedIn, [default_scope: "r_basicprofile r_emailaddress"]},
    # linkedin: {Ueberauth.Strategy.LinkedIn, [default_scope: "r_basicprofile r_emailaddress rw_company_admin w_share"]},
    slack: { Ueberauth.Strategy.Slack, [] },
    twitter: { Ueberauth.Strategy.Twitter, []}
  ]

config :ueberauth, Ueberauth.Strategy.Facebook.OAuth,
  client_id: System.get_env("FACEBOOK_APP_ID"),
  client_secret: System.get_env("FACEBOOK_APP_SECRET"),
  redirect_uri: System.get_env("FACEBOOK_REDIRECT_URI")

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: "640da9fd50b87ea782d1",
  client_secret: "b52ed9f2a202c84ae3236be64dc4efeabeeb1ff7"

config :ueberauth, Ueberauth.Strategy.LinkedIn.OAuth,
  client_id: "86qm5i5f4h3y0g",
  client_secret: "sWnrHcyN28mBmzjw"

config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: System.get_env("GOOGLE_CLIENT_ID"),
  client_secret: System.get_env("GOOGLE_CLIENT_SECRET"),
  redirect_uri: System.get_env("GOOGLE_REDIRECT_URI")

config :ueberauth, Ueberauth.Strategy.Slack.OAuth,
  client_id: System.get_env("SLACK_CLIENT_ID"),
  client_secret: System.get_env("SLACK_CLIENT_SECRET")

config :ueberauth, Ueberauth.Strategy.Twitter.OAuth,
  consumer_key: System.get_env("TWITTER_CONSUMER_KEY"),
  consumer_secret: System.get_env("TWITTER_CONSUMER_SECRET")

config :dogma,
  rule_set: Dogma.RuleSet.All
