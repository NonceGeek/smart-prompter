defmodule PureAI.Chat.Topic do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  schema "topics" do
    field :name, :string
    field :metadata, :map

    belongs_to :user, PureAI.Accounts.User
    belongs_to :prompt_template, PureAI.Prompt.PromptTemplate

    has_many :messages, PureAI.Chat.Message, foreign_key: :topic_id

    timestamps()
  end

  @doc false
  def changeset(topic, attrs) do
    required_fields = ~w(
    )a

    optional_fields = ~w(
     user_id
     name
     prompt_template_id
     metadata
    )a

    topic
    |> cast(attrs, required_fields ++ optional_fields)
    |> validate_required(required_fields)
  end
end
