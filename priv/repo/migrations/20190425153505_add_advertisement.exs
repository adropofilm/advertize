defmodule Advertize.Repo.Migrations.AddAdvertisement do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :title, :string
      add :details, :string
      add :datetime, :string
      add :price, :string
    end
  end
end
