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

  describe "POST /sign-in" do
    setup %{conn: conn} do
      path = Routes.session_path(conn, :new, :en)
      %{path: path}
    end

    test "creates new user session and redirects to home", %{conn: conn, path: path} do
      params = %{"user" => %{"email" => "john@example.com", "password" => "password"}}

      conn = post(conn, path, params)

      assert get_session(conn, :user) == "john@example.com"
      assert "/" = redirected_to(conn, 302)
    end
  end
end
