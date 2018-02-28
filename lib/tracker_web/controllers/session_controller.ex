defmodule TrackerWeb.SessionController do
  use TrackerWeb, :controller

  alias Tracker.Accounts
  #alias Tracker.Accounts.User

  def create(conn, %{"email"=>email}) do
    user=Accounts.get_user_by_email(email)
    if user do
      conn
      |> put_session(:user_id,user.id)
      |> put_flash(:info,"Welcome back, #{user.name}!")
      |> redirect(to: "/landing")
    else
      conn
      |> put_flash(:error,"Cannot create Session!")
      |> redirect(to: user_path(conn,:login))
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:user_id)
    |> put_flash(:info,"Logged Out!")
    |> redirect(to: page_path(conn,:index))
  end

end
