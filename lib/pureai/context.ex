defmodule PureAI.Context do
  @moduledoc """
  The Context context.
  """

  import Ecto.Query, warn: false
  alias PureAI.Repo

  alias PureAI.Context.EmberddingVector

  @doc """
  Returns the list of embedding_vector.

  ## Examples

      iex> list_embedding_vector()
      [%EmberddingVector{}, ...]

  """
  def list_embedding_vector do
    Repo.all(EmberddingVector)
  end
  @doc """
  Gets a single emberdding_vector by sha.

  return nil if the Emberdding vector does not exist.

  ## Examples

      iex> get_emberdding_vector_by_sha("xxxx")
      %EmberddingVector{}
      iex> get_emberdding_vector_by_sha("")
      nil

  """

  def get_emberdding_vector_by_sha(sha), do: Repo.get_by(EmberddingVector, %{:sha => sha})
  @doc """
  Gets a single emberdding_vector.

  Raises `Ecto.NoResultsError` if the Emberdding vector does not exist.

  ## Examples

      iex> get_emberdding_vector!(123)
      %EmberddingVector{}

      iex> get_emberdding_vector!(456)
      ** (Ecto.NoResultsError)

  """
  def get_emberdding_vector!(id), do: Repo.get!(EmberddingVector, id)

  @doc """
  Creates a emberdding_vector.

  ## Examples

      iex> create_emberdding_vector(%{field: value})
      {:ok, %EmberddingVector{}}

      iex> create_emberdding_vector(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_emberdding_vector(attrs \\ %{}) do
    %EmberddingVector{}
    |> EmberddingVector.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a emberdding_vector.

  ## Examples

      iex> update_emberdding_vector(emberdding_vector, %{field: new_value})
      {:ok, %EmberddingVector{}}

      iex> update_emberdding_vector(emberdding_vector, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_emberdding_vector(%EmberddingVector{} = emberdding_vector, attrs) do
    emberdding_vector
    |> EmberddingVector.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a emberdding_vector.

  ## Examples

      iex> delete_emberdding_vector(emberdding_vector)
      {:ok, %EmberddingVector{}}

      iex> delete_emberdding_vector(emberdding_vector)
      {:error, %Ecto.Changeset{}}

  """
  def delete_emberdding_vector(%EmberddingVector{} = emberdding_vector) do
    Repo.delete(emberdding_vector)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking emberdding_vector changes.

  ## Examples

      iex> change_emberdding_vector(emberdding_vector)
      %Ecto.Changeset{data: %EmberddingVector{}}

  """
  def change_emberdding_vector(%EmberddingVector{} = emberdding_vector, attrs \\ %{}) do
    EmberddingVector.changeset(emberdding_vector, attrs)
  end
end
