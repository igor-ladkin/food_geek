defmodule FoodGeekWeb.SessionController do
  use FoodGeekWeb, :controller

  plug :put_layout, "minimal.html"

  def new(conn, _params) do
    render(conn, "new.html")
  end
end
