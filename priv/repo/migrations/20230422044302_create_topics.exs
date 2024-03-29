defmodule PureAI.Repo.Migrations.CreateTopics do
  use Ecto.Migration

  def change do
    create table(:topics) do
      add :name, :string
      add :user_id, :integer
      add :prompt_template_id, :integer
      add :metadata, :map

      timestamps()
    end

    create index(:topics, [:user_id])
    create index(:topics, [:prompt_template_id])
  end
end
