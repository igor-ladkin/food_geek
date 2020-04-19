defmodule FoodGeekWeb.SetLocalePlug do
  use FoodGeekWeb, :plug

  def init(options) do
    options
  end

  def call(conn, _opts) do
    cond do
      conn.assigns[:locale] ->
        conn

      locale = get_session(conn, :locale) ->
        set_locale(conn, locale)

      true ->
        conn
    end
  end

  defp set_locale(conn, locale) do
    Gettext.put_locale(locale)
    assign(conn, :locale, locale)
  end
end
