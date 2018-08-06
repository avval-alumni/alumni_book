defmodule AlumniBook.Migration.CreateUsers do
  use Ecto.Migration

  def change do
    UserTypeEnum.create_type
    
    create table(:users) do
      add(:email, :string)
      add(:linkedin_id, :string)
      add(:linkedin_token, :binary)
      add(:github_id, :string)
      add(:github_token, :binary)
      add(:first_name, :string)
      add(:last_name, :string)
      add(:avatar, :string)
      add(:type, :user_type)

      timestamps()
    end

    create(unique_index(:users, [
      :linkedin_id,
      :github_id
    ]))
  end
end
