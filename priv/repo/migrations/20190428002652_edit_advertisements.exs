defmodule Advertize.Repo.Migrations.EditAdvertisements do
  use Ecto.Migration

  def change do
    alter table(:advertisements) do
      add :user_id, :string, null: false, default: nil
      add :moderator_id, :string, null: true, default: nil
      add :category_id, :string, null: true, default: nil
      add :status, :string, null: false, default: "pending"
    end
  end
end
