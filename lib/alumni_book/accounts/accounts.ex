defmodule AlumniBook.Accounts do
  @moduledoc """
  The boundary for the Accounts system.
  """

  import Ecto.{Query, Changeset}, warn: false
  alias AlumniBook.{Accounts.User, Repo}

  defp force_integer(param) when is_bitstring(param) do
    param
    |> String.to_integer()
  end

  defp force_integer(param) do
    param
  end

  def list_users(params \\ %{}) do
    page =
      Map.get(params, "page", 0)
      |> force_integer

    size =
      Map.get(params, "size", 10)
      |> force_integer

    offset = page * size

    query = from(user in User)

    total_query = from(item in query, select: count(item.id))

    total =
      Repo.all(total_query)
      |> List.first()

    query =
      from(
        user in query,
        order_by: [desc: :inserted_at],
        offset: ^offset,
        limit: ^size
      )

    users = Repo.all(query)

    %{
      data: users,
      total: total,
      page: page,
      size: size
    }
  end

  def get(id), do: Repo.get(User, id)

  def get_by(%{"linkedin_id" => linkedin_id}) do
    Repo.get_by(User, linkedin_id: linkedin_id)
  end

  def create_user(attrs) do
    %User{}
    |> User.create_changeset(attrs)
    |> Repo.insert()
  end

  def find_or_create_user(attrs) do
    if Map.has_key?(attrs, :linkedin_id) do
      case Repo.get_by(User, linkedin_id: attrs.linkedin_id) do
        nil -> create_user(attrs)
        user -> {:ok, user}
      end
    else
      case Repo.get_by(User, github_id: attrs.github_id) do
        nil -> create_user(attrs)
        user -> {:ok, user}
      end
    end
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end
end