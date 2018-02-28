defmodule TrackerWeb.Time_BlockView do
  use TrackerWeb, :view
  alias TrackerWeb.Time_BlockView

  def render("index.json", %{time_blocks: time_blocks}) do
    %{data: render_many(time_blocks, Time_BlockView, "time__block.json")}
  end

  def render("show.json", %{time__block: time__block}) do
    %{data: render_one(time__block, Time_BlockView, "time__block.json")}
  end

  def render("time__block.json", %{time__block: time__block}) do
    %{id: time__block.id,
      start: time__block.start,
      end: time__block.end}
  end
end
