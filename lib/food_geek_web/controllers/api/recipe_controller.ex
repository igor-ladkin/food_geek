defmodule FoodGeekWeb.Api.RecipeController do
  use FoodGeekWeb, :controller

  alias FoodGeek.Cookbook

  def index(conn, _params) do
    recipes = Cookbook.list_published_recipes()
    render(conn, "index.json", recipes: recipes)
  end

  def show(conn, %{"id" => id}) do
    recipe = Cookbook.get_published_recipe!(id)
    render(conn, "show.json", recipe: recipe)
  end
end
