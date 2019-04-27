defmodule Advertize.Repo.Migrations.AddAdvertisement do
  use Ecto.Migration

  def change do
    create table(:advertisements) do
      add :title, :string
      add :details, :string
      add :datetime, :string
      add :price, :float
    end
  end
end
