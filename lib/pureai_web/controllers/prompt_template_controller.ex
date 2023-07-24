defmodule PureAIWeb.PromptTemplateController do
  use PureAIWeb, :controller

  alias PureAI.Prompt
  alias PureAI.Prompt.PromptTemplate

  action_fallback PureAIWeb.FallbackController

  def index(conn, params) do
    prompt_templates = Prompt.list_prompt_templates(params)
    render(conn, :index, prompt_templates: prompt_templates)
  end

  def create(conn, %{"prompt_template" => prompt_template_params}) do
    current_user = conn.assigns.current_user

    with {:ok, %PromptTemplate{} = prompt_template} <-
           Prompt.create_prompt_template(prompt_template_params, current_user) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/prompt_templates/#{prompt_template}")
      |> render(:show, prompt_template: prompt_template)
    end
  end

  def show(conn, %{"id" => id}) do
    # current_user = conn.assigns.current_user

    prompt_template = Prompt.get_prompt_template!(id)

    # if prompt_template.user_id != current_user.id do
    #   conn
    #   |> put_status(:forbidden)
    #   |> put_view(json: PureAIWeb.ErrorJSON)
    #   |> render(:"401")
    # else
    render(conn, :show, prompt_template: prompt_template)
    # end
  end

  def update(conn, %{"id" => id, "prompt_template" => prompt_template_params}) do
    current_user = conn.assigns.current_user
    prompt_template = Prompt.get_prompt_template!(id)

    with {:ok, %PromptTemplate{} = prompt_template} <-
           Prompt.update_prompt_template(prompt_template, prompt_template_params, current_user) do
      render(conn, :show, prompt_template: prompt_template)
    end
  end

  def delete(conn, %{"id" => id}) do
    current_user = conn.assigns.current_user
    prompt_template = Prompt.get_prompt_template!(id)

    with {:ok, %PromptTemplate{}} <- Prompt.delete_prompt_template(prompt_template, current_user) do
      send_resp(conn, :no_content, "")
    end
  end
end
