defmodule FoodGeek.Repo.Migrations.CreateRecipes do
  use Ecto.Migration

  def change do
    create table(:recipes) do
      add :title, :string
      add :description, :text
      add :number_of_servings, :integer
      add :active_time_in_min, :integer
      add :total_time_in_min, :integer
      add :chef_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:recipes, [:chef_id])
  end
end
