defmodule FoodGeekWeb.SessionControllerTest do
  use FoodGeekWeb.ConnCase

  describe "GET /sign-in" do
    setup %{conn: conn} do
      path = Routes.session_path(conn, :new, :en)
      %{path: path}
    end

    test "renders sing-in form", %{conn: conn, path: path} do
      conn = get(conn, path)
      assert html_response(conn, 200) =~ "Sign In to FoodGeek"
    end
  end
end
