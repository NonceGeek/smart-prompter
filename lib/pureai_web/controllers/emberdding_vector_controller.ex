defmodule PureAIWeb.EmbeddingVectorController do
  use PureAIWeb, :controller

  alias PureAI.Context
  alias PureAI.Context.EmbeddingVector

  action_fallback PureAIWeb.FallbackController

  def index(conn, _params) do
    embedding_vector = Context.list_embedding_vector()
    render(conn, :index, embedding_vector: embedding_vector)
  end

  def create(conn, %{"embedding_vector" => embedding_vector_params}) do
    with {:ok, %EmbeddingVector{} = embedding_vector} <- Context.create_embedding_vector(embedding_vector_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/embedding_vector/#{embedding_vector}")
      |> render(:show, embedding_vector: embedding_vector)
    end
  end

  def show(conn, %{"id" => id}) do
    embedding_vector = Context.get_embedding_vector!(id)
    render(conn, :show, embedding_vector: embedding_vector)
  end

  def update(conn, %{"id" => id, "embedding_vector" => embedding_vector_params}) do
    embedding_vector = Context.get_embedding_vector!(id)

    with {:ok, %EmbeddingVector{} = embedding_vector} <- Context.update_embedding_vector(embedding_vector, embedding_vector_params) do
      render(conn, :show, embedding_vector: embedding_vector)
    end
  end

  def delete(conn, %{"id" => id}) do
    embedding_vector = Context.get_embedding_vector!(id)

    with {:ok, %EmbeddingVector{}} <- Context.delete_embedding_vector(embedding_vector) do
      send_resp(conn, :no_content, "")
    end
  end

  def text_to_vector(conn, %{"text" => text}) do
    {:ok, res} = Pureai.OpenaiEmbedding.text_to_vetor(text)
    render(conn, :show, embedding_vector: res)
  end
end
