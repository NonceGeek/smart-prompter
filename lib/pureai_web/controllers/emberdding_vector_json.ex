defmodule PureAIWeb.EmberddingVectorJSON do
  alias PureAI.Context.EmberddingVector

  @doc """
  Renders a list of embedding_vector.
  """
  def index(%{embedding_vector: embedding_vector}) do
    %{data: for(emberdding_vector <- embedding_vector, do: data(emberdding_vector))}
  end

  @doc """
  Renders a single emberdding_vector.
  """
  def show(%{emberdding_vector: emberdding_vector}) do
    %{data: data(emberdding_vector)}
  end

  defp data(%EmberddingVector{} = emberdding_vector) do
    %{
      id: emberdding_vector.id,
      sha: emberdding_vector.sha,
      text: emberdding_vector.text,
      vector: emberdding_vector.vector
    }
  end
end
