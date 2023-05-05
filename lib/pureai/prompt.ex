defmodule PureAI.Prompt do
  @moduledoc """
  The Prompt context.
  """

  import Ecto.Query, warn: false
  alias PureAI.Repo

  alias PureAI.Prompt.PromptTemplate

  @doc """
  Returns the list of prompt_templates.

  ## Examples

      iex> list_prompt_templates()
      [%PromptTemplate{}, ...]

  """
  def list_prompt_templates do
    Repo.all(PromptTemplate)
  end

  @doc """
  Gets a single prompt_template.

  Raises `Ecto.NoResultsError` if the Prompt template does not exist.

  ## Examples

      iex> get_prompt_template!(123)
      %PromptTemplate{}

      iex> get_prompt_template!(456)
      ** (Ecto.NoResultsError)

  """
  def get_prompt_template!(id), do: Repo.get!(PromptTemplate, id)

  @doc """
  Creates a prompt_template.

  ## Examples

      iex> create_prompt_template(%{field: value})
      {:ok, %PromptTemplate{}}

      iex> create_prompt_template(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_prompt_template(attrs \\ %{}) do
    with true <- can_create_template?() do
      %PromptTemplate{}
      |> PromptTemplate.changeset(attrs)
      |> Repo.insert()
    end
  end

  @doc """
  Updates a prompt_template.

  ## Examples

      iex> update_prompt_template(prompt_template, %{field: new_value})
      {:ok, %PromptTemplate{}}

      iex> update_prompt_template(prompt_template, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_prompt_template(%PromptTemplate{} = prompt_template, attrs) do
    with true <- can_update_template?() do
      prompt_template
      |> PromptTemplate.changeset(attrs)
      |> Repo.update()
    end
  end

  @doc """
  Deletes a prompt_template.

  ## Examples

      iex> delete_prompt_template(prompt_template)
      {:ok, %PromptTemplate{}}

      iex> delete_prompt_template(prompt_template)
      {:error, %Ecto.Changeset{}}

  """
  def delete_prompt_template(%PromptTemplate{} = prompt_template) do
    with true <- can_delete_template?() do
      Repo.delete(prompt_template)
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking prompt_template changes.

  ## Examples

      iex> change_prompt_template(prompt_template)
      %Ecto.Changeset{data: %PromptTemplate{}}

  """
  def change_prompt_template(%PromptTemplate{} = prompt_template, attrs \\ %{}) do
    PromptTemplate.changeset(prompt_template, attrs)
  end

  defp can_create_template?, do: true
  defp can_update_template?, do: true
  defp can_delete_template?, do: true
end
