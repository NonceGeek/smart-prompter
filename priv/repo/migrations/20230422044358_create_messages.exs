defmodule PureAI.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :user_id, :integer
      add :content, :text
      add :topic_id, :integer
      add :metadata, :map

      timestamps()
    end
  end
end
