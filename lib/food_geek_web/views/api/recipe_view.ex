defmodule FoodGeekWeb.Api.RecipeView do
  use FoodGeekWeb, :view

  def render("index.json", %{recipes: recipes}) do
    %{recipes: render_many(recipes, __MODULE__, "recipe.json")}
  end

  def render("recipe.json", %{recipe: recipe}) do
    %{
      id: recipe.id,
      title: recipe.title
    }
  end
end
