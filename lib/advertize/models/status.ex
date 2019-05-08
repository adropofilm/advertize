defmodule Advertize.Models.Status do
  use AdvertizeWeb, :model

  schema "statuses" do
    field :status_name, :string

    has_many :advertisements, Advertize.Models.Advertisement
  end

  @fields ~w(pending active disapproved)

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, :status_name)
    |> validate_required([:status_name])
    |> validate_inclusion(:status_name, @fields)
  end

  def get_by_type(status_name) do
    __MODULE__
    |> where([st], st.status_name == ^status_name)
    |> Repo.all()
  end

  def default_status do
    [status] = get_by_type("pending")
    status.id
  end

  def declined_status do
    [status] = get_by_type("disapproved")
    status.id
  end

  def claim_status do
    [status] = get_by_type("active")
    status.id
  end

end
