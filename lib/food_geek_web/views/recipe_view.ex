defmodule FoodGeekWeb.RecipeView do
  use FoodGeekWeb, :view

  def recipe_image_url(recipe) do
    FoodGeek.Cookbook.Image.url({recipe.image, recipe})
  end
end
