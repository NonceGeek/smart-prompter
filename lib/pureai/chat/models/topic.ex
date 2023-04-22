defmodule PureAI.Chat.Model.Topic do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  schema "topics" do
    field :prompt_template_id, :integer
    field :prompt_text, :string

    belongs_to :user, PureAI.Accounts.User
    belongs_to :template, PureAI.Prompt.Model.PromptTemplate

    has_many :messages, PureAI.Chat.Model.Message, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(topic, attrs) do
    required_fields = ~w(
      prompt_text
      user_id
    )a

    optional_fields = ~w(
      prompt_template_id
      metadata
    )a

    topic
    |> cast(attrs, required_fields ++ optional_fields)
    |> validate_required(required_fields)
  end
end
