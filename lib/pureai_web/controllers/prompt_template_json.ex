defmodule PureAIWeb.PromptTemplateJSON do
  alias PureAI.Prompt.PromptTemplate

  @doc """
  Renders a list of prompt_templates.
  """
  def index(%{prompt_templates: prompt_templates}) do
    %{data: for(prompt_template <- prompt_templates, do: data(prompt_template))}
  end

  @doc """
  Renders a single prompt_template.
  """
  def show(%{prompt_template: prompt_template}) do
    %{data: data(prompt_template)}
  end

  defp data(%PromptTemplate{} = prompt_template) do
    %{
      id: prompt_template.id,
      content: prompt_template.content,
      is_default: prompt_template.is_default
    }
  end
end
