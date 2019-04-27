defmodule Advertize.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Advertize.Auth.User
  alias Comeonin.Bcrypt

  schema "users" do
    field :password, :string
    field :username, :string
    field :first_name, :string
    field :last_name, :string
    field :is_admin, :boolean
    field :role, :string
    timestamps()
  end

  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username, :password, :first_name, :last_name, :is_admin])
    |> validate_required([:username, :password, :first_name, :last_name, :is_admin])
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password: Bcrypt.hashpwsalt(password))
  end

  defp put_pass_hash(changeset), do: changeset

end
