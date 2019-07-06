defmodule SkWeb.Router do
  use SkWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SkWeb do
    pipe_through :browser

    # Macro magic make SpeakerController aliased
    get "/speakers", SpeakerController, :index
    get "/speaker/:id", SpeakerController, :show

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", SkWeb do
  #   pipe_through :api
  # end
end
