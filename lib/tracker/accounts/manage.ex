defmodule Tracker.Accounts.Manage do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tracker.Accounts.Manage


  schema "manages" do
    field :manager_id, :id, null: false
    field :subordinate_id, :id, null: false

    timestamps()
  end

  @doc false
  def changeset(%Manage{} = manage, attrs) do
    manage
    |> cast(attrs, [:manager_id,:subordinate_id])
    |> validate_required([:manager_id,:subordinate_id])
  end
end
