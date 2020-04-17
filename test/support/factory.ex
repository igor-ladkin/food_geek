defmodule FoodGeek.Factory do
  alias FoodGeek.Repo

  # Factories

  def build(:user) do
    %FoodGeek.Accounts.User{
      email: "hello#{System.unique_integer()}@example.com",
      name: "James Dean"
    }
  end

  # Convenience API

  def build(factory_name, attributes) do
    factory_name |> build() |> struct(attributes)
  end

  def attributes(factory_name, attributes \\ []) do
    build(factory_name, attributes) |> Map.from_struct()
  end

  def insert!(factory_name, attributes \\ []) do
    Repo.insert!(build(factory_name, attributes))
  end
end
