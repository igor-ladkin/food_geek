defmodule FoodGeekWeb.RecipeView do
  use FoodGeekWeb, :view

  alias FoodGeek.Cookbook.Recipe

  def recipe_image_url(%Recipe{} = recipe) do
    FoodGeek.Cookbook.Image.url({recipe.image, recipe})
  end

  def recipe_published?(%Recipe{published_at: nil}), do: false
  def recipe_published?(%Recipe{}), do: true
end
