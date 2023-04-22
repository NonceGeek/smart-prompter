defmodule PureAI.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :content, :text
      add :user_id, :integer
      add :topic_id, :integer

      add :metadata, :map

      timestamps()
    end

    create index(:messages, [:user_id])
    create index(:messages, [:topic_id])
  end
end
