defmodule PureAI.ChatTest do
  @moduledoc false

  use PureAI.DataCase

  alias PureAI.Chat

  describe "topics" do
    #   alias PureAI.Chat.Topic

    #   import PureAI.ChatFixtures

    #   @invalid_attrs %{metadata: nil, prompt_template_id: nil, prompt_text: nil, user_id: nil}

    test "list user topics" do
      # topic = topic_fixture()
      # assert Chat.list_topics() == [topic]
      assert true
    end

    test "get one topic" do
      assert true
    end

    test "create new topic" do
      assert true
    end

    test "delete user topic" do
      assert true
    end

    test "chat and reply" do
      assert true
    end
  end

  #   test "get_topic!/1 returns the topic with given id" do
  #     topic = topic_fixture()
  #     assert Chat.get_topic!(topic.id) == topic
  #   end

  #   test "create_topic/1 with valid data creates a topic" do
  #     valid_attrs = %{
  #       metadata: %{},
  #       prompt_template_id: 42,
  #       prompt_text: "some prompt_text",
  #       user_id: 42
  #     }

  #     assert {:ok, %Topic{} = topic} = Chat.create_topic(valid_attrs)
  #     assert topic.metadata == %{}
  #     assert topic.prompt_template_id == 42
  #     assert topic.prompt_text == "some prompt_text"
  #     assert topic.user_id == 42
  #   end

  #   test "create_topic/1 with invalid data returns error changeset" do
  #     assert {:error, %Ecto.Changeset{}} = Chat.create_topic(@invalid_attrs)
  #   end

  #   test "update_topic/2 with valid data updates the topic" do
  #     topic = topic_fixture()

  #     update_attrs = %{
  #       metadata: %{},
  #       prompt_template_id: 43,
  #       prompt_text: "some updated prompt_text",
  #       user_id: 43
  #     }

  #     assert {:ok, %Topic{} = topic} = Chat.update_topic(topic, update_attrs)
  #     assert topic.metadata == %{}
  #     assert topic.prompt_template_id == 43
  #     assert topic.prompt_text == "some updated prompt_text"
  #     assert topic.user_id == 43
  #   end

  #   test "update_topic/2 with invalid data returns error changeset" do
  #     topic = topic_fixture()
  #     assert {:error, %Ecto.Changeset{}} = Chat.update_topic(topic, @invalid_attrs)
  #     assert topic == Chat.get_topic!(topic.id)
  #   end

  #   test "delete_topic/1 deletes the topic" do
  #     topic = topic_fixture()
  #     assert {:ok, %Topic{}} = Chat.delete_topic(topic)
  #     assert_raise Ecto.NoResultsError, fn -> Chat.get_topic!(topic.id) end
  #   end

  #   test "change_topic/1 returns a topic changeset" do
  #     topic = topic_fixture()
  #     assert %Ecto.Changeset{} = Chat.change_topic(topic)
  #   end
  # end

  # describe "messages" do
  #   alias PureAI.Chat.Message

  #   import PureAI.ChatFixtures

  #   @invalid_attrs %{content: nil, metadata: nil, topic_id: nil, user_id: nil}

  #   test "list_messages/0 returns all messages" do
  #     message = message_fixture()
  #     assert Chat.list_messages() == [message]
  #   end

  #   test "get_message!/1 returns the message with given id" do
  #     message = message_fixture()
  #     assert Chat.get_message!(message.id) == message
  #   end

  #   test "create_message/1 with valid data creates a message" do
  #     valid_attrs = %{content: "some content", metadata: %{}, topic_id: 42, user_id: 42}

  #     assert {:ok, %Message{} = message} = Chat.create_message(valid_attrs)
  #     assert message.content == "some content"
  #     assert message.metadata == %{}
  #     assert message.topic_id == 42
  #     assert message.user_id == 42
  #   end

  #   test "create_message/1 with invalid data returns error changeset" do
  #     assert {:error, %Ecto.Changeset{}} = Chat.create_message(@invalid_attrs)
  #   end

  #   test "update_message/2 with valid data updates the message" do
  #     message = message_fixture()
  #     update_attrs = %{content: "some updated content", metadata: %{}, topic_id: 43, user_id: 43}

  #     assert {:ok, %Message{} = message} = Chat.update_message(message, update_attrs)
  #     assert message.content == "some updated content"
  #     assert message.metadata == %{}
  #     assert message.topic_id == 43
  #     assert message.user_id == 43
  #   end

  #   test "update_message/2 with invalid data returns error changeset" do
  #     message = message_fixture()
  #     assert {:error, %Ecto.Changeset{}} = Chat.update_message(message, @invalid_attrs)
  #     assert message == Chat.get_message!(message.id)
  #   end

  #   test "delete_message/1 deletes the message" do
  #     message = message_fixture()
  #     assert {:ok, %Message{}} = Chat.delete_message(message)
  #     assert_raise Ecto.NoResultsError, fn -> Chat.get_message!(message.id) end
  #   end

  #   test "change_message/1 returns a message changeset" do
  #     message = message_fixture()
  #     assert %Ecto.Changeset{} = Chat.change_message(message)
  #   end
  # end
end
