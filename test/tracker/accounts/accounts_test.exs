defmodule Tracker.AccountsTest do
  use Tracker.DataCase

  alias Tracker.Accounts

  describe "users" do
    alias Tracker.Accounts.User

    @valid_attrs %{email: "some email", name: "some name"}
    @update_attrs %{email: "some updated email", name: "some updated name"}
    @invalid_attrs %{email: nil, name: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.name == "some name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Accounts.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.email == "some updated email"
      assert user.name == "some updated name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "manages" do
    alias Tracker.Accounts.Manage

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def manage_fixture(attrs \\ %{}) do
      {:ok, manage} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_manage()

      manage
    end

    test "list_manages/0 returns all manages" do
      manage = manage_fixture()
      assert Accounts.list_manages() == [manage]
    end

    test "get_manage!/1 returns the manage with given id" do
      manage = manage_fixture()
      assert Accounts.get_manage!(manage.id) == manage
    end

    test "create_manage/1 with valid data creates a manage" do
      assert {:ok, %Manage{} = manage} = Accounts.create_manage(@valid_attrs)
    end

    test "create_manage/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_manage(@invalid_attrs)
    end

    test "update_manage/2 with valid data updates the manage" do
      manage = manage_fixture()
      assert {:ok, manage} = Accounts.update_manage(manage, @update_attrs)
      assert %Manage{} = manage
    end

    test "update_manage/2 with invalid data returns error changeset" do
      manage = manage_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_manage(manage, @invalid_attrs)
      assert manage == Accounts.get_manage!(manage.id)
    end

    test "delete_manage/1 deletes the manage" do
      manage = manage_fixture()
      assert {:ok, %Manage{}} = Accounts.delete_manage(manage)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_manage!(manage.id) end
    end

    test "change_manage/1 returns a manage changeset" do
      manage = manage_fixture()
      assert %Ecto.Changeset{} = Accounts.change_manage(manage)
    end
  end

  describe "time_blocks" do
    alias Tracker.Accounts.Time_Block

    @valid_attrs %{end: ~N[2010-04-17 14:00:00.000000], start: ~N[2010-04-17 14:00:00.000000]}
    @update_attrs %{end: ~N[2011-05-18 15:01:01.000000], start: ~N[2011-05-18 15:01:01.000000]}
    @invalid_attrs %{end: nil, start: nil}

    def time__block_fixture(attrs \\ %{}) do
      {:ok, time__block} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_time__block()

      time__block
    end

    test "list_time_blocks/0 returns all time_blocks" do
      time__block = time__block_fixture()
      assert Accounts.list_time_blocks() == [time__block]
    end

    test "get_time__block!/1 returns the time__block with given id" do
      time__block = time__block_fixture()
      assert Accounts.get_time__block!(time__block.id) == time__block
    end

    test "create_time__block/1 with valid data creates a time__block" do
      assert {:ok, %Time_Block{} = time__block} = Accounts.create_time__block(@valid_attrs)
      assert time__block.end == ~N[2010-04-17 14:00:00.000000]
      assert time__block.start == ~N[2010-04-17 14:00:00.000000]
    end

    test "create_time__block/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_time__block(@invalid_attrs)
    end

    test "update_time__block/2 with valid data updates the time__block" do
      time__block = time__block_fixture()
      assert {:ok, time__block} = Accounts.update_time__block(time__block, @update_attrs)
      assert %Time_Block{} = time__block
      assert time__block.end == ~N[2011-05-18 15:01:01.000000]
      assert time__block.start == ~N[2011-05-18 15:01:01.000000]
    end

    test "update_time__block/2 with invalid data returns error changeset" do
      time__block = time__block_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_time__block(time__block, @invalid_attrs)
      assert time__block == Accounts.get_time__block!(time__block.id)
    end

    test "delete_time__block/1 deletes the time__block" do
      time__block = time__block_fixture()
      assert {:ok, %Time_Block{}} = Accounts.delete_time__block(time__block)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_time__block!(time__block.id) end
    end

    test "change_time__block/1 returns a time__block changeset" do
      time__block = time__block_fixture()
      assert %Ecto.Changeset{} = Accounts.change_time__block(time__block)
    end
  end
end
