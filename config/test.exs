use Mix.Config

# Configure your database
config :food_geek, FoodGeek.Repo,
  username: "postgres",
  password: "postgres",
  database: "food_geek_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :food_geek, FoodGeekWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
