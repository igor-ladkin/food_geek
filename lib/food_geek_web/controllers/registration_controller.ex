defmodule FoodGeekWeb.RegistrationController do
  use FoodGeekWeb, :controller

  alias FoodGeek.Accounts
  alias FoodGeekWeb.SetCurrentUserPlug

  plug :put_layout, "minimal.html"

  def new(conn, _params) do
    changeset = Accounts.change_user()
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.register_user(user_params) do
      {:ok, user} ->
        conn
        |> SetCurrentUserPlug.login(user)
        |> put_flash(:info, gettext("Welcome!"))
        |> redirect(to: "/")

      {:error, changeset} ->
        conn
        |> render("new.html", changeset: changeset)
    end
  end
end
