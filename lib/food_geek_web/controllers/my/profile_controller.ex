defmodule FoodGeekWeb.My.ProfileController do
  use FoodGeekWeb, :controller

  def show(conn, _params) do
    render(conn, "show.html")
  end
end
