defmodule FoodGeekWeb.SetCurrentUserPlug do
  use FoodGeekWeb, :plug

  alias FoodGeek.Accounts

  def init(options) do
    options
  end

  def call(conn, _opts) do
    cond do
      conn.assigns[:current_user] ->
        conn

      id = get_session(conn, :user_id) ->
        user = Accounts.get_user!(id)
        login(conn, user)

      true ->
        conn
    end
  end

  def login(conn, user) do
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end
end
