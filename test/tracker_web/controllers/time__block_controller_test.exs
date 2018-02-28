defmodule TrackerWeb.Time_BlockControllerTest do
  use TrackerWeb.ConnCase

  alias Tracker.Accounts
  alias Tracker.Accounts.Time_Block

  @create_attrs %{end: ~N[2010-04-17 14:00:00.000000], start: ~N[2010-04-17 14:00:00.000000]}
  @update_attrs %{end: ~N[2011-05-18 15:01:01.000000], start: ~N[2011-05-18 15:01:01.000000]}
  @invalid_attrs %{end: nil, start: nil}

  def fixture(:time__block) do
    {:ok, time__block} = Accounts.create_time__block(@create_attrs)
    time__block
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all time_blocks", %{conn: conn} do
      conn = get conn, time__block_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create time__block" do
    test "renders time__block when data is valid", %{conn: conn} do
      conn = post conn, time__block_path(conn, :create), time__block: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, time__block_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "end" => ~N[2010-04-17 14:00:00.000000],
        "start" => ~N[2010-04-17 14:00:00.000000]}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, time__block_path(conn, :create), time__block: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update time__block" do
    setup [:create_time__block]

    test "renders time__block when data is valid", %{conn: conn, time__block: %Time_Block{id: id} = time__block} do
      conn = put conn, time__block_path(conn, :update, time__block), time__block: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, time__block_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "end" => ~N[2011-05-18 15:01:01.000000],
        "start" => ~N[2011-05-18 15:01:01.000000]}
    end

    test "renders errors when data is invalid", %{conn: conn, time__block: time__block} do
      conn = put conn, time__block_path(conn, :update, time__block), time__block: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete time__block" do
    setup [:create_time__block]

    test "deletes chosen time__block", %{conn: conn, time__block: time__block} do
      conn = delete conn, time__block_path(conn, :delete, time__block)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, time__block_path(conn, :show, time__block)
      end
    end
  end

  defp create_time__block(_) do
    time__block = fixture(:time__block)
    {:ok, time__block: time__block}
  end
end
