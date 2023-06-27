defmodule Site.Repo.Migrations.AddBookmarks do
  use Ecto.Migration

  def change do
    create table(:bookmarks) do
      add :url, :string, null: false
      add :name, :string, null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false 

      timestamps()
    end
  end
end
