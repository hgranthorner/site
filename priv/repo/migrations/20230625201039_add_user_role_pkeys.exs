defmodule Site.Repo.Migrations.AddUserRolePkeys do
  use Ecto.Migration

  def up do
    drop table(:users_roles)
    create table(:users_roles, primary_key: false) do
      add :user_id, references(:users, on_delete: :delete_all), null: false, primary_key: true
      add :role_id, references(:roles, on_delete: :delete_all), null: false, primary_key: true
    end
  end

  def down do
    drop table(:users_roles)
    create table(:users_roles, primary_key: false) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :role_id, references(:roles, on_delete: :delete_all), null: false
    end
  end
end
