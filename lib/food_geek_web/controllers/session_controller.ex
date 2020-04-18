defmodule FoodGeekWeb.SessionController do
  use FoodGeekWeb, :controller

  alias FoodGeek.Accounts
  alias FoodGeekWeb.SetCurrentUserPlug

  plug :put_layout, "minimal.html"

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"user" => %{"email" => email}}) do
    case Accounts.get_user_by(email: email) do
      nil ->
        conn
        |> put_flash(:error, gettext("User account does not exists"))
        |> render("new.html")

      user ->
        conn
        |> SetCurrentUserPlug.login(user)
        |> put_flash(:info, gettext("Welcome back!"))
        |> redirect(to: "/")
    end
  end

  def delete(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end
end
