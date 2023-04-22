defmodule PureAI.Chat.Topic do
  use Ecto.Schema
  import Ecto.Changeset

  schema "topics" do
    field :metadata, :map
    field :prompt_template_id, :integer
    field :prompt_text, :string
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(topic, attrs) do
    topic
    |> cast(attrs, [:user_id, :prompt_text, :prompt_template_id, :metadata])
    |> validate_required([:user_id, :prompt_text, :prompt_template_id, :metadata])
  end
end
