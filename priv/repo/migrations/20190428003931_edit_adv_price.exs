defmodule Advertize.Repo.Migrations.EditAdvPrice do
  use Ecto.Migration

  def change do
    alter table(:advertisements) do
      modify :price, :decimal, precision: 12, scale: 2
    end
  end
end
