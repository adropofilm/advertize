defmodule Advertize.Repo.Migrations.EditStatus do
  use Ecto.Migration

  def change do
    alter table(:advertisements) do
      add :status_id, references(:statuses)
      remove :status
    end
  end
end
