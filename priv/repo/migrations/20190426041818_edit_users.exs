defmodule Advertize.Repo.Migrations.EditUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :is_admin, :boolean, null: false, default: false
      remove :role
    end
  end
end
