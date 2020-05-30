defmodule FoodGeekWeb.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common data structures and query the data layer.

  Finally, if the test case interacts with the database,
  we enable the SQL sandbox, so changes done to the database
  are reverted at the end of every test. If you are using
  PostgreSQL, you can even run database tests asynchronously
  by setting `use FoodGeekWeb.ConnCase, async: true`, although
  this option is not recommended for other databases.
  """

  use ExUnit.CaseTemplate

  alias Plug.Conn
  alias Plug.BasicAuth

  using do
    quote do
      # Import conveniences for testing with connections
      import Plug.Conn
      import Phoenix.ConnTest
      alias FoodGeekWeb.Router.Helpers, as: Routes
      alias FoodGeekWeb.TestHelper
      import FoodGeek.Factory

      # The default endpoint for testing
      @endpoint FoodGeekWeb.Endpoint
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(FoodGeek.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(FoodGeek.Repo, {:shared, self()})
    end

    username = Application.get_env(:food_geek, :auth_config)[:username]
    password = Application.get_env(:food_geek, :auth_config)[:password]
    authorization = BasicAuth.encode_basic_auth(username, password)

    conn =
      Phoenix.ConnTest.build_conn()
      |> Conn.put_req_header("authorization", authorization)

    {:ok, conn: conn}
  end
end
