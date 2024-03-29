defmodule Site.Accounts.Role do
  use Ecto.Schema
  import Ecto.Changeset

  schema "roles" do
    field :name, :string

    timestamps()
  end

  @doc """
  A role changeset for insertion.
  """
  def registration_changeset(role, attrs, _opts \\ []) do
    role
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  def is_admin(user) do
    user && user.roles && Enum.any?(user.roles, fn r -> r.name == "admin" end)
  end
end
