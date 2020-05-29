defmodule FoodGeekWeb.IntegrationCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use FoodGeekWeb.ConnCase
      use PhoenixIntegration
    end
  end
end
