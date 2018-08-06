defmodule AlumniBookWeb.UserView do
  use AlumniBookWeb, :view
  alias AlumniBookWeb.UserView

  def render("index.json", %{users: %{data: users, total: total}}) do
    %{
      data: render_many(users, UserView, "user.json"),
      total: total
    }
  end

  def render("show.json", %{user: user}) do
    render_one(user, UserView, "user.json")
  end

  def render("user.json", %{user: user}) do
    IO.inspect user
    %{
      id: user.id,
      github_id: user.github_id,
      linkedin_id: user.linkedin_id,
      first_name: user.first_name,
      last_name: user.last_name,
      email: user.email,
      avatar: user.avatar,
      type: user.type,
    }
  end
end
