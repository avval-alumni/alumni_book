use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :alumni_book, AlumniBookWeb.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  cache_static_lookup: false,
  check_origin: false,
  watchers: [
    node: [
      "node_modules/webpack/bin/webpack.js",
      "--watch",
      "--watch-poll",
      "--mode=development",
      "--stdin",
      cd: Path.expand("../assets", __DIR__)
    ]
  ]

# Watch static and templates for browser reloading.
config :alumni_book, AlumniBookWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{lib/alumni_book_web/views/.*(ex)$},
      ~r{lib/alumni_book_web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

config :alumni_book, AlumniBookWeb.Endpoint,
  secret_key_base: "VQyOE7QLAMr0qyhIR+4/NtEK9G8DU+mdESssX4ZO0j05mchaW1VzebD2dZ+r9xCS"

# Set a higher stacktrace during development.
# Do not configure such in production as keeping
# and calculating stacktraces is usually expensive.
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :alumni_book, AlumniBook.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "alumni_book_dev",
  hostname: "localhost",
  pool_size: 10
