defmodule FoodGeekWeb.RecipeController do
  use FoodGeekWeb, :controller

  alias FoodGeek.Cookbook

  def index(conn, _params) do
    recipes = Cookbook.list_published_recipes()
    render(conn, "index.html", recipes: recipes)
  end

  def show(conn, %{"id" => id}) do
    recipe = Cookbook.get_published_recipe!(id)
    render(conn, "show.html", recipe: recipe)
  end
end
