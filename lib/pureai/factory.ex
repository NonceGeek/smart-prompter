defmodule PureAI.Factory do
  @moduledoc false

  use ExMachina.Ecto, repo: PureAI.Repo

  alias PureAI.Accounts.{User, UserToken}
  alias PureAI.Chat.{Topic, Message}
  alias PureAI.Prompt.{PromptTemplate}

  def user_factory() do
    %User{
      email: sequence(:email, &"email-#{&1}")
    }
  end

  def topic_factory() do
    %Topic{
      messages: build_pair(:message)
    }
  end

  def message_factory() do
    %Message{
      role: Enum.random(~w(system user assistant)a),
      content: sequence(:content, &"content-#{&1}")
    }
  end

  def prompt_template_factory() do
    %PromptTemplate{
      title: sequence(:title, &"title-#{&1}"),
      content: sequence(:content, &"content-#{&1}"),
      is_default: false
    }
  end
end
