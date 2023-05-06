defmodule PureAIWeb.TopicController do
  use PureAIWeb, :controller

  alias PureAI.Chat
  alias PureAI.Chat.Topic

  action_fallback PureAIWeb.FallbackController

  def index(conn, _params) do
    current_user = conn.assigns.current_user

    topics = Chat.list_topics(current_user)

    render(conn, :index, topics: topics)
  end

  def create(conn, %{"topic" => topic_params}) do
    current_user = conn.assigns.current_user

    with {:ok, %Topic{} = topic} <- Chat.create_topic(topic_params, current_user) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/topics/#{topic}")
      |> render(:show, topic: topic)
    end
  end

  def show(conn, %{"id" => id}) do
    current_user = conn.assigns.current_user

    {:ok, topic} = Chat.get_topic(id)

    if topic.user_id != current_user.id do
      conn
      |> put_status(:forbidden)
      |> put_view(json: PureAIWeb.ErrorJSON)
      |> render(:"401")
    else
      render(conn, :show, topic: topic)
    end
  end

  # def update(conn, %{"id" => id, "topic" => topic_params}) do
  #   topic = Chat.get_topic!(id)

  #   with {:ok, %Topic{} = topic} <- Chat.update_topic(topic, topic_params) do
  #     render(conn, :show, topic: topic)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   topic = Chat.get_topic!(id)

  #   with {:ok, %Topic{}} <- Chat.delete_topic(topic) do
  #     send_resp(conn, :no_content, "")
  #   end
  # end
end
