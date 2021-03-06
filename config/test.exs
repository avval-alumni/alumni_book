use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :alumni_book, AlumniBookWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :alumni_book, AlumniBook.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "alumni_book_test",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
