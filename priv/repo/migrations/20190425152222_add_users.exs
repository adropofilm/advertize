defmodule Advertize.Repo.Migrations.AddUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string
      add :last_name, :string
      add :password, :string
      add :username, :string
      add :role, :string
    end
  end
end
