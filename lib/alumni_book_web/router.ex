defmodule AlumniBookWeb.Router do
  @moduledoc false

  use AlumniBookWeb, :router
  require Ueberauth

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
    plug(:fetch_session)
    plug(Phauxth.Authenticate, method: :token)
  end

  scope "/auth", AlumniBookWeb do
    pipe_through([:browser])

    get("/:provider", AuthController, :request)
    get("/:provider/callback", AuthController, :callback)
    post("/:provider/callback", AuthController, :callback)
    delete("/logout", AuthController, :delete)
  end

  scope "/api", AlumniBookWeb do
    pipe_through([:api])

    get("/myself", UserController, :myself)
    put("/myself", UserController, :update)

    resources("/users", UserController, except: [:new, :edit]) do
      get("/facebook_url", UserUrlController, :get_facebook_url)
      get("/github_url", UserUrlController, :get_github_url)
      get("/linkedin_url", UserUrlController, :get_linkedin_url)
    end

    get("/link/:provider", LinkController, :request)
    get("/link/:provider/callback", LinkController, :callback)
    post("/link/:provider/callback", LinkController, :callback)
  end

  scope "/", AlumniBookWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/*path", PageController, :index)
  end
end
