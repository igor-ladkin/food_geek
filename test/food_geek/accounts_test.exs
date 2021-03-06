defmodule FoodGeek.AccountsTest do
  use FoodGeek.DataCase

  alias FoodGeek.Accounts

  describe "users" do
    alias Accounts.User

    test "get_user/1 returns the user with given id" do
      user = insert!(:user)
      assert Accounts.get_user(user.id) == user
    end

    test "get_user_by/1 returns the user with given search clauses" do
      user = insert!(:user)
      assert Accounts.get_user_by(email: user.email) == user
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

    test "register_user/1 with valid data creates a user and hashes his password" do
      registration_params = %{
        email: "mike@gmail.com",
        name: "Mike Brown",
        password: "password",
        password_confirmation: "password"
      }

      assert {:ok, %User{} = user} = Accounts.register_user(registration_params)

      assert user.email == "mike@gmail.com"
      assert user.name == "Mike Brown"
      assert user.password_hash
    end

    test "register_user/1 without password confirmation returns error changeset" do
      registration_params = %{
        email: "mike@gmail.com",
        name: "Mike Brown",
        password: "password"
      }

      assert {:error, changeset} = Accounts.register_user(registration_params)
      assert changeset.errors[:password_confirmation]
    end

    test "register_user/1 with wrong password confirmation returns error changeset" do
      registration_params = %{
        email: "mike@gmail.com",
        name: "Mike Brown",
        password: "password",
        password_confirmation: "psswrd"
      }

      assert {:error, changeset} = Accounts.register_user(registration_params)
      assert changeset.errors[:password_confirmation]
    end

    test "register_user/1 with email from non-existing mail server returns error changeset" do
      registration_params = %{
        email: "mike@badexample.com",
        name: "Mike Brown",
        password: "password",
        password_confirmation: "password"
      }

      assert {:error, changeset} = Accounts.register_user(registration_params)
      assert changeset.errors[:email]
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
      assert user == Accounts.get_user(user.id)
    end

    test "change_user/1 returns a user changeset" do
      user = insert!(:user)
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end

    test "authenticate_by/1 with correct email and password returns an :ok tuple with user" do
      user = insert!(:user, email: "kobe@nba.com")
      assert {:ok, ^user} = Accounts.authenticate_by(email: "kobe@nba.com", password: "password")
    end

    test "authenticate_by/1 with wrong email or password returns an :error tuple with message" do
      insert!(:user, email: "kobe@nba.com")

      assert {:error, message} =
               Accounts.authenticate_by(email: "kobe@nba.com", password: "black24mamba")
    end
  end
end
