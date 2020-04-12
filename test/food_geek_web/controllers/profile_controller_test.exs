defmodule FoodGeekWeb.ProfileControllerTest do
  use FoodGeekWeb.ConnCase

  describe "GET /my/profile when the user is not authenticated" do
    setup [:set_path]

    test "redirects to home page", %{conn: conn, path: path} do
      conn = get(conn, path)
      assert get_flash(conn, :error) =~ "sign in"
      assert redirected_to(conn, 302) == "/"
    end
  end

  describe "GET /my/profile when the user is authenticated" do
    setup [:set_path, :set_user]

    test "renders user profile details", %{conn: conn, path: path} do
      conn = get(conn, path)
      assert html_response(conn, 200) =~ "john@example.com"
    end
  end

  defp set_path(context) do
    [path: Routes.my_profile_path(context.conn, :show, :en)]
  end

  defp set_user(context) do
    [conn: assign(context.conn, :current_user, %{email: "john@example.com"})]
  end
end
