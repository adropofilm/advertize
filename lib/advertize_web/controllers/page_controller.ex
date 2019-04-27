defmodule AdvertizeWeb.PageController do
  use AdvertizeWeb, :controller
  alias Advertize.Auth
  alias Advertize.Auth.User
  alias Advertize.Auth.Guardian

  def index(conn, _params) do
    changeset = Auth.change_user(%User{})
    maybe_user = Guardian.Plug.current_resource(conn)
  
    conn
    |> render("index.html", changeset: changeset, action: page_path(conn, :login), maybe_user: maybe_user)
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

  defp login_reply({:ok, user}, conn) do
    conn
    |> put_flash(:success, "Welcome back!")
    |> Guardian.Plug.sign_in(user)
    |> redirect(to: "/")
  end

  def logout(conn, _) do
    conn
    |> Guardian.Plug.sign_out()
    |> redirect(to: page_path(conn, :login))
  end

  def secret(conn, _params) do
    render(conn, "secret.html")
  end

end
