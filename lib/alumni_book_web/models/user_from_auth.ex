defmodule UserFromAuth do
  @moduledoc """
  Retrieve the user information from an auth request
  """
  require Logger
  require Poison

  alias Ueberauth.Auth

  def find_or_create(%Auth{provider: :identity} = auth) do
    case validate_pass(auth.credentials) do
      :ok ->
        {:ok, basic_info(auth)}
      {:error, reason} -> {:error, reason}
    end
  end

  def find_or_create(%Auth{} = auth) do
    {:ok, basic_info(auth)}
  end

  # github does it this way
  defp avatar_from_auth( %{info: %{urls: %{avatar_url: image}}}), do: image

  #facebook does it this way
  defp avatar_from_auth( %{info: %{image: image} }), do: image

  # default case if nothing matches
  defp avatar_from_auth( auth ) do
    Logger.warn auth.provider <> " needs to find an avatar URL!"
    Logger.debug(Poison.encode!(auth))
    nil
  end

  defp force_string(value) when is_integer(value) do
    value |> Integer.to_string
  end
  defp force_string(value), do: value

  defp basic_info(%{provider: :linkedin} = auth) do
    %{
      linkedin_id: auth.uid,
      linkedin_token: get_token(auth),
      name: name_from_auth(auth),
      email: auth.info.email,
      first_name: auth.info.first_name,
      last_name: auth.info.last_name,
      avatar: avatar_from_auth(auth)
    }
  end

  defp basic_info(%{provider: :github} = auth) do
    %{
      github_id: force_string(auth.uid),
      github_token: get_token(auth),
      name: name_from_auth(auth),
      email: auth.info.email,
      first_name: auth.info.first_name,
      last_name: auth.info.last_name,
      avatar: avatar_from_auth(auth)
    }
  end

  defp name_from_auth(auth) do
    if auth.info.name do
      auth.info.name
    else
      name = [auth.info.first_name, auth.info.last_name]
      |> Enum.filter(&(&1 != nil and &1 != ""))

      cond do
        length(name) == 0 -> auth.info.nickname
        true -> Enum.join(name, " ")
      end
    end
  end

  defp get_token(%Auth{credentials: %Auth.Credentials{token: token}}) do
    token
  end

  defp validate_pass(%{other: %{password: ""}}) do
    {:error, "Password required"}
  end
  defp validate_pass(%{other: %{password: pw, password_confirmation: pw}}) do
    :ok
  end
  defp validate_pass(%{other: %{password: _}}) do
    {:error, "Passwords do not match"}
  end
  defp validate_pass(_), do: {:error, "Password Required"}
end
