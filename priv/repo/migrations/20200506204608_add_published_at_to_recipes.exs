defmodule FoodGeek.Repo.Migrations.AddPublishedAtToRecipes do
  use Ecto.Migration

  def change do
    alter table(:recipes) do
      add :published_at, :utc_datetime
    end
  end
end
