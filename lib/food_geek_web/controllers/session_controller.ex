defmodule FoodGeekWeb.SessionController do
  use FoodGeekWeb, :controller

  alias FoodGeek.Accounts
  alias FoodGeek.Accounts.User
  alias FoodGeekWeb.SetCurrentUserPlug

  plug :put_layout, "minimal.html"

  def new(conn, _params) do
    render(conn, "new.html", changeset: session_form())
  end

  def create(conn, %{"user" => %{"email" => email, "password" => password}}) do
    case Accounts.authenticate_by(email: email, password: password) do
      {:ok, user} ->
        conn
        |> SetCurrentUserPlug.login(user)
        |> put_flash(:info, gettext("Welcome back!"))
        |> redirect(to: "/")

      {:error, _error} ->
        conn
        |> put_flash(:error, gettext("Account with email/password combination does not exist"))
        |> render("new.html", changeset: session_form(%{email: email}))
    end
  end

  def delete(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  defp session_form(attrs \\ %{}) do
    %User{}
    |> Ecto.Changeset.cast(attrs, [:email])
  end
end
