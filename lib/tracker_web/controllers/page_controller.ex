defmodule TrackerWeb.PageController do
  use TrackerWeb, :controller

  alias Tracker.Accounts

  def index(conn, _params) do
    render conn, "index.html"
  end

  def landing(conn, _params) do
    mid=Accounts.get_manager(get_session(conn, :user_id))

    if mid do
      manager=Accounts.get_user(mid.manager_id)
      render conn, "landing.html", mName: manager.name
    else
      render conn, "landing.html", mName: "No Manager Assigned Yet!"
    end
  end

end
