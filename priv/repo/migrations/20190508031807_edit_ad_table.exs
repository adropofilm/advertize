defmodule Advertize.Repo.Migrations.EditAdTable do
  use Ecto.Migration

  def change do
    alter table(:advertisements) do
      remove :moderator_id
      add :moderator_id, references(:moderators)
    end
  end
end
