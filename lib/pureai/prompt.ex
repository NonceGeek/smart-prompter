defmodule PureAI.Prompt do
  @moduledoc """
  The Prompt context.
  """

  import Ecto.Query, warn: false
  alias PureAI.Turbo
  alias PureAI.Repo

  alias PureAI.Accounts.User
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
  """
  def create_prompt_template(attrs, current_user) do
    with true <- can_create_template?(current_user) do
      new_attrs =
        attrs
        |> PureAI.MapEnhance.atomize_keys()
        |> Map.put(:user_id, current_user.id)

      Turbo.create(PromptTemplate, new_attrs)
    else
      false -> {:error, :not_authorized}
      error -> error
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
  def update_prompt_template(%PromptTemplate{} = prompt_template, attrs, current_user) do
    with true <- can_update_template?(prompt_template, current_user) do
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
  def delete_prompt_template(%PromptTemplate{} = prompt_template, current_user) do
    with true <- can_delete_template?(prompt_template, current_user) do
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

  defp can_create_template?(%User{} = _user), do: true
  defp can_create_template?(_), do: false

  defp can_update_template?(%{user_id: user_id}, %{id: user_id}), do: true
  defp can_update_template?(_, _), do: false

  defp can_delete_template?(%{user_id: user_id}, %{id: user_id}), do: true
  defp can_delete_template?(_), do: false
end
