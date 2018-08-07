defmodule AlumniBookWeb.UserUrlController do
  use AlumniBookWeb, :controller

  import AlumniBookWeb.Authorize
  alias AlumniBook.Accounts

  action_fallback(AlumniBookWeb.FallbackController)

  plug(
    :user_check
    when action in [
           :get_github_url,
           :get_linkedin_url
         ]
  )

  def get_github_url(conn, %{"user_id" => user_id}) do
    user = Accounts.get(user_id |> String.to_integer())

    url =
      case user.github_id do
        nil ->
          nil

        id ->
          "https://api.github.com/user/#{id}"
          |> HTTPoison.get!()
          |> Map.get(:body)
          |> Poison.decode!()
          |> Map.get("html_url")
      end

    render(conn, "show.json", user_url: url)
  end

  def get_linkedin_url(conn, %{"user_id" => user_id}) do
    user = Accounts.get(user_id |> String.to_integer())

    headers = [Authorization: "Bearer " <> user.linkedin_token]

    url =
      case user.linkedin_id do
        nil ->
          nil

        id ->
          "https://api.linkedin.com/v1/people/~?format=json"
          |> HTTPoison.get!(headers)
          |> Map.get(:body)
          |> Poison.decode!()
          |> Map.get("siteStandardProfileRequest")
          |> Map.get("url")
      end

    render(conn, "show.json", user_url: url)
  end
end
