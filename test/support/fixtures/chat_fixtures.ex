defmodule PureAI.ChatFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PureAI.Chat` context.
  """

  @doc """
  Generate a topic.
  """
  def topic_fixture(attrs \\ %{}) do
    {:ok, topic} =
      attrs
      |> Enum.into(%{
        content: "some content",
        user_id: 42
      })
      |> PureAI.Chat.create_topic()

    topic
  end

  @doc """
  Generate a message.
  """
  def message_fixture(attrs \\ %{}) do
    {:ok, message} =
      attrs
      |> Enum.into(%{
        content: "some content",
        metadata: %{},
        topic_id: 42,
        user_id: 42
      })
      |> PureAI.Chat.create_message()

    message
  end
end
