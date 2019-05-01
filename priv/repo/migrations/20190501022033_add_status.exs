defmodule Advertize.Repo.Migrations.AddStatus do
  use Ecto.Migration

  def change do
    create table(:statuses) do
      add :status_name, :string, null: false
    end
  end
end
