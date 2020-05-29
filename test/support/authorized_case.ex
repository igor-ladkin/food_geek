defmodule FoodGeekWeb.AuthorizedCase do
  use ExUnit.CaseTemplate

  alias Plug.Conn

  setup(context) do
    email = context[:logged_as] || "gordon@hk.com"
    chef = FoodGeek.Accounts.get_user_by(email: email)

    [conn: Conn.assign(context.conn, :current_user, chef)]
  end
end
