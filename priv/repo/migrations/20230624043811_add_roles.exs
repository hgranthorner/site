defmodule Site.Repo.Migrations.AddRoles do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add :name, :string, null: false, collate: :nocase
      timestamps()
    end

    create table(:users_roles) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :role_id, references(:roles, on_delete: :delete_all), null: false
    end
  end
end
