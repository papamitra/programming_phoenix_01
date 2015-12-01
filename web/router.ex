defmodule Rumble.Router do
  use Rumble.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Rumble.Auth, repo: Rumble.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Rumble do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController, only: [:index, :show, :new, :create]
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

  scope "/manage", Rumble do
    pipe_throuth [:brower, :authenticate_user]

    resources "/videos", VideoController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Rumble do
  #   pipe_through :api
  # end
end
