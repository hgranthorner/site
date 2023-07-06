defmodule Site.Bookmarks.Bookmark do
  alias Site.Bookmarks.Bookmark
  use Ecto.Schema
  import Ecto.Changeset

  schema "bookmarks" do
    field :url, :string
    field :name, :string
    belongs_to :user, Site.Accounts.User

    timestamps()
  end

  def changeset() do
    %Bookmark{}
    |> cast(%{}, [:url, :name, :user_id])
    |> validate_required([:url, :name, :user_id])
  end

  def changeset(%Bookmark{} = bkmk, attrs, opts \\ []) do
    bkmk
    |> cast(attrs, [:url, :name, :user_id], opts)
    |> validate_required([:url, :name, :user_id])
    |> unique_constraint(:name)
  end
end
