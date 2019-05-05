defmodule Advertize.Models.Advertisement do
  use AdvertizeWeb, :model

  schema "advertisements" do
    field :title, :string
    field :details, :string
    field :datetime, :string
    field :price, :float
    field :moderator_id, :string, default: " "
    field :category_id, :string, default: " "

    belongs_to :user, Advertize.Auth.User, foreign_key: :user_id
    belongs_to :status, Advertize.Models.Status, foreign_key: :status_id

    timestamps()
  end

  @fields ~w(title details datetime price moderator_id category_id)a

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @fields)
    |> validate_required([:price, :title, :details, :datetime])
  end

  def get_all_ads do
    Repo.all(__MODULE__)
  end

  def get_ad_by_user(user_id) do
    __MODULE__
    |> where([ad], ad.user_id == ^user_id)
    |> Repo.all()
  end

  def get_ad_by_category(category_id) do
    __MODULE__
    |> where([ad], ad.category_id == ^category_id)
    |> Repo.all()
  end

end
