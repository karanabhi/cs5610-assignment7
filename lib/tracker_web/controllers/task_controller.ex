defmodule TrackerWeb.TaskController do
  use TrackerWeb, :controller

  alias Tracker.Issue
  alias Tracker.Issue.Task
  alias Tracker.Accounts

  def assigned_tasks(conn, _params) do
    changeset = Issue.change_task(%Task{})
    ta=Accounts.list_time_blocks()
    tasks = Issue.get_task_by_user_id(get_session(conn, :user_id))
    render(conn, "assigned_tasks.html", changeset: changeset, tasks: [tasks], taskassigned: ta)
  end

  def index(conn, _params) do
    changeset = Issue.change_task(%Task{})
    tasks = Issue.get_task_by_assigned_id(get_session(conn, :user_id))
    ta=Accounts.list_time_blocks()
    render(conn, "index.html", tasks: [tasks], taskassigned: ta)
  end

  def new(conn, %{"sid"=>sid}) do
    changeset = Issue.change_task(%Task{})
    render(conn, "new.html", sid: sid, changeset: changeset)
  end

  #def new(conn, _params) do
  #  changeset = Issue.change_task(%Task{})
  #  render(conn, "new.html", changeset: changeset)
  #end


  def create(conn, %{"title" => title,"description" => description,"assigned_to"=>assigned_to,
  "status"=>status,"user_id"=>user_id,"start_time"=>start,"end_time"=>endTime}) do
    #def create(conn, %{"task_params"=>task_params}) do
    user = Accounts.get_user(assigned_to);

    if user do
      task_params=%{
        "title": title,
        "description": description,
        #"assignedTime": assignedTim,
        "assigned_to": assigned_to,
        "status": status,
        "user_id": user_id
      }
      time_params=%{
        "start": start,
        "end": endTime
      }
      case Issue.create_task(task_params) do
        {:ok, task} ->
          put_flash(conn,:info, "Task created successfully.")
          render(conn,"show.html",task: task,time_params: time_params)
          {:error, %Ecto.Changeset{} = changeset} ->
            render(conn, "new.html", changeset: changeset)
          end
        else
          conn
          |> put_flash(:error, "Cannot assign task to a non-existing User!.")
          |> redirect(to: task_path(conn, :new))
        end
      end

      #def create(conn, %{"task" => task_params}) do
      #  case Issue.create_task(task_params) do
      #    {:ok, task} ->
      #      conn
      #      |> put_flash(:info, "Task created successfully.")
      #      |> redirect(to: task_path(conn, :show, task))
      #      {:error, %Ecto.Changeset{} = changeset} ->
      #        render(conn, "new.html", changeset: changeset)
      #      end
      #    end

      def show(conn, %{"id" => id}) do
        task = Issue.get_task!(id)
        render(conn, "show.html", task: task)
      end

      def edit(conn, %{"id" => id}) do
        task = Issue.get_task!(id)
        changeset = Issue.change_task(task)
        render(conn, "edit.html", task: task, changeset: changeset)
      end

      def update(conn, %{"id" => id, "task" => task_params}) do
        task = Issue.get_task!(id)
        user = Accounts.get_user(Map.get(task_params,"assigned_to"));
        status= Map.get(task_params,"status");


        if user && (status=="In Progress" || status=="Completed") do
          case Issue.update_task(task, task_params) do
            {:ok, task} ->
              conn
              |> put_flash(:info, "Task updated successfully.")
              |> redirect(to: task_path(conn, :show, task))
              {:error, %Ecto.Changeset{} = changeset} ->
                render(conn, "edit.html", task: task, changeset: changeset)
              end
            else
              conn
              |> put_flash(:error, "Assign task to an existing User Only or write the correct status!.")
              |> redirect(to: task_path(conn, :show,task))
            end
          end

          def delete(conn, %{"id" => id}) do
            task = Issue.get_task!(id)
            {:ok, _task} = Issue.delete_task(task)

            conn
            |> put_flash(:info, "Task deleted successfully.")
            |> redirect(to: task_path(conn, :index))
          end
        end
