defmodule PureAIWeb.EmberddingVectorController do
  use PureAIWeb, :controller

  alias PureAI.Context
  alias PureAI.Context.EmberddingVector

  action_fallback PureAIWeb.FallbackController

  def index(conn, _params) do
    embedding_vector = Context.list_embedding_vector()
    render(conn, :index, embedding_vector: embedding_vector)
  end

  def create(conn, %{"emberdding_vector" => emberdding_vector_params}) do
    with {:ok, %EmberddingVector{} = emberdding_vector} <- Context.create_emberdding_vector(emberdding_vector_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/embedding_vector/#{emberdding_vector}")
      |> render(:show, emberdding_vector: emberdding_vector)
    end
  end

  def show(conn, %{"id" => id}) do
    emberdding_vector = Context.get_emberdding_vector!(id)
    render(conn, :show, emberdding_vector: emberdding_vector)
  end

  def update(conn, %{"id" => id, "emberdding_vector" => emberdding_vector_params}) do
    emberdding_vector = Context.get_emberdding_vector!(id)

    with {:ok, %EmberddingVector{} = emberdding_vector} <- Context.update_emberdding_vector(emberdding_vector, emberdding_vector_params) do
      render(conn, :show, emberdding_vector: emberdding_vector)
    end
  end

  def delete(conn, %{"id" => id}) do
    emberdding_vector = Context.get_emberdding_vector!(id)

    with {:ok, %EmberddingVector{}} <- Context.delete_emberdding_vector(emberdding_vector) do
      send_resp(conn, :no_content, "")
    end
  end
end
