defmodule Site.Accounts.RoleTest do
  use Site.DataCase

  alias Site.Accounts.{Role, User}

  defp user_fixture(roles \\ []) do
    %User{email: "", password: "", hashed_password: "", confirmed_at: nil, roles: roles}
  end

  describe "is_admin/1" do
    test "confirms that a user is an admin" do
      user = user_fixture([%Role{name: "admin"}])
      assert Role.is_admin(user)
    end

    test "denies that a user is not an admin" do
      user = user_fixture()
      refute Role.is_admin(user)
    end

    test "denies an nil user" do
      refute Role.is_admin(nil)
    end
  end
end
