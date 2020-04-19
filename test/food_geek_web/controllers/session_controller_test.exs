defmodule FoodGeekWeb.SessionControllerTest do
  use FoodGeekWeb.ConnCase

  describe "GET /sign-in" do
    setup %{conn: conn} do
      [path: Routes.session_path(conn, :new)]
    end

    test "renders sing-in form", %{conn: conn, path: path} do
      conn = get(conn, path)
      assert html_response(conn, 200) =~ "Sign In to FoodGeek"
    end
  end

  describe "POST /sign-in" do
    setup %{conn: conn} do
      [
        path: Routes.session_path(conn, :create),
        user: insert!(:user, %{email: "john@example.com"})
      ]
    end

    test "creates new user session and redirects to home", %{conn: conn, path: path, user: user} do
      params = %{"user" => %{"email" => "john@example.com", "password" => "password"}}

      conn = post(conn, path, params)

      assert get_session(conn, :user_id) == user.id
      assert conn.assigns.current_user == user
      assert redirected_to(conn) == "/"
    end

    test "renders errors when wrong credentials are passed", %{conn: conn, path: path} do
      params = %{"user" => %{"email" => "john@example.com", "password" => "psswrd"}}

      conn = post(conn, path, params)

      refute get_session(conn, :user_id)
      refute conn.assigns[:current_user]
      assert html_response(conn, 200) =~ "email/password combination does not exist"
      assert html_response(conn, 200) =~ "john@example.com"
    end
  end

  describe "DELETE /sign-out" do
    setup %{conn: conn} do
      [path: Routes.session_path(conn, :delete)]
    end

    test "deletes user session and redirects to home", %{conn: conn, path: path} do
      conn = delete(conn, path)

      assert get_session(conn, :user) == nil
      assert redirected_to(conn) == "/"
    end
  end
end
