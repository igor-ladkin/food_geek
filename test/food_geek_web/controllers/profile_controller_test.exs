defmodule FoodGeekWeb.ProfileControllerTest do
  use FoodGeekWeb.ConnCase

  describe "GET /my/profile when the user is not authenticated" do
    setup %{conn: conn} do
      path = Routes.my_profile_path(conn, :show, :en)
      %{path: path}
    end

    test "redirects to home page", %{conn: conn, path: path} do
      conn = get(conn, path)
      assert get_flash(conn, :error) =~ "sign in"
      assert redirected_to(conn, 302) == "/"
    end
  end
end
