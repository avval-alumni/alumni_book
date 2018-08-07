defmodule AlumniBookWeb.Endpoint do
  @moduledoc false

  use Phoenix.Endpoint, otp_app: :alumni_book

  socket("/socket", AlumniBookWeb.UserSocket)

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phoenix.digest
  # when deploying your static files in production.

  plug(CORSPlug, origin: ["https://www.linkedin.com/uas/oauth2/authorization"])

  plug(Plug.Static,
    at: "/",
    from: :alumni_book,
    gzip: false,
    only: ~w(favicon.ico robots.txt bundles)
  )

  # plug Plug.Static,
  #   at: "/", from: :alumni_book, gzip: false,
  #   only: ~w(css fonts images js favicon.ico robots.txt)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket("/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket)
    plug(Phoenix.LiveReloader)
    plug(Phoenix.CodeReloader)
  end

  plug(Plug.RequestId)
  plug(Plug.Logger)

  plug(Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison
  )

  plug(Plug.MethodOverride)
  plug(Plug.Head)

  plug(Plug.Session,
    store: :cookie,
    key: "_alumni_book_key",
    signing_salt: "pJYawTy2"
  )

  plug(AlumniBookWeb.Router)
end
