defmodule PureAIWeb.TopicController do
  use PureAIWeb, :controller

  alias PureAI.Chat
  alias PureAI.Chat.Topic

  action_fallback PureAIWeb.FallbackController

  def index(conn, _params) do
    topics = Chat.list_topics()
    render(conn, :index, topics: topics)
  end

  def create(conn, %{"topic" => topic_params}) do
    with {:ok, %Topic{} = topic} <- Chat.create_topic(topic_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/topics/#{topic}")
      |> render(:show, topic: topic)
    end
  end

  def show(conn, %{"id" => id}) do
    topic = Chat.get_topic!(id)
    render(conn, :show, topic: topic)
  end

  def update(conn, %{"id" => id, "topic" => topic_params}) do
    topic = Chat.get_topic!(id)

    with {:ok, %Topic{} = topic} <- Chat.update_topic(topic, topic_params) do
      render(conn, :show, topic: topic)
    end
  end

  def delete(conn, %{"id" => id}) do
    topic = Chat.get_topic!(id)

    with {:ok, %Topic{}} <- Chat.delete_topic(topic) do
      send_resp(conn, :no_content, "")
    end
  end
end
