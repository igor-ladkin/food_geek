defmodule FoodGeekWeb.Api.RecipeController do
  use FoodGeekWeb, :controller
  use PhoenixSwagger

  alias FoodGeek.Cookbook

  swagger_path :index do
    get("/api/recipes")
    description("List published recipes")
    response(200, "Success", Schema.ref(:RecipesCollection))
  end

  def index(conn, _params) do
    recipes = Cookbook.list_published_recipes()
    render(conn, "index.json", recipes: recipes)
  end

  swagger_path :show do
    get("/api/recipes/{recipe_id}")
    description("Show published recipe")

    parameters do
      recipe_id(:path, :string, "Recipe ID", required: true)
    end

    response(200, "Success", Schema.ref(:Recipe))
  end

  def show(conn, %{"id" => id}) do
    recipe = Cookbook.get_published_recipe!(id)
    render(conn, "show.json", recipe: recipe)
  end

  def swagger_definitions do
    %{
      Recipe:
        swagger_schema do
          title("Recipe")
          description("Published recipe from chef's cookbook")

          properties do
            id(:integer, "Unique identifier", required: true)
            title(:string, "Title", required: true)
            description(:string, "Description", required: true)
            image_url(:string, "Image URL", required: true)
          end

          example(%{
            id: 123,
            title: "Sake Sushi",
            description: "Fine slice of salmon on a delicious rice ball",
            image_url: "https://source.unsplash.com/wmPDe9OnXT4"
          })
        end,
      RecipesCollection:
        swagger_schema do
          title("RecipesCollection")
          description("A collection of Recipes")
          property(:recipes, Schema.array(:Recipe))
        end
    }
  end
end
