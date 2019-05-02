defmodule AdvertizeWeb.PageController do
  use AdvertizeWeb, :controller
  alias Advertize.Auth
  alias Advertize.Auth.User
  alias Advertize.Auth.Guardian

  def index(conn, _params) do
    conn
    |> render("index.html", changeset: Auth.change_user(%User{}),
                            action: page_path(conn, :login),
                            maybe_user: Guardian.Plug.current_resource(conn))
  end

  def login(conn, %{"role" => role, "user" => %{"username" => username, "password" => password}}) do
    Auth.authenticate_user(username, password, role)
    |> login_reply(conn)
  end

  defp login_reply({:error, error}, conn) do
    conn
    |> put_flash(:error, error)
    |> redirect(to: "/")
  end

  defp login_reply({:ok, user, role}, conn) do
    request =
      conn #
      |> put_flash(:success, "Welcome back!")
      |> Guardian.Plug.sign_in(user)

    case role do
      "user" ->
        request
        |> redirect(to: "/home")
      "admin" ->
        request
        |> redirect(to: "/dashboard")
    end

  end

  def logout(conn, _) do
    conn
    |> Guardian.Plug.sign_out()
    |> redirect(to: page_path(conn, :login))
  end

end
