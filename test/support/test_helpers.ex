defmodule FoodGeekWeb.TestHelper do
  def truncated_date_time(date_time \\ nil) do
    (date_time || DateTime.utc_now())
    |> DateTime.truncate(:second)
  end
end
