defmodule Tracker.Accounts.Time_Block do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tracker.Accounts.Time_Block


  schema "time_blocks" do
    field :end, :string, null: false
    field :start, :string, null: false
    field :task_id, :id, null: false

    timestamps()
  end

  @doc false
  def changeset(%Time_Block{} = time__block, attrs) do
    time__block
    |> cast(attrs, [:task_id,:start,:end])
    |> validate_required([:task_id,:start,:end])
  end
end
