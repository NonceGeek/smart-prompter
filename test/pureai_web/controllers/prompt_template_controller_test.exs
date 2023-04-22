defmodule PureAIWeb.PromptTemplateControllerTest do
  use PureAIWeb.ConnCase

  # import PureAI.PromptFixtures

  # alias PureAI.Prompt.PromptTemplate

  # @create_attrs %{
  #   content: "some content",
  #   is_default: true
  # }
  # @update_attrs %{
  #   content: "some updated content",
  #   is_default: false
  # }
  # @invalid_attrs %{content: nil, is_default: nil}

  # setup %{conn: conn} do
  #   {:ok, conn: put_req_header(conn, "accept", "application/json")}
  # end

  # describe "index" do
  #   test "lists all prompt_templates", %{conn: conn} do
  #     conn = get(conn, ~p"/api/prompt_templates")
  #     assert json_response(conn, 200)["data"] == []
  #   end
  # end

  # describe "create prompt_template" do
  #   test "renders prompt_template when data is valid", %{conn: conn} do
  #     conn = post(conn, ~p"/api/prompt_templates", prompt_template: @create_attrs)
  #     assert %{"id" => id} = json_response(conn, 201)["data"]

  #     conn = get(conn, ~p"/api/prompt_templates/#{id}")

  #     assert %{
  #              "id" => ^id,
  #              "content" => "some content",
  #              "is_default" => true
  #            } = json_response(conn, 200)["data"]
  #   end

  #   test "renders errors when data is invalid", %{conn: conn} do
  #     conn = post(conn, ~p"/api/prompt_templates", prompt_template: @invalid_attrs)
  #     assert json_response(conn, 422)["errors"] != %{}
  #   end
  # end

  # describe "update prompt_template" do
  #   setup [:create_prompt_template]

  #   test "renders prompt_template when data is valid", %{
  #     conn: conn,
  #     prompt_template: %PromptTemplate{id: id} = prompt_template
  #   } do
  #     conn =
  #       put(conn, ~p"/api/prompt_templates/#{prompt_template}", prompt_template: @update_attrs)

  #     assert %{"id" => ^id} = json_response(conn, 200)["data"]

  #     conn = get(conn, ~p"/api/prompt_templates/#{id}")

  #     assert %{
  #              "id" => ^id,
  #              "content" => "some updated content",
  #              "is_default" => false
  #            } = json_response(conn, 200)["data"]
  #   end

  #   test "renders errors when data is invalid", %{conn: conn, prompt_template: prompt_template} do
  #     conn =
  #       put(conn, ~p"/api/prompt_templates/#{prompt_template}", prompt_template: @invalid_attrs)

  #     assert json_response(conn, 422)["errors"] != %{}
  #   end
  # end

  # describe "delete prompt_template" do
  #   setup [:create_prompt_template]

  #   test "deletes chosen prompt_template", %{conn: conn, prompt_template: prompt_template} do
  #     conn = delete(conn, ~p"/api/prompt_templates/#{prompt_template}")
  #     assert response(conn, 204)

  #     assert_error_sent 404, fn ->
  #       get(conn, ~p"/api/prompt_templates/#{prompt_template}")
  #     end
  #   end
  # end

  # defp create_prompt_template(_) do
  #   prompt_template = prompt_template_fixture()
  #   %{prompt_template: prompt_template}
  # end
end
