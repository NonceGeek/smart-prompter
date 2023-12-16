defmodule PureAI.ContextFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PureAI.Context` context.
  """

  @doc """
  Generate a emberdding_vector.
  """
  def emberdding_vector_fixture(attrs \\ %{}) do
    {:ok, emberdding_vector} =
      attrs
      |> Enum.into(%{
        sha: "some sha",
        text: "some text",
        vector: "some vector"
      })
      |> PureAI.Context.create_emberdding_vector()

    emberdding_vector
  end
end
