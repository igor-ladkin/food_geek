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
        conn
        |> assign(:current_user, %{email: email})
        |> configure_session(renew: true)

      true ->
        conn
    end
  end
end
