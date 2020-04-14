defmodule FoodGeekWeb.AuthPlug do
  use FoodGeekWeb, :plug

  def init(options) do
    options
  end

  def call(conn, _opts) do
    if conn.assigns[:current_user] do
      conn
    else
      conn
      |> put_flash(:error, gettext("Please sign in first to access that page"))
      |> redirect(to: "/")
      |> halt()
    end
  end
end
