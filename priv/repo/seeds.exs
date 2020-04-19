# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     FoodGeek.Repo.insert!(%FoodGeek.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias FoodGeek.Accounts

users = [
  %{
    name: "Seth Rogen",
    email: "seth@pe.com",
    password: "password",
    password_confirmation: "password"
  },
  %{
    name: "James Franco",
    email: "james@pe.com",
    password: "password",
    password_confirmation: "password"
  },
  %{
    name: "Gordon Ramsay",
    email: "gordon@hk.com",
    password: "password",
    password_confirmation: "password"
  },
  %{
    name: "Jiro Ono",
    email: "jiro@sushi.com",
    password: "password",
    password_confirmation: "password"
  }
]

Enum.each(users, &Accounts.register_user/1)
