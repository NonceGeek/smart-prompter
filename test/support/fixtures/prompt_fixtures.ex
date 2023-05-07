defmodule PureAI.PromptFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PureAI.Prompt` context.
  """

  @doc """
  Generate a prompt_template.
  """
  def prompt_template_fixture(current_user, attrs \\ %{}) do
    {:ok, prompt_template} =
      attrs
      |> Enum.into(%{
        content: "some content",
        is_default: true,
        title: "some title"
      })
      |> PureAI.Prompt.create_prompt_template(current_user)

    prompt_template
  end
end
