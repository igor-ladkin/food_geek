defmodule FoodGeek.CookbookTest do
  use FoodGeek.DataCase

  alias FoodGeek.Cookbook

  describe "recipes" do
    alias FoodGeek.Cookbook.Recipe

    @valid_attrs %{
      active_time_in_min: 42,
      description: "some description",
      number_of_servings: 42,
      title: "some title",
      total_time_in_min: 42,
      image: %Plug.Upload{path: "test/support/recipe.jpg", filename: "recipe.jpg"}
    }
    @update_attrs %{
      active_time_in_min: 43,
      description: "some updated description",
      number_of_servings: 43,
      title: "some updated title",
      total_time_in_min: 43,
      image: %Plug.Upload{path: "test/support/recipe.jpg", filename: "recipe.jpg"}
    }
    @invalid_attrs %{
      active_time_in_min: nil,
      description: nil,
      number_of_servings: nil,
      title: nil,
      total_time_in_min: nil,
      image: nil
    }

    def recipe_fixture(attrs \\ %{}) do
      attrs = Enum.into(attrs, @valid_attrs)
      chef = FoodGeek.Accounts.get_user_by(email: "gordon@hk.com")

      {:ok, recipe} = Cookbook.create_recipe(chef, attrs)

      recipe
    end

    setup do
      chef = FoodGeek.Accounts.get_user_by(email: "gordon@hk.com")
      [chef: chef]
    end

    test "list_recipes/0 returns all recipes" do
      recipe = recipe_fixture()
      assert Cookbook.list_recipes() == [recipe]
    end

    test "get_recipe!/1 returns the recipe with given id" do
      recipe = recipe_fixture()
      assert Cookbook.get_recipe!(recipe.id) == recipe
    end

    test "create_recipe/2 with valid data creates a recipe", %{chef: chef} do
      assert {:ok, %Recipe{} = recipe} = Cookbook.create_recipe(chef, @valid_attrs)
      assert recipe.active_time_in_min == 42
      assert recipe.description == "some description"
      assert recipe.number_of_servings == 42
      assert recipe.title == "some title"
      assert recipe.total_time_in_min == 42
    end

    test "create_recipe/2 with invalid data returns error changeset", %{chef: chef} do
      assert {:error, %Ecto.Changeset{}} = Cookbook.create_recipe(chef, @invalid_attrs)
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

    test "publish_recipe/1 stores publication timestamp if it was not published before" do
      recipe = recipe_fixture()
      assert {:ok, %Recipe{} = recipe} = Cookbook.publish_recipe(recipe)
      assert recipe.published_at
    end

    test "publish_recipe/1 returns an error if recipe was published before" do
      recipe =
        recipe_fixture()
        |> Cookbook.publish_recipe()
        |> elem(1)

      assert {:error, :already_published} = Cookbook.publish_recipe(recipe)
    end

    test "unpublish_recipe/1 removes publication timestamp if it was published before" do
      recipe =
        recipe_fixture()
        |> Cookbook.publish_recipe()
        |> elem(1)

      assert {:ok, %Recipe{} = recipe} = Cookbook.unpublish_recipe(recipe)
      refute recipe.published_at
    end

    test "publish_recipe/1 returns an error if recipe was not published before" do
      recipe = recipe_fixture()
      assert {:error, :not_published} = Cookbook.unpublish_recipe(recipe)
    end
  end
end
