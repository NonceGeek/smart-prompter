defmodule PureAIWeb.MessageJSON do
  alias PureAI.Chat.Message

  @doc """
  Renders a list of messages.
  """
  def index(%{messages: messages}) do
    %{data: for(message <- messages, do: data(message))}
  end

  @doc """
  Renders a single message.
  """
  def show(%{message: message}) do
    %{data: data(message)}
  end

  defp data(%Message{} = message) do
    %{
      id: message.id,
      user_id: message.user_id,
      content: message.content,
      topic_id: message.topic_id,
      metadata: message.metadata
    }
  end
end
