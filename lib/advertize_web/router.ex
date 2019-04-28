defmodule AdvertizeWeb.Router do
  use AdvertizeWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :auth do
    plug Advertize.Auth.Pipeline
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  # Maybe logged in scope
  scope "/", AdvertizeWeb do
    pipe_through [:browser, :auth]
    get "/", PageController, :index
    post "/", PageController, :login
    post "/logout", PageController, :logout
  end

  # Definitely logged in scope
  scope "/", AdvertizeWeb do
    pipe_through [:browser, :auth, :ensure_auth]
    get "/home", PageController, :home
    get "/dashboard", PageController, :dashboard

    get "/advertisements/new", AdvertisementController, :new
    post "/advertisements", AdvertisementController, :create
  end

end
