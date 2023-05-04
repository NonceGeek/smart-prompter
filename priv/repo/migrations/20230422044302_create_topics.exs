defmodule PureAI.Repo.Migrations.CreateTopics do
  use Ecto.Migration

  def change do
    create table(:topics) do
      add :user_id, :integer
      add :prompt_template_id, :integer
      add :metadata, :map

      timestamps()
    end
  end
end
