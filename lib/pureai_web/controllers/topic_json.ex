defmodule PureAIWeb.TopicJSON do
  alias PureAI.Chat.Topic

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
    %{
      id: topic.id,
      user_id: topic.user_id,
      prompt_text: topic.prompt_text,
      prompt_template_id: topic.prompt_template_id,
      metadata: topic.metadata
    }
  end
end
