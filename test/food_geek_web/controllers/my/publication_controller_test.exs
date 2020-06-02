defmodule FoodGeekWeb.My.PublicationControllerTest do
  use FoodGeekWeb.ConnCase
  use FoodGeekWeb.AuthorizedCase

  @moduledoc logged_as: "gordon@hk.com"

  setup %{conn: conn} do
    chef = conn.assigns.current_user
    published_at = TestHelper.truncated_date_time()

    draft = insert!(:recipe, chef: chef)
    published = insert!(:recipe, chef: chef, published_at: published_at)

    [
      conn: assign(conn, :current_user, chef),
      draft: draft,
      published: published
    ]
  end

  describe "create publication" do
    test "publishes existing draft recipe", %{conn: conn, draft: recipe} do
      resp_conn = post(conn, Routes.my_recipe_publication_path(conn, :create, recipe))
      assert get_flash(resp_conn, :info) =~ "Recipe published successfully"
      assert redirected_to(resp_conn) == Routes.my_recipe_path(conn, :show, recipe)

      conn = get(conn, Routes.my_recipe_path(conn, :show, recipe))
      assert html_response(conn, 200) =~ "Unpublish Recipe"
      refute html_response(conn, 200) =~ "Publish Recipe"
    end

    test "warns that existing recipe was published before", %{conn: conn, published: recipe} do
      resp_conn = post(conn, Routes.my_recipe_publication_path(conn, :create, recipe))
      assert get_flash(resp_conn, :error) =~ "Recipe is already published"
      assert redirected_to(resp_conn) == Routes.my_recipe_path(conn, :show, recipe)
    end
  end

  describe "delete publication" do
    test "puts back as draft existing published recipe", %{conn: conn, published: recipe} do
      resp_conn = delete(conn, Routes.my_recipe_publication_path(conn, :delete, recipe))
      assert get_flash(resp_conn, :info) =~ "Recipe marked as draft successfully"
      assert redirected_to(resp_conn) == Routes.my_recipe_path(conn, :show, recipe)

      conn = get(conn, Routes.my_recipe_path(conn, :show, recipe))
      assert html_response(conn, 200) =~ "Publish Recipe"
      refute html_response(conn, 200) =~ "Unpublish Recipe"
    end

    test "warns that draft recipe has not been published before", %{conn: conn, draft: recipe} do
      resp_conn = delete(conn, Routes.my_recipe_publication_path(conn, :delete, recipe))
      assert get_flash(resp_conn, :error) =~ "Recipe has not been published yet"
      assert redirected_to(resp_conn) == Routes.my_recipe_path(conn, :show, recipe)
    end
  end
end
