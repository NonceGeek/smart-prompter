defmodule PureAI.Chat.Message do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :role, Ecto.Enum, values: ~w(system user assistant)a, default: :user

    field :content, :string

    field :finish_reason, :string
    field :index, :string

    field :metadata, :map

    belongs_to :user, PureAI.Accounts.User
    belongs_to :topic, PureAI.Chat.Topic

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    required_fields = ~w(
      role
      content
      topic_id
    )a

    optional_fields = ~w(
      finish_reason
      index
      user_id
      metadata
    )a

    message
    |> cast(attrs, required_fields ++ optional_fields)
    |> validate_required(required_fields)
  end
end
