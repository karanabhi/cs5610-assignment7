defmodule TrackerWeb.Router do
  use TrackerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    # After fetch_session in the browser pipeline:
    plug :get_current_user
    plug :fetch_flash
    #plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Below the pipeline
  def get_current_user(conn, _params) do
    # TODO: Move this function out of the router module.
    user_id = get_session(conn, :user_id)
    user = Tracker.Accounts.get_user(user_id || -1)
    assign(conn, :current_user, user)
  end

  scope "/", TrackerWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/users/login", UserController, :login
    get "/tasks/assigned_tasks", TaskController, :assigned_tasks
    get "/landing", PageController, :landing
    post "/session",SessionController,:create
    delete "/session",SessionController,:delete

    resources "/users", UserController
    resources "/tasks", TaskController
    resources "/manages", ManageController

    resources "/time_blocks", Time_BlockController, except: [:new, :edit]
  end

  # Other scopes may use custom stacks.
  scope "/api/v1", TrackerWeb do
    pipe_through :api
  end

end
