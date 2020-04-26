defmodule FoodGeek.Cookbook.Recipe do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias FoodGeek.Accounts

  schema "recipes" do
    field :active_time_in_min, :integer
    field :description, :string
    field :number_of_servings, :integer
    field :title, :string
    field :total_time_in_min, :integer

    belongs_to :chef, Accounts.User

    timestamps()
  end

  @doc false
  def changeset(recipe, attrs) do
    recipe
    |> cast(attrs, [
      :title,
      :description,
      :number_of_servings,
      :active_time_in_min,
      :total_time_in_min
    ])
    |> validate_required([
      :title,
      :description,
      :number_of_servings,
      :active_time_in_min,
      :total_time_in_min
    ])
  end

  def including_chef(query \\ __MODULE__) do
    from q in query,
      preload: [:chef]
  end

  def for_chef(query \\ __MODULE__, %Accounts.User{id: chef_id}) do
    from q in query,
      where: q.chef_id == ^chef_id
  end
end
