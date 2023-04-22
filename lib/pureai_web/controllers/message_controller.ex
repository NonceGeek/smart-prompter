defmodule PureAIWeb.MessageController do
  @moduledoc false

  use PureAIWeb, :controller

  alias PureAI.Chat
  alias PureAI.Chat.Message

  action_fallback PureAIWeb.FallbackController

  def index(conn, _params) do
    messages = Chat.list_messages()
    render(conn, :index, messages: messages)
  end

  def create(conn, %{"message" => message_params}) do
    with {:ok, %Message{} = message} <- Chat.create_message(message_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/messages/#{message}")
      |> render(:show, message: message)
    end
  end

  def show(conn, %{"id" => id}) do
    message = Chat.get_message!(id)
    render(conn, :show, message: message)
  end
end
