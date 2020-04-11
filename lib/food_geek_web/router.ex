defmodule FoodGeekWeb.Router do
  use FoodGeekWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug SetLocale, gettext: FoodGeekWeb.Gettext, default_locale: "en"
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FoodGeekWeb do
    pipe_through :browser

    get "/", PageController, :contact
  end

  scope "/:locale", FoodGeekWeb do
    pipe_through :browser

    get "/", PageController, :contact
    get "/terms", PageController, :terms
  end

  # Other scopes may use custom stacks.
  # scope "/api", FoodGeekWeb do
  #   pipe_through :api
  # end
end
