defmodule Advertize.Models.Advertisement do
  use AdvertizeWeb, :model
  alias Advertize.Models.{ Status, Category }

  schema "advertisements" do
    field :title, :string
    field :details, :string
    field :datetime, :string
    field :price, :float
    field :moderator_id, :string, default: " "

    belongs_to :user, Advertize.Auth.User, foreign_key: :user_id
    belongs_to :status, Advertize.Models.Status, foreign_key: :status_id
    belongs_to :category, Advertize.Models.Category, foreign_key: :category_id

    timestamps()
  end

  @fields ~w(title details datetime price moderator_id category_id)a

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @fields)
    |> foreign_key_constraint(:category_id)
    |> validate_required([:price, :title, :details, :datetime])
  end

  def create(params, category_id, user_id) do
    changeset(%__MODULE__{}, params)
    |> Ecto.Changeset.change(%{:user_id => user_id, :status_id => Status.default_status, :category_id => get_ad_category(params)})
    |> Repo.insert
  end

  def get_all_ads do
    Repo.all(__MODULE__)
    |> Repo.preload([:user, :category, :status])
  end

  def get_ad_by_user(user_id) do
    __MODULE__
    |> where([ad], ad.user_id == ^user_id)
    |> Repo.all()
    |> Repo.preload([:user, :category, :status])
  end

  def filter_adds(%{"category_id" => category_id, "datetime" => datetime, "phrase" => phrase} = params) do
    category_id = get_ad_category(params)

    if datetime == "" && phrase == "" && category_id != "", do: get_ad_by_category(category_id) |> IO.inspect
    if datetime != "" && phrase == "" && category_id != "", do: get_ad_by_datetime_and_cat(datetime, category_id)
    if datetime == "" && phrase != "" && category_id != "", do: get_ad_by_phrase_and_cat(phrase, category_id)
    if datetime != "" && phrase != "" && category_id != "", do: get_ad_by_all_filters(datetime, category_id, phrase)
  end

  def get_ad_by_category(category_id) do
    __MODULE__
    |> where([ad], ad.category_id == ^category_id)
    |> Repo.all()
    |> Repo.preload([:user, :category, :status])
  end

  def get_ad_by_datetime(datetime) do
    __MODULE__
    |> where([ad], ad.datetime == ^datetime)
    |> Repo.all()
    |> Repo.preload([:user, :category, :status])
  end

  def get_ad_by_datetime_and_cat(datetime, category_id) do
    __MODULE__
    |> where([ad], ad.datetime == ^datetime)
    |> where([ad], ad.category_id == ^category_id)
    |> Repo.all()
    |> Repo.preload([:user, :category, :status])
  end

  def get_ad_by_all_filters(datetime, category_id, phrase) do
    __MODULE__
    |> where([ad], ad.datetime == ^datetime)
    |> where([ad], ad.category_id == ^category_id)
    |> where([ad], like(ad.title, ^"%#{String.replace(phrase, "%", "\\%")}%"))
    |> Repo.all()
    |> Repo.preload([:user, :category, :status])
  end

  def get_ad_by_phrase_and_cat(phrase, category_id) do
    __MODULE__
    |> where([ad], ad.category_id == ^category_id)
    |> where([ad], like(ad.title, ^"%#{String.replace(phrase, "%", "\\%")}%"))
    |> Repo.all()
    |> Repo.preload([:user, :category, :status])
  end

  def decline(advertisement) do
    
  end

  defp get_ad_category(params) do
    [category] =
      params["category_id"]
      |> String.to_integer
      |> Category.get_by_id
    category.id
  end

end
