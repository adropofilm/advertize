defmodule Advertize.Repo.Migrations.AddUserTimestamps do
  use Ecto.Migration

  def change do
    alter table(:users) do
      timestamps null: true
    end
  end
end
