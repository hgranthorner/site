defmodule SiteWeb.BookmarksLive do
  use SiteWeb, :live_view
  alias Site.Bookmarks
  alias Site.Bookmarks.Bookmark

  def render(assigns) do
    ~H"""
    <.header class="text-center">
      Your Bookmarks
      <:subtitle>Manage your bookmarks and add more</:subtitle>
    </.header>

    <div class="space-y-12 divide-y">
      <ul>
        <li :for={bkmk <- @bookmarks}>
          <div class="mb-2">
            <p><%= bkmk.name %></p>
            <a href={bkmk.url}><%= bkmk.url %></a>
          </div>
        </li>
     </ul>
      <div>
        <.simple_form
          for={@bookmark_form}
          id="bookmark_form"
          phx-submit="add_bookmark"
          phx-change="validate_bookmark"
        >
          <.input field={@bookmark_form[:name]} type="text" label="Name" required />
          <.input field={@bookmark_form[:url]} type="text" label="Url" required />
          <:actions>
            <.button phx-disable-with="Adding...">Add</.button>
          </:actions>
        </.simple_form>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    user = socket.assigns.current_user
    bkmks = Bookmarks.get_user_bookmarks(user)

    socket =
      socket
      |> assign(:bookmarks, bkmks)
      |> assign(:bookmark_form, new_bookmark_form())
      |> assign(:trigger_submit, false)

    {:ok, socket}
  end

  def handle_event(
        "validate_bookmark",
        %{"bookmark" => bookmark},
        socket
      ) do
    user = socket.assigns.current_user

    attrs =
      Map.put(bookmark, "user_id", user.id)
      |> Map.new(fn {k, v} -> {String.to_atom(k), v} end)

    bkmk_form =
      %Bookmark{}
      |> Bookmark.changeset(attrs)
      |> Map.put(:action, :validate)
      |> to_form()

    {:noreply, assign(socket, bookmark_form: bkmk_form)}
  end

  def handle_event(
        "add_bookmark",
        %{"bookmark" => bookmark},
        socket
      ) do
    user = socket.assigns.current_user
    bkmks = socket.assigns.bookmarks

    attrs =
      Map.put(bookmark, "user_id", user.id)
      |> Map.new(fn {k, v} -> {String.to_atom(k), v} end)

    socket = case Bookmarks.add_bookmark(attrs) do
      {:ok, bkmk} -> socket
        |> assign(bookmarks: [bkmk | bkmks])
        |> assign(bookmark_form: new_bookmark_form())
      {:error, changeset} -> socket
        |> assign(bookmark_form: to_form(changeset))
    end

    {:noreply, socket}
  end

  defp new_bookmark_form, do: Bookmark.changeset() |> to_form()
end
