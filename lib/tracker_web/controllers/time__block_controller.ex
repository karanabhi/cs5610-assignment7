defmodule TrackerWeb.Time_BlockController do
  use TrackerWeb, :controller

  alias Tracker.Accounts
  alias Tracker.Accounts.Time_Block

  action_fallback TrackerWeb.FallbackController

  def index(conn, _params) do
    time_blocks = Accounts.list_time_blocks()
    render(conn, "index.json", time_blocks: time_blocks)
  end

  def create(conn, %{"start"=>start,"end"=>endTime,"task_id"=>tid}) do
    time__block_params=%{
      "start": start,      
      "end": endTime,
      "task_id": tid
    }
    with {:ok, %Time_Block{} = time__block} <- Accounts.create_time__block(time__block_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", time__block_path(conn, :show, time__block))
      |> render("show.json", time__block: time__block)
    end
  end

  def show(conn, %{"id" => id}) do
    time__block = Accounts.get_time__block!(id)
    render(conn, "show.json", time__block: time__block)
  end

  def update(conn, %{"id" => id, "time__block" => time__block_params}) do
    time__block = Accounts.get_time__block!(id)

    with {:ok, %Time_Block{} = time__block} <- Accounts.update_time__block(time__block, time__block_params) do
      render(conn, "show.json", time__block: time__block)
    end
  end

  def delete(conn, %{"id" => id}) do
    time__block = Accounts.get_time__block!(id)
    with {:ok, %Time_Block{}} <- Accounts.delete_time__block(time__block) do
      send_resp(conn, :no_content, "")
    end
  end
end
