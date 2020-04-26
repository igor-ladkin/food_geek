defmodule FoodGeekWeb.SetCurrentUserPlug do
  use FoodGeekWeb, :plug

  alias FoodGeek.Accounts

  def init(options) do
    options
  end

  def call(conn, _opts) do
    user_id = get_session(conn, :user_id)

    cond do
      conn.assigns[:current_user] ->
        conn

      user = user_id && Accounts.get_user(user_id) ->
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
