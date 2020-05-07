defmodule FoodGeekWeb.PublicationControllerTest do
  use FoodGeekWeb.ConnCase

  setup(context) do
    chef = FoodGeek.Accounts.get_user_by(email: "gordon@hk.com")
    published_at = DateTime.utc_now() |> DateTime.truncate(:second)

    draft = insert!(:recipe, chef: chef)
    published = insert!(:recipe, chef: chef, published_at: published_at)

    [
      conn: assign(context.conn, :current_user, chef),
      draft: draft,
      published: published
    ]
  end

  describe "create publication" do
    test "publishes existing draft recipe", %{conn: conn, draft: recipe} do
      resp_conn = post(conn, Routes.recipe_publication_path(conn, :create, recipe))
      assert get_flash(resp_conn, :info) =~ "Recipe published successfully"
      assert redirected_to(resp_conn) == Routes.recipe_path(conn, :show, recipe)

      conn = get(conn, Routes.recipe_path(conn, :show, recipe))
      assert html_response(conn, 200) =~ "Unpublish Recipe"
      refute html_response(conn, 200) =~ "Publish Recipe"
    end

    test "warns that existing recipe was published before", %{conn: conn, published: recipe} do
      resp_conn = post(conn, Routes.recipe_publication_path(conn, :create, recipe))
      assert get_flash(resp_conn, :error) =~ "Recipe is already published"
      assert redirected_to(resp_conn) == Routes.recipe_path(conn, :show, recipe)
    end
  end
end
