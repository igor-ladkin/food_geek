defmodule FoodGeekWeb.My.RecipeControllerTest do
  use FoodGeekWeb.ConnCase
  use FoodGeekWeb.AuthorizedCase

  alias FoodGeek.Cookbook

  @create_attrs %{
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

  def fixture(:recipe) do
    chef = FoodGeek.Accounts.get_user_by(email: "gordon@hk.com")
    {:ok, recipe} = Cookbook.create_recipe(chef, @create_attrs)
    recipe
  end

  describe "index" do
    test "lists all recipes", %{conn: conn} do
      conn = get(conn, Routes.my_recipe_path(conn, :index))
      assert html_response(conn, 200) =~ "Your Recipes"
    end
  end

  describe "new recipe" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.my_recipe_path(conn, :new))
      assert html_response(conn, 200) =~ "New Recipe"
    end
  end

  describe "create recipe" do
    test "redirects to show when data is valid", %{conn: conn} do
      resp_conn = post(conn, Routes.my_recipe_path(conn, :create), recipe: @create_attrs)

      assert %{id: id} = redirected_params(resp_conn)
      assert redirected_to(resp_conn) == Routes.my_recipe_path(conn, :show, id)

      conn = get(conn, Routes.my_recipe_path(conn, :show, id))
      assert html_response(conn, 200) =~ @create_attrs.title
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.my_recipe_path(conn, :create), recipe: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Recipe"
    end
  end

  describe "edit recipe" do
    setup [:create_recipe]

    test "renders form for editing chosen recipe", %{conn: conn, recipe: recipe} do
      conn = get(conn, Routes.my_recipe_path(conn, :edit, recipe))
      assert html_response(conn, 200) =~ "Edit Recipe"
    end
  end

  describe "update recipe" do
    setup [:create_recipe]

    test "redirects when data is valid", %{conn: conn, recipe: recipe} do
      resp_conn = put(conn, Routes.my_recipe_path(conn, :update, recipe), recipe: @update_attrs)
      assert redirected_to(resp_conn) == Routes.my_recipe_path(conn, :show, recipe)

      conn = get(conn, Routes.my_recipe_path(conn, :show, recipe))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, recipe: recipe} do
      conn = put(conn, Routes.my_recipe_path(conn, :update, recipe), recipe: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Recipe"
    end
  end

  describe "delete recipe" do
    setup [:create_recipe]

    test "deletes chosen recipe", %{conn: conn, recipe: recipe} do
      resp_conn = delete(conn, Routes.my_recipe_path(conn, :delete, recipe))
      assert redirected_to(resp_conn) == Routes.my_recipe_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.my_recipe_path(conn, :show, recipe))
      end
    end
  end

  defp create_recipe(_) do
    recipe = fixture(:recipe)
    {:ok, recipe: recipe}
  end
end
