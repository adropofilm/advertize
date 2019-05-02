defmodule Advertize.Repo.Migrations.EditPriceType do
  use Ecto.Migration

  def change do
    alter table(:advertisements) do
      modify :price, :float
    end
  end
end
