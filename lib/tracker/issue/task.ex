defmodule Tracker.Issue.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tracker.Issue.Task


  schema "tasks" do
    #field :assignedTime, :integer
    field :assigned_to, :id, null: false
    field :description, :string
    field :status, :string, default: 'In Progress'
    field :title, :string, null: false
    field :user_id, :id, null: false

    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:title, :description, :assigned_to, :status,:user_id])
    |> validate_required([:title, :description, :assigned_to, :status,:user_id])
  end
end
