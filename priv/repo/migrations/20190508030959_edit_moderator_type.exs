defmodule Advertize.Repo.Migrations.EditModeratorType do
  use Ecto.Migration

  def change do
    alter table(:advertisements) do
      remove :moderator_id
      add :moderator_id, references(:users)
    end
  end
end
