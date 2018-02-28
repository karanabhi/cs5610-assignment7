defmodule Tracker.IssueTest do
  use Tracker.DataCase

  alias Tracker.Issue

  describe "tasks" do
    alias Tracker.Issue.Task

    @valid_attrs %{assignedTime: 42, assigned_to: 42, description: "some description", status: "some status", title: "some title"}
    @update_attrs %{assignedTime: 43, assigned_to: 43, description: "some updated description", status: "some updated status", title: "some updated title"}
    @invalid_attrs %{assignedTime: nil, assigned_to: nil, description: nil, status: nil, title: nil}

    def task_fixture(attrs \\ %{}) do
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Issue.create_task()

      task
    end

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Issue.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Issue.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      assert {:ok, %Task{} = task} = Issue.create_task(@valid_attrs)
      assert task.assignedTime == 42
      assert task.assigned_to == 42
      assert task.description == "some description"
      assert task.status == "some status"
      assert task.title == "some title"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Issue.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, task} = Issue.update_task(task, @update_attrs)
      assert %Task{} = task
      assert task.assignedTime == 43
      assert task.assigned_to == 43
      assert task.description == "some updated description"
      assert task.status == "some updated status"
      assert task.title == "some updated title"
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Issue.update_task(task, @invalid_attrs)
      assert task == Issue.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Issue.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Issue.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Issue.change_task(task)
    end
  end
end
