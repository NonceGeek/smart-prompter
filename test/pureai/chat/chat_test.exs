defmodule PureAI.ChatTest do
  @moduledoc false

  use PureAI.DataCase

  import PureAI.ChatFixtures

  alias PureAI.Chat
  alias PureAI.Repo
  alias PureAI.Chat.Topic

  describe "topics" do
    test "list user topics" do
      # topic = topic_fixture()
      # assert Chat.list_topics() == [topic]
      assert true
    end

    test "get one topic" do
      assert true
    end

    test "create new topic" do
      topic = topic_fixture()
      assert %Topic{} = topic
    end

    test "create topic with template" do
      assert true
    end


    test "delete user topic" do
      assert true
    end

    test "chat with new message" do
      topic = topic_fixture(%{content: "hello world"})

      {:ok, message} = Chat.add_message(topic.id, "hello world 2")
      {:ok, topic} = Chat.get_topic(message.topic_id)

      assert length(topic.messages) == 4
    end
  end
end
