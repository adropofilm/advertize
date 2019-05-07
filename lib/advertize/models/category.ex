defmodule Advertize.Models.Category do
  use AdvertizeWeb, :model

  schema "categories" do
    field :category_name, :string

    has_many :advertisements, Advertize.Models.Advertisement
  end

  @fields ~w(category_name)a

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @fields)
    |> validate_required([:category_name])
  end

  def get_unformatted_cats do
    __MODULE__
    |> Repo.all
  end

  def get_all_categories do
    categories = from(cat in __MODULE__, select: [cat.category_name, cat.id])
      |> Repo.all()
    for [name, id] <- categories, into: [], do: {String.to_atom(name), id}
  end

  def get_by_id(id) do
    __MODULE__
    |> where([cat], cat.id == ^id)
    |> Repo.all()
  end

  def get_by_name(category_name) do
    __MODULE__
    |> where([cat], cat.category_name == ^category_name)
    |> Repo.all()
  end

end
