defmodule Advertize.Models.Status do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "status" do
    field :status_name, :string
  end

  @fields ~w(pending active disapproved)

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, :status_name)
    |> validate_required([:status_name])
    |> validate_inclusion(:status_name, @fields)
  end

end
