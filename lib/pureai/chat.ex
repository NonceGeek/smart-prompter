defmodule PureAI.Chat do
  @moduledoc """
  The Chat context.
  """

  import Ecto.Query, warn: false

  alias Ecto.Multi
  alias PureAI.{Repo, Turbo}

  alias PureAI.Prompt.PromptTemplate
  alias PureAI.Accounts.User
  alias PureAI.Chat.{Topic, Message}

  @doc """
  Returns the list of topics.

  ## Examples

      iex> list_topics()
      [%Topic{}, ...]

  """
  def list_topics(current_user) do
    from(t in Topic, where: t.user_id == ^current_user.id, order_by: [asc: t.inserted_at])
    |> Repo.all()
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
      order_by: [asc: m.position],
      select: %{role: m.role, content: m.content}
    )
    |> Repo.all()
  end

  @doc """
  Creates a topic with first message
  """
  def create_topic(attrs, current_user) do
    # - [x] create topic
    # - [x] create message
    # - [x] job -> openai

    attrs = PureAI.MapEnhance.atomize_keys(attrs)

    with true <- can_create_topic?(current_user) do
      Multi.new()
      |> do_create_topic(attrs, current_user)
      |> do_create_template_message(attrs)
      |> do_create_message(attrs)
      |> Repo.transaction()
      |> case do
        {:ok, %{create_topic: topic, create_message: message}} ->
          %{type: "chat_completion", topic_id: topic.id}
          |> PureAI.Chat.Job.new()
          |> Oban.insert()

          {:ok, topic}

        # {:ok, Repo.preload(topic, [:messages])}

        error ->
          error
      end
    else
      false -> {:error, :not_authorized}
      error -> error
    end
  end

  def create_topic_with_answer(attrs, current_user) do
    attrs = PureAI.MapEnhance.atomize_keys(attrs)

    with true <- can_create_topic?(current_user) do
      Multi.new()
      |> do_create_topic(attrs, current_user)
      |> do_create_question(attrs)
      |> do_create_answer(attrs)
      |> Repo.transaction()
      |> case do
        {:ok, %{create_topic: topic}} ->
          {:ok, Repo.preload(topic, [:messages])}

        error ->
          error
      end
    else
      false -> {:error, :not_authorized}
      error -> error
    end
  end

  defp do_create_topic(multi, attrs, current_user) do
    run_fn = fn _, _ ->
      new_attrs = attrs |> Map.put(:user_id, current_user.id)
      Turbo.create(Topic, new_attrs)
    end

    Multi.run(multi, :create_topic, run_fn)
  end

  defp do_create_template_message(multi, %{prompt_template_id: prompt_template_id} = attrs) do
    run_fn = fn _, %{create_topic: topic} ->
      with {:ok, template} <- Turbo.get(PromptTemplate, prompt_template_id) do
        new_attrs = %{
          topic_id: topic.id,
          role: :system,
          position: 1,
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
      position =
        case Map.get(attrs, :prompt_template_id) do
          nil -> 1
          _ -> 2
        end

      new_attrs = %{
        role: :user,
        content: content,
        position: position,
        topic_id: topic.id
      }

      Turbo.create(Message, new_attrs)
    end

    Multi.run(multi, :create_message, run_fn)
  end

  defp do_create_question(multi, %{question: question} = attrs) do
    run_fn = fn _, %{create_topic: topic} ->
      position =
        case Map.get(attrs, :prompt_template_id) do
          nil -> 1
          _ -> 2
        end

      new_attrs = %{
        role: :user,
        content: question,
        position: position,
        topic_id: topic.id
      }

      Turbo.create(Message, new_attrs)
    end

    Multi.run(multi, :create_question, run_fn)
  end

  defp do_create_answer(multi, %{answer: answer} = attrs) do
    run_fn = fn _, %{create_topic: topic} ->
      position =
        case Map.get(attrs, :prompt_template_id) do
          nil -> 1
          _ -> 2
        end

      new_attrs = %{
        role: :user,
        content: answer,
        position: position,
        topic_id: topic.id
      }

      Turbo.create(Message, new_attrs)
    end

    Multi.run(multi, :create_answer, run_fn)
  end

  def next_position(topic_id) do
    {:ok, cur_count} =
      from(m in Message, where: m.topic_id == ^topic_id)
      |> Turbo.count()

    cur_count + 1
  end

  @doc """
  add topic message
  """
  def add_message(topic_id, content, current_user) do
    request = %{
      topic_id: topic_id,
      role: :user,
      position: next_position(topic_id),
      content: content
    }

    with {:ok, topic} <- Turbo.get(Topic, topic_id),
         true <- can_add_message?(topic, current_user),
         {:ok, message} <- Turbo.create(Message, request) do
      %{type: "chat_completion", topic_id: message.topic_id}
      |> PureAI.Chat.Job.new()
      |> Oban.insert()

      {:ok, message}

      # TODO [ ] boradcast
    else
      false -> {:error, :not_authorized}
      error -> error
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
  def delete_topic(%Topic{} = topic, _current_user) do
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

  defp can_create_topic?(%User{} = _current_user), do: true
  defp can_create_topic?(_), do: false

  defp can_add_message?(%{user_id: user_id}, %{id: id} = _current_user), do: user_id == id
  defp can_add_message?(_, _), do: false

  # defp done({:ok, %{create_topic: result}}), do: {:ok, result}
  defp done({:ok, %{create_message: result}}), do: {:ok, result}
  defp done({:error, :create_topic, error, _}), do: {:error, error}
  defp done({:error, error}), do: {:error, error}
end
