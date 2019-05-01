defmodule Advertize.Repo.Migrations.AddCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :category_name, :string, null: false
    end
  end

end
