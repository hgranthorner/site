defmodule SiteWeb.ManageUsersLive do
  alias Site.Accounts
  alias Site.Accounts.Role
  use SiteWeb, :live_view
  def mount(_params, _session, socket) do
    users = Accounts.get_users()
    {:ok, assign(socket, users: users)}
  end

  def render(assigns) do
    ~H"""
    <h1 class="text-[2rem] mt-4 font-semibold leading-10 tracking-tighter text-zinc-900 mb-4">Users</h1>
    <table class="border">
      <tr>
        <th class="p-1 text-center">Email</th>
        <th class="p-1 text-center">Is Admin?</th>
      </tr>
      <tbody>
        <%= for user <- @users do %>
          <tr>
            <td class="p-1 text-center"><%= user.email %></td>
            <td class="p-1 text-center">
                <input 
                  phx-click="toggle_admin" 
                  phx-value-user-id={user.id}
                  type="checkbox"
                  checked={Role.is_admin(user)}
                >
            </td>
          </tr>
        <% end %>
      </tbody>
    </table>
    """
  end

  # Value is a map; will include key "value" => "on" if toggled on
  def handle_event("toggle_admin", %{"user-id" => user_id, "value" => "on"}, socket) do
    IO.inspect(users: Enum.map(socket.assigns.users, fn u -> u.id end))
    user = Enum.find(socket.assigns.users, fn u -> u.id == String.to_integer(user_id) end)
    IO.inspect(toggle_on: Integer.parse(user_id))
    IO.inspect(toggle_on_user: user)
    Accounts.change_role(user, :add, "admin")
    {:noreply, socket}
  end

  # Value is a map; will include key "value" => "on" if toggled on
  def handle_event("toggle_admin", %{"user-id" => user_id}, socket) do
    IO.inspect(users: Enum.map(socket.assigns.users, fn u -> u.id end))
    user = Enum.find(socket.assigns.users, fn u -> u.id == String.to_integer(user_id) end)
    IO.inspect(toggle_off: user_id)
    IO.inspect(toggle_off_user: user)
    Accounts.change_role(user, :remove, "admin")
    {:noreply, socket}
  end

end
