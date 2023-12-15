defmodule PureAI.Repo.Migrations.CreateEmbeddingVector do
  use Ecto.Migration

  def change do
    create table(:embedding_vector) do
      add :sha, :string
      add :text, :text
      add :vector, :text

      timestamps()
    end
    create unique_index(:embedding_vector, [:sha])
  end
end
