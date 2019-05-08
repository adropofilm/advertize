defmodule AdvertizeWeb.AdvertisementController do
  use AdvertizeWeb, :controller
  alias Advertize.Models.{ Advertisement, Category, Status }

  def index(conn, _params) do
    advertisements = Advertisement.get_all_ads
    render conn, "index.html", advertisements: advertisements
  end

  def new(conn, _params) do
    conn
    |> render("new.html", maybe_user: Guardian.Plug.current_resource(conn),
                          changeset: Advertisement.changeset(%Advertisement{}, %{}),
                          categories: Category.get_all_categories)
  end

  def create(conn, %{"advertisement" => advertisement}) do
    maybe_user = Guardian.Plug.current_resource(conn)

    case Advertisement.create(advertisement, get_category(advertisement), maybe_user.id) do
      {:ok, _post} ->
        conn
        |> put_flash(:info, "Advertisement Created")
        |> redirect(to: advertisement_path(conn, :home))
      {:error, changeset} ->
        conn
        |> render("new.html", changeset: changeset, maybe_user: maybe_user, categories: Category.get_all_categories)
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
    advertisements = Repo.all(Advertisement) |> Repo.preload(:user)

    conn
    |> render("dashboard.html", maybe_user: Guardian.Plug.current_resource(conn),
        advertisements: advertisements, categories: Category.get_unformatted_cats, declined_stat: Status.declined_status)
  end

  def home(conn, _params) do
    advertisements = Repo.all(Advertisement)
    user = Guardian.Plug.current_resource(conn)

    conn
    |> render("home.html", maybe_user: user, advertisements: advertisements,
              user_ads: get_ads(user), categories: Category.get_unformatted_cats,
              declined_stat: Status.declined_status)
  end

  def filter_home(conn, %{"query" => params} ) do
    user = Guardian.Plug.current_resource(conn)

    conn
    |> render("home.html", maybe_user: user, advertisements: Advertisement.filter_adds(params),
              user_ads: get_ads(user), categories: Category.get_unformatted_cats, declined_stat: Status.declined_status)
  end

  def filter_dashboard(conn, %{"query" => params} ) do
    IO.inspect params
    user = Guardian.Plug.current_resource(conn)

    conn
    |> render("dashboard.html", maybe_user: user, advertisements: Advertisement.filter_adds(params),
              user_ads: get_ads(user), categories: Category.get_unformatted_cats, declined_stat: Status.declined_status)
  end

  def decline(conn,  %{"id" => advertisement_id}) do
    Repo.get(Advertisement, advertisement_id)
    |> Ecto.Changeset.change(status_id: Status.declined_status)
    |> Repo.update
    |> case do
      {:ok, _advertisement} ->
        conn
        |> put_flash(:info, "Advertisement Declined")
        |> redirect(to: advertisement_path(conn, :dashboard))
      {:error, changeset} ->
        conn
        |> put_flash(:info, "Advertisement Not Declined")
        |> redirect(to: advertisement_path(conn, :dashboard))
    end

  end

  defp get_ads(user) do
    user.id
    |> Advertisement.get_ad_by_user
  end

  defp get_category(params) do
    [category] =
      params["category_id"]
      |> String.to_integer
      |> Category.get_by_id
    category
  end

end
