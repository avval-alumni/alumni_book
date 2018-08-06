defmodule AlumniBookWeb.Router do
  @moduledoc false

  use AlumniBookWeb, :router
  require Ueberauth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
    plug(Phauxth.Authenticate, method: :token)
  end

  scope "/auth", AlumniBookWeb do
    pipe_through [:browser]

    get("/:provider", AuthController, :request)
    get("/:provider/callback", AuthController, :callback)
    post("/:provider/callback", AuthController, :callback)
    delete("/logout", AuthController, :delete)
  end


  # scope "/link", AlumniBookWeb do
  #   pipe_through [:browser]

  #   get("/:provider", LinkController, :request)
  #   get("/:provider/callback", LinkController, :callback)
  #   post("/:provider/callback", LinkController, :callback)
  # end

  scope "/api", AlumniBookWeb do
    pipe_through [:api]

    get("/myself", UserController, :myself)
    put("/myself", UserController, :update)

    resources("/users", UserController, except: [:new, :edit]) do
      get("/github_url", UserUrlController, :get_github_url)
      get("/linkedin_url", UserUrlController, :get_linkedin_url)
    end


    # get("/link/:provider", LinkController, :request)
  end

  scope "/", AlumniBookWeb do
    pipe_through :browser # Use the default browser stack

    get("/*path", PageController, :index)
  end
end
