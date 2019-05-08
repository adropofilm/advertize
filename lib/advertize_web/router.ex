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

    get "/home", AdvertisementController, :home
    put "/advertisements/:id", AdvertisementController, :decline
    post "/advertisement/:id", AdvertisementController, :claim
    post "/home", AdvertisementController, :filter_home
    post "/dashboard", AdvertisementController, :filter_dashboard
    get "/dashboard", AdvertisementController, :dashboard
    post "/advertisements", AdvertisementController, :create
    get "/advertisements/new", AdvertisementController, :new
    put "/advertisements/:id/edit", AdvertisementController, :update
    get "/advertisements/:id/edit", AdvertisementController, :edit
    delete "/advertisements/:id", AdvertisementController, :delete

  end

end
