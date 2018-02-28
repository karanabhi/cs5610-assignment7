defmodule Tracker.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tracker.Accounts.User


  schema "users" do
    field :email, :string, null: false
    field :name, :string
    field :manager, :string,null: false# YES==Manager NO==Normal user

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :name, :manager])
    |> validate_required([:email, :name, :manager])
  end
end
