# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :food_geek,
  ecto_repos: [FoodGeek.Repo]

config :food_geek, FoodGeekWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "7byhVtsUzB/wKWduEqtTuvYafg5npCj3PeeUfk1mJUqqcd1wnY1gHnpRubu4ovsn",
  render_errors: [view: FoodGeekWeb.ErrorView, accepts: ~w(html json)],
  pubsub_server: MyApp.PubSub,
  live_view: [signing_salt: "2zbjpOFh"]

config :food_geek, FoodGeekWeb.Gettext,
  locales: ~w(en ru),
  default_locale: "en"

config :food_geek, dns: FoodGeek.Accounts.Dns.Stub

config :food_geek, :phoenix_swagger,
  swagger_files: %{
    "priv/static/swagger.json" => [
      router: FoodGeekWeb.Router,
      endpoint: FoodGeekWeb.Endpoint
    ]
  }

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

config :phoenix, :template_engines,
  slim: PhoenixSlime.Engine,
  slime: PhoenixSlime.Engine,
  slimleex: PhoenixSlime.LiveViewEngine

config :phoenix_slime, :use_slim_extension, true

config :slime, :embedded_engines, %{
  markdown: FoodGeekWeb.MarkdownEngine
}

config :arc,
  bucket: "foodgeek",
  asset_host: "http://127.0.0.1:9000/foodgeek"

config :ex_aws,
  access_key_id: "minio",
  secret_access_key: "password",
  json_codec: Jason,
  s3: [
    scheme: "http",
    host: "127.0.0.1",
    port: 9000,
    region: "eu-central-1"
  ]

config :phoenix_swagger, json_library: Jason

import_config "#{Mix.env()}.exs"
