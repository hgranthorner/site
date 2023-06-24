defmodule Site.Accounts.UserRole do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users_roles" do
    belongs_to :user, Site.Accounts.User
    belongs_to :role, Site.Accounts.Role
  end
end