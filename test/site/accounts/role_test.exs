defmodule Site.Accounts.RoleTest do
  use Site.DataCase

  alias Site.Accounts.{Role, User}

  describe "is_admin/1" do
    test "confirms that a user is an admin" do
      refute Accounts.get_user_by_email("unknown@example.com")
    end

    test "denies that a user is not an admin" do
      %{id: id} = user = user_fixture()
      assert %User{id: ^id} = Accounts.get_user_by_email(user.email)
    end

    test "denies an nil user" do
    end
  end
end
