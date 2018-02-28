defmodule Tracker.Repo.Migrations.CreateTimeBlocks do
  use Ecto.Migration

  def change do
    create table(:time_blocks) do
      add :start, :string
      add :end, :string
      add :task_id, references(:tasks, on_delete: :delete_all)

      timestamps()
    end

    create index(:time_blocks, [:task_id])
  end
end
