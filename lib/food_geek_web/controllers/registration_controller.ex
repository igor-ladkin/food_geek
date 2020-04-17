defmodule FoodGeekWeb.RegistrationController do
  use FoodGeekWeb, :controller

  alias FoodGeek.Accounts

  plug :put_layout, "minimal.html"

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, gettext("Welcome!"))
        |> put_session(:user_id, user.id)
        |> redirect(to: "/")

      {:error, _changeset} ->
        conn
    end
  end
end
