defmodule FoodGeek.Cookbook.Recipe do
  use Ecto.Schema
  use Arc.Ecto.Schema

  import Ecto.Changeset
  import Ecto.Query

  alias FoodGeek.Cookbook
  alias FoodGeek.Accounts

  schema "recipes" do
    field :active_time_in_min, :integer
    field :description, :string
    field :number_of_servings, :integer
    field :title, :string
    field :total_time_in_min, :integer
    field :published_at, :utc_datetime
    field :image, Cookbook.Image.Type

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
    |> cast_attachments(attrs, [:image])
    |> validate_required([
      :title,
      :description,
      :number_of_servings,
      :active_time_in_min,
      :total_time_in_min,
      :image
    ])
  end

  def publish_changeset(recipe, attrs) do
    recipe
    |> cast(attrs, [:published_at])
    |> validate_required([:published_at])
  end

  def unpublish_changeset(recipe) do
    recipe
    |> change(%{published_at: nil})
  end

  def including_chef(query \\ __MODULE__) do
    from q in query,
      preload: [:chef]
  end

  def for_chef(query \\ __MODULE__, %Accounts.User{id: chef_id}) do
    from q in query,
      where: q.chef_id == ^chef_id
  end

  def published(query \\ __MODULE__) do
    from q in query,
      where: not is_nil(q.published_at)
  end
end
