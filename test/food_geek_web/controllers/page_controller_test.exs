defmodule FoodGeekWeb.PageControllerTest do
  use FoodGeekWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "FoodGeek"
  end
end
