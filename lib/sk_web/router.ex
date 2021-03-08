defmodule SkWeb.Router do
  use SkWeb, :router
  import Phoenix.LiveDashboard.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug SkWeb.Auth
    plug :put_root_layout, {SkWeb.LayoutView, :root}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SkWeb do
    pipe_through :browser

    # scope macro magic makes SpeakerController aliased
    resources "/speakers", SpeakerController, only: [:index, :show, :new, :create]
    resources "/sessions", SessionController, only: [:new, :create, :delete]

    get "/", PageController, :index
  end

  # /manage is a scope in which all resources require authentication
  scope "/manage", SkWeb do
    pipe_through [:browser, :authenticate]

    resources "/slide_images", SlideImageController
    resources "/slide_decks", SlideDeckController
  end

  # Other scopes may use custom stacks.
  # scope "/api", SkWeb do
  #   pipe_through :api
  # end

  if Mix.env() == :dev do
    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard"
    end
  end

end
