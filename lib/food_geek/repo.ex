defmodule FoodGeek.Repo do
  use Ecto.Repo,
    otp_app: :food_geek,
    adapter: Ecto.Adapters.Postgres
end
