defmodule PureAIWeb.TopicControllerTest do
  use PureAIWeb.ConnCase

  # import PureAI.ChatFixtures

  # alias PureAI.Chat.Topic

  # @create_attrs %{
  #   metadata: %{},
  #   prompt_template_id: 42,
  #   prompt_text: "some prompt_text",
  #   user_id: 42
  # }
  # @update_attrs %{
  #   metadata: %{},
  #   prompt_template_id: 43,
  #   prompt_text: "some updated prompt_text",
  #   user_id: 43
  # }
  # @invalid_attrs %{metadata: nil, prompt_template_id: nil, prompt_text: nil, user_id: nil}

  # setup %{conn: conn} do
  #   {:ok, conn: put_req_header(conn, "accept", "application/json")}
  # end

  # describe "index" do
  #   test "lists all topics", %{conn: conn} do
  #     conn = get(conn, ~p"/api/topics")
  #     assert json_response(conn, 200)["data"] == []
  #   end
  # end

  # describe "create topic" do
  #   test "renders topic when data is valid", %{conn: conn} do
  #     conn = post(conn, ~p"/api/topics", topic: @create_attrs)
  #     assert %{"id" => id} = json_response(conn, 201)["data"]

  #     conn = get(conn, ~p"/api/topics/#{id}")

  #     assert %{
  #              "id" => ^id,
  #              "metadata" => %{},
  #              "prompt_template_id" => 42,
  #              "prompt_text" => "some prompt_text",
  #              "user_id" => 42
  #            } = json_response(conn, 200)["data"]
  #   end

  #   test "renders errors when data is invalid", %{conn: conn} do
  #     conn = post(conn, ~p"/api/topics", topic: @invalid_attrs)
  #     assert json_response(conn, 422)["errors"] != %{}
  #   end
  # end

  # describe "update topic" do
  #   setup [:create_topic]

  #   test "renders topic when data is valid", %{conn: conn, topic: %Topic{id: id} = topic} do
  #     conn = put(conn, ~p"/api/topics/#{topic}", topic: @update_attrs)
  #     assert %{"id" => ^id} = json_response(conn, 200)["data"]

  #     conn = get(conn, ~p"/api/topics/#{id}")

  #     assert %{
  #              "id" => ^id,
  #              "metadata" => %{},
  #              "prompt_template_id" => 43,
  #              "prompt_text" => "some updated prompt_text",
  #              "user_id" => 43
  #            } = json_response(conn, 200)["data"]
  #   end

  #   test "renders errors when data is invalid", %{conn: conn, topic: topic} do
  #     conn = put(conn, ~p"/api/topics/#{topic}", topic: @invalid_attrs)
  #     assert json_response(conn, 422)["errors"] != %{}
  #   end
  # end

  # describe "delete topic" do
  #   setup [:create_topic]

  #   test "deletes chosen topic", %{conn: conn, topic: topic} do
  #     conn = delete(conn, ~p"/api/topics/#{topic}")
  #     assert response(conn, 204)

  #     assert_error_sent 404, fn ->
  #       get(conn, ~p"/api/topics/#{topic}")
  #     end
  #   end
  # end

  # defp create_topic(_) do
  #   topic = topic_fixture()
  #   %{topic: topic}
  # end
end
