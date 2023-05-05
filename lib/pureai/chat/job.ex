defmodule PureAI.Chat.Job do
  @moduledoc false
  use Oban.Worker, queue: :default, max_attempts: 10

  require Logger

  alias PureAI.Turbo
  alias PureAI.OpenAIHandler

  alias PureAI.Chat
  alias PureAI.Chat.Message

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"type" => "chat_completion", "topic_id" => topic_id} = _args}) do
    with messages when messages != [] <- Chat.get_topic_messages(topic_id),
         {:ok, %{choices: [data], usage: usage}} <- OpenAIHandler.chat_completion(messages) do
      %{"finish_reason" => finish_reason, "index" => index, "message" => %{"content" => content, "role" => role}} = data

      attrs = %{
        topic_id: topic_id,
        metadata: usage,
        content: content,
        finish_reason: finish_reason,
        role: role,
        index: index
      }

      Logger.info("attrs: %{inspect(attrs)}")

      Turbo.create(Message, attrs)
    else
      _ ->
        Logger.error("chat_completion failed")

        :error
    end
  end

  # def perform(%Oban.Job{args: %{"type" => "completion", "params" => params} = _args}) do
  #   IO.inspect("hello world")
  #   IO.inspect(params, label: "params")

  #   :ok
  # end
end
