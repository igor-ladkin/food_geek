defmodule FoodGeekWeb.RecipeView do
  use FoodGeekWeb, :view

  import FoodGeekWeb.My.RecipeView, only: [recipe_image_url: 1]

  def render("show.html", assigns) do
    FoodGeekWeb.My.RecipeView.render("show.html", assigns)
  end
end
