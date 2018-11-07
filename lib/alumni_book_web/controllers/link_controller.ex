defmodule AlumniBookWeb.LinkController do
  @moduledoc """
  Auth controller responsible for handling Ueberauth responses
  """

  use AlumniBookWeb, :controller
  plug Ueberauth

  import AlumniBookWeb.Authorize
  alias Ueberauth.Strategy.Helpers
  alias AlumniBook.Accounts.User

  plug(:user_check when action in [:request, :callback])

  def request(conn, _params) do
    params = []
    opts = [
      redirect_uri: "http://localhost:4000/api/link/github/callback"
    ]
    url = Ueberauth.Strategy.Github.OAuth.authorize_url!(params, opts)

    conn
    |> json(%{redirect_url: url})
  end

  def callback(conn, %{"code" => code} = params, user) do
    params = [
      code: code
    ]
    opts = [
      redirect_uri: "http://localhost:4000/api/link/github/callback"
    ]
    
    response = Ueberauth.Strategy.Github.OAuth.get_token!(params, opts)

    {:ok, %{"id" => github_id}} = fetch_user(response.access_token)

    AlumniBook.Accounts.update_user(user, %{
      github_id: github_id |> Integer.to_string,
      github_token: response.access_token
    })

    conn
  end

  def callback(conn, %{"code" => code, "provider" => _provider}) do
    conn
    |> redirect(to: "/myself")
  end

  defp fetch_user(access_token) do
    case Ueberauth.Strategy.Github.OAuth.get(access_token, "/user") do
      {:ok, %OAuth2.Response{status_code: 401, body: _body}} ->
        {:error, "unauthorized"}
      {:ok, %OAuth2.Response{status_code: status_code, body: user}} when status_code in 200..399 ->
        case Ueberauth.Strategy.Github.OAuth.get(access_token, "/user/emails") do
          {:ok, %OAuth2.Response{status_code: status_code, body: emails}} when status_code in 200..399 ->
            user = Map.put user, "emails", emails
            {:ok, user}
          {:error, _} -> # Continue on as before
            {:ok, user}
        end
      {:error, %OAuth2.Error{reason: reason}} ->
        {:error, reason}
    end
  end
end
