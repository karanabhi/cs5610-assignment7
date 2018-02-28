defmodule TrackerWeb.ManageController do
  use TrackerWeb, :controller

  alias Tracker.Accounts
  alias Tracker.Accounts.Manage

  def index(conn, _params) do
    manages = Accounts.list_manages()
    #current_user = conn.assigns[:current_user]
    #manages=Accounts.manages_map_for(current_user.id)
    render(conn, "index.html", manages: manages)
  end

  def new(conn, _params) do
    changeset = Accounts.change_manage(%Manage{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"subordinate_id"=>subordinate_id,"manager_id"=>manager_id}) do
    sid=Tracker.Accounts.get_user(subordinate_id);
    mid=Tracker.Accounts.get_user(manager_id);

    if sid && mid do
      manage_params=%{
        "subordinate_id": subordinate_id,
        "manager_id": manager_id
      }

      case Accounts.create_manage(manage_params) do
        {:ok, manage} ->
          conn
          |> put_flash(:info, "Successfully Assigned Subordinates!")
          |> redirect(to: manage_path(conn, :index, [manage]))
        {:error, %Ecto.Changeset{} = changeset} ->
            conn
            |> put_flash(:error, "Cannot create record!")
            |> render(conn, "new.html", changeset: changeset)
          end
        else
          conn
          |> put_flash(:error, "User ID of subordinate not available!")
          |> redirect(to: manage_path(conn, :new))
        end
      end

      def show(conn, %{"id" => id}) do
        manage = Accounts.get_manage!(id)
        render(conn, "show.html", manage: manage)
      end

      def edit(conn, %{"id" => id}) do
        manage = Accounts.get_manage!(id)
        changeset = Accounts.change_manage(manage)
        render(conn, "edit.html", manage: manage, changeset: changeset)
      end

      def update(conn, %{"id" => id, "manage" => manage_params}) do
        manage = Accounts.get_manage!(id)

        case Accounts.update_manage(manage, manage_params) do
          {:ok, manage} ->
            conn
            |> put_flash(:info, "Subordinates updated successfully.")
            |> redirect(to: manage_path(conn, :show, manage))
            {:error, %Ecto.Changeset{} = changeset} ->
              render(conn, "edit.html", manage: manage, changeset: changeset)
            end
          end

          def delete(conn, %{"id" => id}) do
            manage = Accounts.get_manage!(id)
            {:ok, _manage} = Accounts.delete_manage(manage)

            conn
            |> put_flash(:info, "Subordinates deleted successfully.")
            |> redirect(to: manage_path(conn, :index))
          end
        end
