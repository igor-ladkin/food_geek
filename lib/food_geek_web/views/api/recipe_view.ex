defmodule FoodGeekWeb.Api.RecipeView do
  use FoodGeekWeb, :view

  import FoodGeekWeb.My.RecipeView, only: [recipe_image_url: 1]

  def render("index.json", %{recipes: recipes}) do
    %{recipes: render_many(recipes, __MODULE__, "recipe.json")}
  end

  def render("show.json", %{recipe: recipe}) do
    render_one(recipe, __MODULE__, "recipe.json")
  end

  def render("recipe.json", %{recipe: recipe}) do
    %{
      id: recipe.id,
      title: recipe.title,
      description: recipe.description,
      image_url: recipe_image_url(recipe)
    }
  end
end
