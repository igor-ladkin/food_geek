defmodule FoodGeek.Accounts.Dns do
  @callback lookup(binary(), atom(), atom()) :: [{number(), charlist()}]
end
