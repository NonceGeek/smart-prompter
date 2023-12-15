defmodule PureAI.Context.EmberddingVector do
  use Ecto.Schema
  import Ecto.Changeset

  schema "embedding_vector" do
    field :sha, :string
    field :text, :string
    field :vector, :string

    timestamps()
  end

  @doc false
  def changeset(emberdding_vector, attrs) do
    emberdding_vector
    |> cast(attrs, [:sha, :text, :vector])
    |> validate_required([:sha, :text, :vector])
  end
end
