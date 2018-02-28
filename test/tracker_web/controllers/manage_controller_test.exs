defmodule TrackerWeb.ManageControllerTest do
  use TrackerWeb.ConnCase

  alias Tracker.Accounts

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:manage) do
    {:ok, manage} = Accounts.create_manage(@create_attrs)
    manage
  end

  describe "index" do
    test "lists all manages", %{conn: conn} do
      conn = get conn, manage_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Manages"
    end
  end

  describe "new manage" do
    test "renders form", %{conn: conn} do
      conn = get conn, manage_path(conn, :new)
      assert html_response(conn, 200) =~ "New Manage"
    end
  end

  describe "create manage" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, manage_path(conn, :create), manage: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == manage_path(conn, :show, id)

      conn = get conn, manage_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Manage"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, manage_path(conn, :create), manage: @invalid_attrs
      assert html_response(conn, 200) =~ "New Manage"
    end
  end

  describe "edit manage" do
    setup [:create_manage]

    test "renders form for editing chosen manage", %{conn: conn, manage: manage} do
      conn = get conn, manage_path(conn, :edit, manage)
      assert html_response(conn, 200) =~ "Edit Manage"
    end
  end

  describe "update manage" do
    setup [:create_manage]

    test "redirects when data is valid", %{conn: conn, manage: manage} do
      conn = put conn, manage_path(conn, :update, manage), manage: @update_attrs
      assert redirected_to(conn) == manage_path(conn, :show, manage)

      conn = get conn, manage_path(conn, :show, manage)
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, manage: manage} do
      conn = put conn, manage_path(conn, :update, manage), manage: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Manage"
    end
  end

  describe "delete manage" do
    setup [:create_manage]

    test "deletes chosen manage", %{conn: conn, manage: manage} do
      conn = delete conn, manage_path(conn, :delete, manage)
      assert redirected_to(conn) == manage_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, manage_path(conn, :show, manage)
      end
    end
  end

  defp create_manage(_) do
    manage = fixture(:manage)
    {:ok, manage: manage}
  end
end
