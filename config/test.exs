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

config :food_geek,
  auth_config: [
    username: "test",
    password: "test",
    realm: "Website"
  ]

# Print only warnings and errors during test
config :logger, level: :warn

# Config argon2 to speed up tests
config :argon2_elixir,
  t_cost: 1,
  m_cost: 8

config :phoenix_integration,
  endpoint: FoodGeekWeb.Endpoint
