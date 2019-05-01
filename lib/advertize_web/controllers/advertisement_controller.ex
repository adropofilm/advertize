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
    maybe_user = Guardian.Plug.current_resource(conn)

    changeset =
      Advertisement.changeset(%Advertisement{}, advertisement)
      |> Ecto.Changeset.cast(%{"user_id" => maybe_user.id}, [:user_id])
      |> Ecto.Changeset.cast(%{"moderator_id" => " "}, [:moderator_id])
      |> IO.inspect

    case Repo.insert(changeset) do
      {:ok, _post} ->
        conn
        |> put_flash(:info, "Advertisement Created")
        |> redirect(to: page_path(conn, :home))
      {:error, changeset} ->
        conn
        |> render("new.html", changeset: changeset, maybe_user: maybe_user)
    end
  end

end
