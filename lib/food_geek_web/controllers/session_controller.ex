defmodule FoodGeekWeb.SessionController do
  use FoodGeekWeb, :controller

  plug :put_layout, "minimal.html"

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"user" => %{"email" => email}}) do
    if email do
      conn
      |> put_session(:user, email)
      |> redirect(to: "/")
    end
  end

  def delete(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end
end
