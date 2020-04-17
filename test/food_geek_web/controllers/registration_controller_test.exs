defmodule FoodGeekWeb.RegistrationControllerTest do
  use FoodGeekWeb.ConnCase

  describe "GET /sign-up" do
    setup %{conn: conn} do
      [path: Routes.registration_path(conn, :new)]
    end

    test "renders sing-up form", %{conn: conn, path: path} do
      conn = get(conn, path)
      assert html_response(conn, 200) =~ "Create an Account"
    end
  end

  describe "POST /sign-up" do
    setup %{conn: conn} do
      [path: Routes.registration_path(conn, :create)]
    end

    test "creates registers new users and redirects to home", %{conn: conn, path: path} do
      params = %{
        "user" => %{
          "name" => "John Wick",
          "email" => "john@example.com",
          "password" => "password",
          "password_confirmation" => "password"
        }
      }

      conn = post(conn, path, params)

      assert get_flash(conn, :info) =~ "Welcome!"
      assert get_session(conn, :user_id) != nil
      assert redirected_to(conn) == "/"
    end
  end
end
