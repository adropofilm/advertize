defmodule Advertize.Repo.Migrations.EditAdvDelet do
  use Ecto.Migration

  def change do
    alter table(:advertisements) do
      remove :user_id
      add :user_id, references(:users, on_delete: :delete_all)
    end
  end
end
