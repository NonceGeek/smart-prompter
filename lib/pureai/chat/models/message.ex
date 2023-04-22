defmodule PureAI.Chat.Model.Message do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :content, :string
    field :metadata, :map

    belongs_to :topic, PureAI.Chat.Model.Topic
    belongs_to :user, PureAI.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    required_fields = ~w(
      topic_id
      content
    )a

    optional_fields = ~w(
      user_id
      metadata
    )a

    message
    |> cast(attrs, optional_fields ++ required_fields)
    |> validate_required(required_fields)
  end
end
