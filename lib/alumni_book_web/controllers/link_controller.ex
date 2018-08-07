defmodule AlumniBookWeb.LinkController do
  @moduledoc """
  Auth controller responsible for handling Ueberauth responses
  """

  use AlumniBookWeb, :controller
  plug(Ueberauth)

  alias Ueberauth.Strategy.Helpers

  def request(conn, _params) do
    render(conn, "request.html", callback_url: Helpers.callback_url(conn))
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
    IO.inspect(params)
    IO.inspect(auth)
    # case UserFromAuth.find_or_create(auth) do
    #   {:ok, user_changeset} ->
    #     {:ok, user} = AlumniBook.Accounts.find_or_create_user(user_changeset)
    #     token = Phauxth.Token.sign(conn, user.id)

    #     conn
    #     |> put_flash(:info, "Successfully authenticated.")
    #     |> put_session(:current_user, user)
    #     |> redirect(to: "/confirm?token=" <> token)
    #   {:error, reason} ->
    #     conn
    #     |> put_flash(:error, reason)
    #     |> redirect(to: "/")
    # end
  end
end
