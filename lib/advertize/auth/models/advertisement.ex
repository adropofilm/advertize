defmodule Advertize.Models.Advertisement do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "advertisements" do
    field :title, :string
    field :details, :string
    field :datetime, :string # TODO change to :utc_datetime
    field :price, :decimal, precision: 12, scale: 2
    field :moderator_id, :string
    field :category_id, :string
    field :status, :string

    belongs_to :user, Advertize.Auth.User

    timestamps
  end

  @fields ~w(title details datetime price moderator_id category_id status)a
  @zero Decimal.new(0)

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @fields)
    |> validate_required([:name, :price, :title, :details, :datetime, :user_id, :moderator_id, :category_id, :status])
    |> validate_number(:price, greater_than_or_equal_to: @zero)
  end

end
