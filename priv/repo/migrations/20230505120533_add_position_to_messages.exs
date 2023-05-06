defmodule PureAI.Repo.Migrations.AddPositionToMessages do
  use Ecto.Migration

  def change do
    alter table(:messages) do
      add :position, :integer, default: 0
    end

    create index(:messages, [:position])
  end
end
