defmodule AdvertizeWeb.AdvertisementController do
  use AdvertizeWeb, :controller
  alias Advertize.Models.Advertisement

  def index(conn, _params) do
    advertisements = Repo.all(Advertisement)

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

  def dashboard(conn, _params) do
    advertisements = Repo.all(Advertisement)

    conn
    |> render("dashboard.html", maybe_user: Guardian.Plug.current_resource(conn),
                  advertisements: advertisements)
  end

  def home(conn, _params) do
    advertisements = Repo.all(Advertisement)

    conn
    |> render("home.html", maybe_user: Guardian.Plug.current_resource(conn),
                  advertisements: advertisements)
  end

end
