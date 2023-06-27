defmodule Site.Bookmarks do
  alias Site.Bookmarks.Bookmark
  @moduledoc """
  The Booksmarks context.
  """

  import Ecto.Query, warn: false
  alias Site.Repo

  def get_user_bookmarks(user) do
    Repo.all(from b in Bookmark,
      where: b.user_id == ^user.id)
  end

  def add_bookmark(%{} = attrs) do
    %Bookmark{}
    |> Bookmark.changeset(attrs)
    |> Repo.insert()
  end
end
