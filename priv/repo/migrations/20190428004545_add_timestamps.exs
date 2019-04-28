defmodule Advertize.Repo.Migrations.AddTimestamps do
  use Ecto.Migration

  def change do
    alter table(:advertisements) do
      timestamps
    end
  end
end
