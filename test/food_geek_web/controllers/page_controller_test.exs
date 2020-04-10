defmodule FoodGeekWeb.PageControllerTest do
  use FoodGeekWeb.ConnCase

  describe "when user locale is en" do
    setup %{conn: conn} do
      conn = put_req_header(conn, "accept-language", "en")
      %{conn: conn}
    end

    test "GET /", %{conn: conn} do
      conn = get(conn, "/")
      assert "/en" = redir_path = redirected_to(conn, 302)

      conn = get(recycle(conn), redir_path)
      assert html_response(conn, 200) =~ "FoodGeek"
    end

    test "GET /terms", %{conn: conn} do
      conn = get(conn, "/terms")
      assert "/en/terms" = redir_path = redirected_to(conn, 302)

      conn = get(recycle(conn), redir_path)
      assert html_response(conn, 200) =~ "Terms and Conditions"
    end
  end

  describe "when user locale is ru" do
    setup %{conn: conn} do
      conn = put_req_header(conn, "accept-language", "ru")
      %{conn: conn}
    end

    test "GET /", %{conn: conn} do
      conn = get(conn, "/")
      assert "/ru" = redir_path = redirected_to(conn, 302)

      conn = get(recycle(conn), redir_path)
      assert html_response(conn, 200) =~ "FoodGeek"
    end

    test "GET /terms", %{conn: conn} do
      conn = get(conn, "/terms")
      assert "/ru/terms" = redir_path = redirected_to(conn, 302)

      conn = get(recycle(conn), redir_path)
      assert html_response(conn, 200) =~ "Условия и положения"
    end
  end
end
