defmodule Advertize.Repo.Migrations.AddModTable do
  use Ecto.Migration

  def change do
    create table(:moderators) do
      add :moderator_username, :string
    end
  end
end
