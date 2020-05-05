defmodule FoodGeek.Repo.Migrations.AddImageToRecipes do
  use Ecto.Migration

  def change do
    alter table(:recipes) do
      add :image, :string
    end
  end
end
