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
  pubsub: [name: FoodGeek.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "2zbjpOFh"]

config :food_geek, FoodGeekWeb.Gettext,
  locales: ~w(en ru),
  default_locale: "en"

config :food_geek, dns: :mock

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

config :phoenix, :template_engines,
  slim: PhoenixSlime.Engine,
  slime: PhoenixSlime.Engine,
  slimleex: PhoenixSlime.LiveViewEngine

config :slime, :embedded_engines, %{
  markdown: FoodGeekWeb.MarkdownEngine
}

import_config "#{Mix.env()}.exs"
