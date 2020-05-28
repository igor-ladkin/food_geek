defmodule FoodGeekWeb.Api.RecipeControllerTest do
  use FoodGeekWeb.ConnCase

  setup do
    published_at = DateTime.utc_now() |> DateTime.truncate(:second)

    sushi = insert!(:recipe, title: "Maguro Nigiri", published_at: published_at)
    burger = insert!(:recipe, title: "Double Cheeseburger", published_at: published_at)
    pasta = insert!(:recipe, title: "Cacio e Pepe")

    [sushi: sushi, burger: burger, pasta: pasta]
  end

  describe "index" do
    test "lists all published recipes", %{conn: conn} do
      conn = get(conn, Routes.api_recipe_path(conn, :index))

      body = json_response(conn, 200)
      assert length(body["recipes"]) == 2
    end
  end

  describe "show recipe" do
    test "returns published recipe based on requested id", %{conn: conn, sushi: sushi} do
      conn = get(conn, Routes.api_recipe_path(conn, :show, sushi))

      body = json_response(conn, 200)
      assert body["id"] == sushi.id
      assert body["title"] == sushi.title
      assert body["description"] == sushi.description
      assert body["image_url"] =~ "http://"
    end
  end
end