defmodule Tracker.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :name, :string
      add :manager, :string

      timestamps()
    end

  end
end
