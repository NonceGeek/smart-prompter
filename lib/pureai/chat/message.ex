defmodule PureAI.Chat.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :content, :string
    field :metadata, :map
    field :topic_id, :integer
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:user_id, :content, :topic_id, :metadata])
    |> validate_required([:user_id, :content, :topic_id, :metadata])
  end
end
