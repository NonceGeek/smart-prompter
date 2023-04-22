defmodule PureAI.Repo.Migrations.CreatePromptTemplates do
  use Ecto.Migration

  def change do
    create table(:prompt_templates) do
      add :title, :string
      add :content, :text
      add :is_default, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:prompt_templates, [:user_id])
  end
end
