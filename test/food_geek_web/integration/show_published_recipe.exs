defmodule FoodGeekWeb.SignUpTest do
  use FoodGeekWeb.IntegrationCase

  setup do
    chef = FoodGeek.Accounts.get_user_by(email: "jiro@sushi.com")
    published_at = TestHelper.truncated_date_time()
    sushi = insert!(:recipe, title: "Maguro Nigiri", chef: chef, published_at: published_at)

    [sushi: sushi]
  end

  @tag logged_as: "seth@pe.com"
  test "User can go to home page and click on recipe card to see published recipe", %{
    conn: conn,
    sushi: sushi
  } do
    get(conn, "/")
    |> follow_link(Routes.recipe_path(conn, :show, sushi))
    |> assert_response(
      status: 200,
      html: "Jiro Ono"
    )
  end
end
