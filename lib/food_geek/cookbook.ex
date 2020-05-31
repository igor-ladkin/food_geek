defmodule FoodGeek.Cookbook do
  @moduledoc """
  The Cookbook context.
  """

  import Ecto.Query, warn: false
  alias Ecto.Changeset
  alias FoodGeek.Repo

  alias FoodGeek.Accounts
  alias FoodGeek.Cookbook.Recipe

  def list_recipes(query \\ Recipe) do
    query
    |> Recipe.including_chef()
    |> Repo.all()
  end

  def list_chef_recipes(%Accounts.User{} = chef) do
    Recipe.for_chef(chef)
    |> Repo.all()
  end

  def list_published_recipes do
    Recipe.published()
    |> list_recipes()
  end

  def get_recipe!(query \\ Recipe, id) do
    query
    |> Recipe.including_chef()
    |> Repo.get!(id)
  end

  def get_published_recipe!(id) do
    Recipe.published()
    |> get_recipe!(id)
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

  def publish_recipe(%Recipe{published_at: nil} = recipe) do
    recipe
    |> Recipe.publish_changeset(%{published_at: DateTime.utc_now()})
    |> Repo.update()
  end

  def publish_recipe(%Recipe{}) do
    {:error, :already_published}
  end

  def unpublish_recipe(%Recipe{published_at: nil}) do
    {:error, :not_published}
  end

  def unpublish_recipe(%Recipe{} = recipe) do
    recipe
    |> Recipe.unpublish_changeset()
    |> Repo.update()
  end

  def delete_recipe(%Recipe{} = recipe) do
    Repo.delete(recipe)
  end

  def change_recipe(%Recipe{} = recipe) do
    Recipe.changeset(recipe, %{})
  end
end
