defmodule AlumniBookWeb.UserController do
  use AlumniBookWeb, :controller

  import AlumniBookWeb.Authorize
  # alias Phauxth.Log
  alias AlumniBook.Accounts

  action_fallback(AlumniBookWeb.FallbackController)

  # the following plugs are defined in the controllers/authorize.ex file
  plug(:user_check when action in [:index, :show, :myself, :update, :delete])

  def index(conn, params) do
    users = Accounts.list_users(params)
    render(conn, "index.json", users: users)
  end

  def show(%Plug.Conn{assigns: %{current_user: user}} = conn, %{"id" => id}) do
    user = (id == to_string(user.id) and user) || Accounts.get(id)
    render(conn, "show.json", user: user)
  end

  def myself(%Plug.Conn{assigns: %{current_user: user}} = conn, _) do
    user = Accounts.get(user.id)
    render(conn, "show.json", user: user)
  end

  def update(%Plug.Conn{assigns: %{current_user: user}} = conn, %{
        "user" => user_params
      }) do
    with {:ok, user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def update(%Plug.Conn{assigns: %{current_user: _user}} = conn, params) do
    IO.inspect(params)
    send_resp(conn, 403, "unable to update yourself")
  end

  def delete(%Plug.Conn{assigns: %{current_user: user}} = conn, params) do
    selected_user = Accounts.get(Map.get(params, "id") |> String.to_integer())

    if selected_user.id != user.id do
      {:ok, _user} = Accounts.delete_user(selected_user)
      send_resp(conn, :no_content, "")
    else
      send_resp(conn, 403, "unable to delete yourself")
    end
  end
end
