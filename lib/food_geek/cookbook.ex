defmodule FoodGeek.Cookbook do
  @moduledoc """
  The Cookbook context.
  """

  import Ecto.Query, warn: false
  alias Ecto.Changeset
  alias FoodGeek.Repo

  alias FoodGeek.Accounts
  alias FoodGeek.Cookbook.Recipe

  def list_recipes do
    Recipe.including_chef()
    |> Repo.all()
  end

  def list_chef_recipes(%Accounts.User{} = chef) do
    Recipe.for_chef(chef)
    |> Repo.all()
  end

  def get_recipe!(id) do
    Recipe.including_chef()
    |> Repo.get!(id)
  end

  def get_chef_recipe!(%Accounts.User{} = chef, id) do
    chef
    |> Recipe.for_chef()
    |> Recipe.including_chef()
    |> Repo.get!(id)
  end

  def create_recipe(%Accounts.User{} = chef, attrs \\ %{}) do
    %Recipe{}
    |> Recipe.changeset(attrs)
    |> Changeset.put_assoc(:chef, chef)
    |> Repo.insert()
  end

  def update_recipe(%Recipe{} = recipe, attrs) do
    recipe
    |> Recipe.changeset(attrs)
    |> Repo.update()
  end

  def delete_recipe(%Recipe{} = recipe) do
    Repo.delete(recipe)
  end

  def change_recipe(%Recipe{} = recipe) do
    Recipe.changeset(recipe, %{})
  end
end
