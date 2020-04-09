defmodule FoodGeekWeb.RenderHelpers do
  @moduledoc """
  Conveniences for working with different render engines.
  """

  use Phoenix.HTML

  def markdown(text) do
    text
    |> FoodGeekWeb.MarkdownEngine.render([])
    |> raw()
  end
end
