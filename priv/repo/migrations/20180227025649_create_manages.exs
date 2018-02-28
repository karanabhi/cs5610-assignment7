defmodule Tracker.Repo.Migrations.CreateManages do
  use Ecto.Migration

  def change do
    create table(:manages) do
      add :manager_id, references(:users, on_delete: :delete_all)
      add :subordinate_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:manages, [:manager_id])
    create index(:manages, [:subordinate_id])
  end
end
