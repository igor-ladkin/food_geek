defmodule FoodGeekWeb.Api.RecipeController do
  use FoodGeekWeb, :controller

  alias FoodGeek.Cookbook

  def index(conn, _params) do
    recipes = Cookbook.list_published_recipes()
    render(conn, "index.json", recipes: recipes)
  end
end
