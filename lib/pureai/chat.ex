defmodule PureAI.Chat do
  @moduledoc """
  The Chat context.
  """

  import Ecto.Query, warn: false

  alias Ecto.Multi
  alias PureAI.{Repo, Turbo}

  alias PureAI.Prompt.PromptTemplate
  alias PureAI.Chat.{Topic, Message}

  @doc """
  Returns the list of topics.

  ## Examples

      iex> list_topics()
      [%Topic{}, ...]

  """
  def list_topics do
    Repo.all(Topic)
  end

  @doc """
  Gets a single topic.

  Raises `Ecto.NoResultsError` if the Topic does not exist.

  ## Examples

      iex> get_topic!(123)
      %Topic{}

      iex> get_topic!(456)
      ** (Ecto.NoResultsError)

  """
  def get_topic!(id), do: Repo.get!(Topic, id)

  @doc """
  get topic
  """
  def get_topic(clauses) when is_binary(clauses) or is_integer(clauses), do: Turbo.get(Topic, clauses, preload: [:messages])
  def get_topic(clauses) when is_list(clauses) or is_map(clauses), do: Turbo.get_by(Topic, clauses, preload: [:messages])

  @doc """
  get topic messages, desc by inserted_at
  """
  def get_topic_messages(topic_id) do
    from(
      m in Message,
      where: m.topic_id == ^topic_id,
      order_by: [desc: m.inserted_at],
      select: %{role: m.role, content: m.content}
    )
    |> Repo.all()
  end

  @doc """
  Creates a topic with first message
  """
  def create_topic(attrs \\ %{}) do
    # - [x] create topic
    # - [x] create message
    # - [x] job -> openai

    with true <- can_create_topic?() do
      Multi.new()
      |> do_create_topic(attrs)
      |> do_create_template_message(attrs)
      |> do_create_message(attrs)
      |> Repo.transaction()
      |> case do
        {:ok, %{create_topic: topic, create_message: message}} ->
          %{type: "chat_completion", topic_id: topic.id}
          |> PureAI.Chat.Job.new()
          |> Oban.insert()

          {:ok, Repo.preload(topic, [:messages])}

        error ->
          error
      end
    end
  end

  defp do_create_topic(multi, attrs) do
    run_fn = fn _, _ ->
      Turbo.create(Topic, attrs)
    end

    Multi.run(multi, :create_topic, run_fn)
  end

  defp do_create_template_message(multi, %{prompt_template_id: prompt_template_id} = attrs) do
    run_fn = fn _, %{create_topic: topic} ->
      with {:ok, template} <- Turbo.get(PromptTemplate, prompt_template_id) do
        new_attrs = %{
          topic_id: topic.id,
          role: :system,
          content: template.content
        }

        Turbo.create(Message, new_attrs)
      else
        _ -> {:error, :not_found_template}
      end
    end

    Multi.run(multi, :create_template_message, run_fn)
  end

  defp do_create_template_message(multi, _), do: multi

  defp do_create_message(multi, %{content: content} = attrs) do
    run_fn = fn _, %{create_topic: topic} ->
      new_attrs = %{
        role: :user,
        content: content,
        topic_id: topic.id
      }

      Turbo.create(Message, new_attrs)
    end

    Multi.run(multi, :create_message, run_fn)
  end

  @doc """
  add topic message
  """
  def add_message(topic_id, content) do
    request = %{
      topic_id: topic_id,
      role: :user,
      content: content
    }

    with true <- can_add_message?(),
         {:ok, message} <- Turbo.create(Message, request) do
      %{type: "chat_completion", topic_id: message.topic_id}
      |> PureAI.Chat.Job.new()
      |> Oban.insert()

      {:ok, message}

      # TODO [ ] boradcast
    else
      {:error, _} ->
        {:error, "add message failed"}
    end
  end

  @doc """
  Updates a topic.

  ## Examples

      iex> update_topic(topic, %{field: new_value})
      {:ok, %Topic{}}

      iex> update_topic(topic, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_topic(%Topic{} = topic, attrs) do
    topic
    |> Topic.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a topic.

  ## Examples

      iex> delete_topic(topic)
      {:ok, %Topic{}}

      iex> delete_topic(topic)
      {:error, %Ecto.Changeset{}}

  """
  def delete_topic(%Topic{} = topic) do
    Repo.delete(topic)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking topic changes.

  ## Examples

      iex> change_topic(topic)
      %Ecto.Changeset{data: %Topic{}}

  """
  def change_topic(%Topic{} = topic, attrs \\ %{}) do
    Topic.changeset(topic, attrs)
  end

  alias PureAI.Chat.Message

  @doc """
  Returns the list of messages.

  ## Examples

      iex> list_messages()
      [%Message{}, ...]

  """
  def list_messages do
    Repo.all(Message)
  end

  @doc """
  Gets a single message.

  Raises `Ecto.NoResultsError` if the Message does not exist.

  ## Examples

      iex> get_message!(123)
      %Message{}

      iex> get_message!(456)
      ** (Ecto.NoResultsError)

  """
  def get_message!(id), do: Repo.get!(Message, id)

  @doc """
  Creates a message.

  ## Examples

      iex> create_message(%{field: value})
      {:ok, %Message{}}

      iex> create_message(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_message(attrs \\ %{}) do
    %Message{}
    |> Message.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a message.

  ## Examples

      iex> update_message(message, %{field: new_value})
      {:ok, %Message{}}

      iex> update_message(message, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_message(%Message{} = message, attrs) do
    message
    |> Message.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a message.

  ## Examples

      iex> delete_message(message)
      {:ok, %Message{}}

      iex> delete_message(message)
      {:error, %Ecto.Changeset{}}

  """
  def delete_message(%Message{} = message) do
    Repo.delete(message)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking message changes.

  ## Examples

      iex> change_message(message)
      %Ecto.Changeset{data: %Message{}}

  """
  def change_message(%Message{} = message, attrs \\ %{}) do
    Message.changeset(message, attrs)
  end

  defp can_create_topic?(), do: true
  defp can_add_message?(), do: true

  # defp done({:ok, %{create_topic: result}}), do: {:ok, result}
  defp done({:ok, %{create_message: result}}), do: {:ok, result}
  defp done({:error, :create_topic, error, _}), do: {:error, error}
  defp done({:error, error}), do: {:error, error}
end
