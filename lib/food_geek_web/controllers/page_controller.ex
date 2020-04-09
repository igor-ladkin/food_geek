defmodule FoodGeekWeb.PageController do
  use FoodGeekWeb, :controller

  def contact(conn, _params) do
    render(conn, "contact.html")
  end
end
