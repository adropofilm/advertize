defmodule Advertize.Repo.Migrations.LinkCategoryId do
  use Ecto.Migration

  def change do
    alter table(:advertisements) do
      remove :category_id
      add :category_id, references(:statuses)
    end
  end

end
