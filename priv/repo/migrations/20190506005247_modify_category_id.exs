defmodule Advertize.Repo.Migrations.ModifyCategoryId do
  use Ecto.Migration

  def change do
    alter table(:advertisements) do
      remove :category_id
      add :category_id, references(:categories)
    end
  end
end
