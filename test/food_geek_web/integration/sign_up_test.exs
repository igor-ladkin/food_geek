defmodule FoodGeekWeb.SignUpTest do
  use FoodGeekWeb.IntegrationCase, async: true

  test "User can create an accout and see profile page", %{conn: conn} do
    get(conn, "/")
    |> follow_link("Sign In")
    |> follow_link("Sign Up")
    |> follow_form(%{
      user: %{
        name: "Michael Jordan",
        email: "mj23@bulls.com",
        password: "LastDance",
        password_confirmation: "LastDance"
      }
    })
    |> follow_link("mj23@bulls.com")
    |> assert_response(status: 200, path: Routes.my_profile_path(conn, :show))
  end
end
