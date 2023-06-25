defmodule Site.Accounts.UserRole do
  use Ecto.Schema

  @primary_key false
  schema "users_roles" do
    belongs_to :user, Site.Accounts.User, primary_key: true
    belongs_to :role, Site.Accounts.Role, primary_key: true
  end
end
