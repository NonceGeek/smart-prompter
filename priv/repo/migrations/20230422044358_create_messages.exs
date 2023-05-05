defmodule PureAI.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :role, :string
      add :content, :text

      add :finish_reason, :string
      add :index, :integer

      add :user_id, :integer
      add :topic_id, :integer

      add :metadata, :map

      timestamps()
    end

    create index(:messages, [:role])
    create index(:messages, [:user_id])
    create index(:messages, [:topic_id])
  end
end
