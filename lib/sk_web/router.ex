defmodule SkWeb.Router do
  use SkWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug SkWeb.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SkWeb do
    pipe_through :browser

    # scope macro magic makes SpeakerController aliased
    resources "/speakers", SpeakerController, only: [:index, :show, :new, :create]
    resources "/slide_images", SlideImageController
    resources "/sessions", SessionController, only: [:new, :create, :delete]

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", SkWeb do
  #   pipe_through :api
  # end
end
