defmodule SKWeb.Router do
  use SKWeb, :router

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

  scope "/", SKWeb do
    pipe_through :browser # Use the default browser stack

    # Macro magic is how PageController is resolved
    # to SKWeb.PageController

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", SKWeb do
  #   pipe_through :api
  # end
end
