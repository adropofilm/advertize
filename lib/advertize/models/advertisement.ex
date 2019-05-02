defmodule Advertize.Models.Advertisement do
  use Ecto.Schema
  import Ecto.Changeset

  schema "advertisements" do
    field :title, :string
    field :details, :string
    field :datetime, :string
    field :price, :float
    field :moderator_id, :string, default: " "
    field :category_id, :string, default: " "

    belongs_to :user, Advertize.Auth.User

    timestamps()
  end

  @fields ~w(title details datetime price moderator_id category_id)a

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @fields)
    |> validate_required([:price, :title, :details, :datetime])
  end

end
