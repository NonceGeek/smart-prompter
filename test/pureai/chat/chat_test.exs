defmodule PureAI.ChatTest do
  @moduledoc false

  use PureAI.DataCase

  import PureAI.AccountsFixtures
  import PureAI.ChatFixtures
  import PureAI.PromptFixtures

  alias PureAI.Chat
  alias PureAI.Repo
  alias PureAI.Chat.Topic

  describe "topics" do
    test "list user topics" do
      user = user_fixture()
      topic = topic_fixture(user)

      assert Chat.list_topics(user) == [topic]
    end

    test "get one topic" do
      assert true
    end

    test "create new topic" do
      user = user_fixture()
      topic = topic_fixture(user)

      assert %Topic{} = topic
    end

    test "create topic with template" do
      user = user_fixture()

      template_attrs = %{
        title: "Act as a English Teacher and Improver",
        content:
          "I want you to act as a spoken English teacher and improver. I will speak to you in English and you will reply to me in English to practice my spoken English. I want you to keep your reply neat, limiting the reply to 100 words. I want you to strictly correct my grammar mistakes, typos, and factual errors. I want you to ask me a question in your reply. Now let’s start practicing, you could ask me a question first. Remember, I want you to strictly correct my grammar mistakes, typos, and factual errors."
      }

      template = prompt_template_fixture(user, template_attrs)
      topic = topic_fixture(user, %{prompt_template_id: template.id, content: "hello"})

      assert %Topic{} = topic
    end

    test "delete user topic" do
      assert true
    end

    test "chat with new message" do
      user = user_fixture()
      topic = topic_fixture(user, %{content: "hello world"})

      {:ok, message} = Chat.add_message(topic.id, "hello world 2", user)
      {:ok, topic} = Chat.get_topic(message.topic_id)

      assert length(topic.messages) == 4
    end
  end
end
