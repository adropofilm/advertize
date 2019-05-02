defmodule AdvertizeWeb.AdvertisementController do
  use AdvertizeWeb, :controller
  alias Advertize.Models.Advertisement

  def index(conn, _params) do
    advertisements = Advertisement.get_all_ads
    render conn, "index.html", advertisements: advertisements
  end

  def new(conn, _params) do

    conn
    |> render("new.html", maybe_user: Guardian.Plug.current_resource(conn),
                          changeset: Advertisement.changeset(%Advertisement{}, %{}))
  end

  def create(conn, %{"advertisement" => advertisement}) do
    maybe_user = Guardian.Plug.current_resource(conn)

    changeset =
      Advertisement.changeset(%Advertisement{}, advertisement)
      |> Ecto.Changeset.cast(%{"user_id" => maybe_user.id}, [:user_id])
      |> IO.inspect

    case Repo.insert(changeset) do
      {:ok, _post} ->
        conn
        |> put_flash(:info, "Advertisement Created")
        |> redirect(to: advertisement_path(conn, :home))
      {:error, changeset} ->
        conn
        |> render("new.html", changeset: changeset, maybe_user: maybe_user)
    end
  end

  def edit(conn, %{"id" => advertisement_id}) do # TODO cleanup later
    advertisement = Repo.get(Advertisement, advertisement_id)
    changeset = Advertisement.changeset(advertisement)

    render conn, "edit.html", changeset: changeset, advertisement: advertisement, maybe_user: Guardian.Plug.current_resource(conn)
  end

  def update(conn, %{"id" => advertisement_id, "advertisement" => advertisement}) do
    old_ad = Repo.get(Advertisement, advertisement_id)
    changeset = Advertisement.changeset(old_ad, advertisement)

    case Repo.update(changeset) do
      {:ok, _advertisement} ->
        conn
        |> put_flash(:info, "Advertisement Update")
        |> redirect(to: advertisement_path(conn, :home))
      {:error, changeset} ->
        render conn, "edit.html", changeset: changeset, advertisement: old_ad
    end
  end

  def delete(conn, %{"id" => advertisement_id}) do
    advertisement = Repo.get!(Advertisement, advertisement_id) |> Repo.delete!

    conn
    |> put_flash(:info, "Advertisement Deleted")
    |> redirect(to: advertisement_path(conn, :home))

  end

  def dashboard(conn, _params) do
    advertisements = Repo.all(Advertisement)

    conn
    |> render("dashboard.html", maybe_user: Guardian.Plug.current_resource(conn), advertisements: advertisements)
  end

  def home(conn, _params) do
    advertisements = Repo.all(Advertisement)

    user_ads =
      Guardian.Plug.current_resource(conn).id
      |> Advertisement.get_ad_by_user


    conn
    |> render("home.html", maybe_user: Guardian.Plug.current_resource(conn), advertisements: advertisements,
              user_ads: user_ads)
  end

end
