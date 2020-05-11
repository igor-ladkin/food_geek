ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(FoodGeek.Repo, :manual)

# Ensure that bucket exists during test run on GitHub
case ExAws.S3.list_buckets() |> ExAws.request!() do
  %{body: %{buckets: []}} ->
    "foodgeek"
    |> ExAws.S3.put_bucket("eu-central-1")
    |> ExAws.request!()

  _ ->
    :already_exists
end
