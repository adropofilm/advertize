defmodule AdvertizeWeb.AdvertisementController do
  use AdvertizeWeb, :controller
  alias Advertize.Auth.User
  alias Advertize.Models.Advertisement

  def new(conn, _params) do
    conn
    |> render("new.html", maybe_user: Guardian.Plug.current_resource(conn),
                          changeset: Advertisement.changeset(%Advertisement{}, %{}))
  end

  def create(conn, %{"advertisement" => advertisement}) do
    changeset = Advertisement.changeset(%Advertisement{}, advertisement)

    case Repo.insert(changeset) do
      {:ok, _post} ->
        conn
        |> put_flash(:info, "Advertisement Created")
        |> redirect(to: page_path(conn, :home))
      {:error, changeset} ->
        conn
        |> render("new.html", changeset: changeset)
    end
  end

end
