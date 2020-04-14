defmodule FoodGeekWeb.SetCurrentUserPlug do
  use FoodGeekWeb, :plug

  def init(options) do
    options
  end

  def call(conn, _opts) do
    cond do
      conn.assigns[:current_user] ->
        conn

      email = get_session(conn, :user) ->
        set_current_user(conn, %{email: email})

      true ->
        conn
    end
  end

  defp set_current_user(conn, user) do
    conn
    |> assign(:current_user, user)
    |> configure_session(renew: true)
  end
end
