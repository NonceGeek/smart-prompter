defmodule PureAI.Repo.Migrations.AddModelToTopicAndTemplate do
  use Ecto.Migration

  def change do
    alter table(:topics) do
      add :model, :string
    end

    alter table(:prompt_templates) do
      add :model, :string
    end

    create index(:topics, [:model])
    create index(:prompt_templates, [:model])
  end
end
