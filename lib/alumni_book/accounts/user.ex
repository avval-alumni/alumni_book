defmodule AlumniBook.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias AlumniBook.Accounts.User

  schema "users" do
    field(:email, :string)
    field(:facebook_id, :string)
    field(:facebook_token, :binary)
    field(:linkedin_id, :string)
    field(:linkedin_token, :binary)
    field(:github_id, :string)
    field(:github_token, :binary)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:avatar, :string)
    field(:type, UserTypeEnum)
    timestamps()
  end

  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [
      :email,
      :facebook_id,
      :facebook_token,
      :linkedin_id,
      :linkedin_token,
      :github_id,
      :github_token,
      :first_name,
      :last_name,
      :avatar,
      :type
    ])
    |> unique_oauth_account
  end

  def create_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [
      :email,
      :facebook_id,
      :facebook_token,
      :linkedin_id,
      :linkedin_token,
      :github_id,
      :github_token,
      :first_name,
      :last_name,
      :avatar,
      :type
    ])
    |> unique_oauth_account
  end

  defp unique_oauth_account(changeset) do
    changeset
    # |> validate_format(:linkedin_id, ~r/@/)
    # |> validate_length(:email, max: 254)
    |> unique_constraint(:facebook_id)
    |> unique_constraint(:linkedin_id)
    |> unique_constraint(:github_id)
  end
end
