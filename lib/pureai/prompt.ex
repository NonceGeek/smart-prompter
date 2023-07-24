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
  def list_prompt_templates(%{"user_id" => user_id}) do
    from(p in PromptTemplate,
      where: p.user_id == ^user_id
    )
    |> Repo.all()
  end

  def list_prompt_templates(_) do
    Repo.all(PromptTemplate)
  end

  @doc """
  Gets a single prompt_template.
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
  """
  def update_prompt_template(%PromptTemplate{} = prompt_template, attrs, current_user) do
    with true <- can_update_template?(prompt_template, current_user) do
      prompt_template
      |> PromptTemplate.changeset(attrs)
      |> Repo.update()
    else
      false -> {:error, :not_authorized}
      error -> error
    end
  end

  @doc """
  Deletes a prompt_template.
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
