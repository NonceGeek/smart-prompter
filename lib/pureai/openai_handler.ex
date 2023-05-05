defmodule PureAI.OpenAIHandler do
  @moduledoc false

  require Logger

  @client Application.get_env(:openai, :client)
  @chat_completion_model "gpt-3.5-turbo"

  def chat_completion(messages) do
    Logger.info("chat_completion")

    @client.chat_completion(model: @chat_completion_model, messages: messages)
  end

  def completions(model, opts) do
    Logger.info("completions")

    @client.completions(model, opts)
  end
end
