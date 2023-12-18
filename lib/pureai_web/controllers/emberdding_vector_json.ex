defmodule PureAIWeb.EmbeddingVectorJSON do
  alias PureAI.Context.EmbeddingVector

  @doc """
  Renders a list of embedding_vector.
  """
  def index(%{embedding_vector: embedding_vector}) do
    %{data: for(embedding_vector <- embedding_vector, do: data(embedding_vector))}
  end

  @doc """
  Renders a single embedding_vector.
  """
  def show(%{embedding_vector: embedding_vector}) do
    %{data: data(embedding_vector)}
  end

  defp data(%EmbeddingVector{} = embedding_vector) do
    %{
      id: embedding_vector.id,
      sha: embedding_vector.sha,
      text: embedding_vector.text,
      vector: embedding_vector.vector
    }
  end
end
