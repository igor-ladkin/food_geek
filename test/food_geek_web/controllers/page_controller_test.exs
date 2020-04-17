defmodule FoodGeekWeb.PageControllerTest do
  use FoodGeekWeb.ConnCase

  describe "when user locale is en" do
    setup %{conn: conn} do
      conn = init_test_session(conn, %{locale: "en"})
      %{conn: conn}
    end

    test "GET /", %{conn: conn} do
      conn = get(conn, "/")
      assert html_response(conn, 200) =~ "FoodGeek"
    end

    test "GET /terms", %{conn: conn} do
      conn = get(conn, "/terms")
      assert html_response(conn, 200) =~ "Terms and Conditions"
    end
  end

  describe "when user locale is ru" do
    setup %{conn: conn} do
      conn = init_test_session(conn, %{locale: "ru"})
      %{conn: conn}
    end

    test "GET /", %{conn: conn} do
      conn = get(conn, "/")
      assert html_response(conn, 200) =~ "FoodGeek"
    end

    test "GET /terms", %{conn: conn} do
      conn = get(conn, "/terms")
      assert html_response(conn, 200) =~ "Условия и положения"
    end
  end
end
