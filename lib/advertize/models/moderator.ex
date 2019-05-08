defmodule Advertize.Models.Moderator do
  use AdvertizeWeb, :model

  schema "moderators" do
    field :moderator_username, :string

    has_many :advertisements, Advertize.Models.Advertisement
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, :moderator_username)
    |> validate_required([:moderator_username])
  end

end
