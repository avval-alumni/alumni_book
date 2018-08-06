defmodule AlumniBookWeb.UserUrlView do
  use AlumniBookWeb, :view
  alias AlumniBookWeb.UserUrlView

  def render("show.json", %{user_url: user_url}) do
    render_one(user_url, UserUrlView, "user_url.json")
  end

  def render("user_url.json", %{user_url: user_url}) do
    %{
      url: user_url,
    }
  end
end
