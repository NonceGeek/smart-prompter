defmodule PureAI.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :topic_id, :integer
      add :user_id, :integer
      add :content, :string

      add :metadata, :map

      timestamps()
    end

    create index(:messages, [:topic_id])
    create index(:messages, [:user_id])
  end
end
