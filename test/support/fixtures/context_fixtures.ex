defmodule PureAI.ContextFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PureAI.Context` context.
  """

  @doc """
  Generate a embedding_vector.
  """
  def embedding_vector_fixture(attrs \\ %{}) do
    {:ok, embedding_vector} =
      attrs
      |> Enum.into(%{
        sha: "some sha",
        text: "some text",
        vector: "some vector"
      })
      |> PureAI.Context.create_embedding_vector()

    embedding_vector
  end
end
