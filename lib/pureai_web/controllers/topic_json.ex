defmodule PureAIWeb.TopicJSON do
  @moduledoc false

  alias PureAI.Chat.{Topic, Message}

  @doc """
  Renders a list of topics.
  """
  def index(%{topics: topics}) do
    %{data: for(topic <- topics, do: data(topic))}
  end

  @doc """
  Renders a single topic.
  """
  def show(%{topic: topic}) do
    %{data: data(topic)}
  end

  defp data(%Topic{} = topic) do
    messages =
      if is_list(topic.messages) do
        Enum.map(topic.messages, fn message -> data(message) end)
      else
        nil
      end

    %{
      id: topic.id,
      user_id: topic.user_id,
      name: topic.name,
      prompt_template_id: topic.prompt_template_id,
      metadata: topic.metadata,
      messages: messages
    }
  end

  defp data(%Message{} = message) do
    %{
      id: message.id,
      # user_id: message.user_id,
      content: message.content,
      role: message.role,
      index: message.index,
      finish_reason: message.finish_reason,
      topic_id: message.topic_id,
      metadata: message.metadata
    }
  end
end
