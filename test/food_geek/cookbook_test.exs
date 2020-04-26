defmodule FoodGeek.CookbookTest do
  use FoodGeek.DataCase

  alias FoodGeek.Cookbook

  describe "recipes" do
    alias FoodGeek.Cookbook.Recipe

    @valid_attrs %{active_time_in_min: 42, description: "some description", number_of_servings: 42, title: "some title", total_time_in_min: 42}
    @update_attrs %{active_time_in_min: 43, description: "some updated description", number_of_servings: 43, title: "some updated title", total_time_in_min: 43}
    @invalid_attrs %{active_time_in_min: nil, description: nil, number_of_servings: nil, title: nil, total_time_in_min: nil}

    def recipe_fixture(attrs \\ %{}) do
      {:ok, recipe} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Cookbook.create_recipe()

      recipe
    end

    test "list_recipes/0 returns all recipes" do
      recipe = recipe_fixture()
      assert Cookbook.list_recipes() == [recipe]
    end

    test "get_recipe!/1 returns the recipe with given id" do
      recipe = recipe_fixture()
      assert Cookbook.get_recipe!(recipe.id) == recipe
    end

    test "create_recipe/1 with valid data creates a recipe" do
      assert {:ok, %Recipe{} = recipe} = Cookbook.create_recipe(@valid_attrs)
      assert recipe.active_time_in_min == 42
      assert recipe.description == "some description"
      assert recipe.number_of_servings == 42
      assert recipe.title == "some title"
      assert recipe.total_time_in_min == 42
    end

    test "create_recipe/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cookbook.create_recipe(@invalid_attrs)
    end

    test "update_recipe/2 with valid data updates the recipe" do
      recipe = recipe_fixture()
      assert {:ok, %Recipe{} = recipe} = Cookbook.update_recipe(recipe, @update_attrs)
      assert recipe.active_time_in_min == 43
      assert recipe.description == "some updated description"
      assert recipe.number_of_servings == 43
      assert recipe.title == "some updated title"
      assert recipe.total_time_in_min == 43
    end

    test "update_recipe/2 with invalid data returns error changeset" do
      recipe = recipe_fixture()
      assert {:error, %Ecto.Changeset{}} = Cookbook.update_recipe(recipe, @invalid_attrs)
      assert recipe == Cookbook.get_recipe!(recipe.id)
    end

    test "delete_recipe/1 deletes the recipe" do
      recipe = recipe_fixture()
      assert {:ok, %Recipe{}} = Cookbook.delete_recipe(recipe)
      assert_raise Ecto.NoResultsError, fn -> Cookbook.get_recipe!(recipe.id) end
    end

    test "change_recipe/1 returns a recipe changeset" do
      recipe = recipe_fixture()
      assert %Ecto.Changeset{} = Cookbook.change_recipe(recipe)
    end
  end
end
