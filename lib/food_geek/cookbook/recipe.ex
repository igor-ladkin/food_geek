defmodule FoodGeek.Cookbook.Recipe do
  use Ecto.Schema
  import Ecto.Changeset

  schema "recipes" do
    field :active_time_in_min, :integer
    field :description, :string
    field :number_of_servings, :integer
    field :title, :string
    field :total_time_in_min, :integer
    field :chef_id, :id

    timestamps()
  end

  @doc false
  def changeset(recipe, attrs) do
    recipe
    |> cast(attrs, [:title, :description, :number_of_servings, :active_time_in_min, :total_time_in_min])
    |> validate_required([:title, :description, :number_of_servings, :active_time_in_min, :total_time_in_min])
  end
end
