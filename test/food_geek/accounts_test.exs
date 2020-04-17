defmodule FoodGeek.AccountsTest do
  use FoodGeek.DataCase

  alias FoodGeek.Accounts

  describe "users" do
    alias Accounts.User

    test "get_user!/1 returns the user with given id" do
      user = insert!(:user)
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} =
               Accounts.create_user(%{email: "mike@gmail.com", name: "Mike Brown"})

      assert user.email == "mike@gmail.com"
      assert user.name == "Mike Brown"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(%{email: nil, name: nil})
    end

    test "update_user/2 with valid data updates the user" do
      user = insert!(:user)

      assert {:ok, %User{} = user} =
               Accounts.update_user(user, %{email: "james007@gmail.com", name: "James Bond"})

      assert user.email == "james007@gmail.com"
      assert user.name == "James Bond"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = insert!(:user)

      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, %{email: nil})
      assert user == Accounts.get_user!(user.id)
    end

    test "change_user/1 returns a user changeset" do
      user = insert!(:user)
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end