defmodule PureAI.Chat.Message do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :content, :string
    field :metadata, :map

    belongs_to :user, PureAI.Accounts.User
    belongs_to :topic, PureAI.Chat.Topic

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    required_fields = ~w(
      content
      topic_id
    )a

    optional_fields = ~w(
      user_id
      metadata
    )a

    message
    |> cast(attrs, required_fields ++ optional_fields)
    |> validate_required(required_fields)
  end
end
