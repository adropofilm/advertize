defmodule Advertize.Repo.Migrations.EditAdvDeletion do
  use Ecto.Migration

  def change do
    alter table(:advertisements) do
      modify :user_id, references(:users, on_delete: :delete_all)
    end
  end
end
