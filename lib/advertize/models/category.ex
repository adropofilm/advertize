defmodule Advertize.Models.Category do
  use AdvertizeWeb, :model

  schema "categories" do
    field :category_name, :string

  end

  @fields ~w(category_name)a

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @fields)
    |> validate_required([:category_name])
  end

  def get_all_categories do
    Repo.all(__MODULE__)
  end

end
