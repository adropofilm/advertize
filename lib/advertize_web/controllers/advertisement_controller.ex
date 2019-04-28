defmodule AdvertizeWeb.AdvertisementController do
  use AdvertizeWeb, :controller
  alias Advertize.Auth.User
  alias Advertize.Models.Advertisement

  def new(conn, _params) do
    #changeset = Advertisement.changeset(%Advertisement{}, %{})
    render conn, "new.html" #, changeset: changeset
  end


end
