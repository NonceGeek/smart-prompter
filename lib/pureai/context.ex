defmodule PureAI.Context do
  @moduledoc """
  The Context context.
  """

  import Ecto.Query, warn: false
  alias PureAI.Repo

  alias PureAI.Context.EmbeddingVector

  @doc """
  Returns the list of embedding_vector.

  ## Examples

      iex> list_embedding_vector()
      [%EmbeddingVector{}, ...]

  """
  def list_embedding_vector do
    Repo.all(EmbeddingVector)
  end
  @doc """
  Gets a single embedding_vector by sha.

  return nil if the embedding vector does not exist.

  ## Examples

      iex> get_embedding_vector_by_sha("xxxx")
      %EmbeddingVector{}
      iex> get_embedding_vector_by_sha("")
      nil

  """

  def get_embedding_vector_by_sha(sha), do: Repo.get_by(EmbeddingVector, %{:sha => sha})
  @doc """
  Gets a single embedding_vector.

  Raises `Ecto.NoResultsError` if the embedding vector does not exist.

  ## Examples

      iex> get_embedding_vector!(123)
      %EmbeddingVector{}

      iex> get_embedding_vector!(456)
      ** (Ecto.NoResultsError)

  """
  def get_embedding_vector!(id), do: Repo.get!(EmbeddingVector, id)

  @doc """
  Creates a embedding_vector.

  ## Examples

      iex> create_embedding_vector(%{field: value})
      {:ok, %EmbeddingVector{}}

      iex> create_embedding_vector(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_embedding_vector(attrs \\ %{}) do
    %EmbeddingVector{}
    |> EmbeddingVector.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a embedding_vector.

  ## Examples

      iex> update_embedding_vector(embedding_vector, %{field: new_value})
      {:ok, %EmbeddingVector{}}

      iex> update_embedding_vector(embedding_vector, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_embedding_vector(%EmbeddingVector{} = embedding_vector, attrs) do
    embedding_vector
    |> EmbeddingVector.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a embedding_vector.

  ## Examples

      iex> delete_embedding_vector(embedding_vector)
      {:ok, %EmbeddingVector{}}

      iex> delete_embedding_vector(embedding_vector)
      {:error, %Ecto.Changeset{}}

  """
  def delete_embedding_vector(%EmbeddingVector{} = embedding_vector) do
    Repo.delete(embedding_vector)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking embedding_vector changes.

  ## Examples

      iex> change_embedding_vector(embedding_vector)
      %Ecto.Changeset{data: %EmbeddingVector{}}

  """
  def change_embedding_vector(%EmbeddingVector{} = embedding_vector, attrs \\ %{}) do
    EmbeddingVector.changeset(embedding_vector, attrs)
  end
end
