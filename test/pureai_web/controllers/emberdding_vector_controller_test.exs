defmodule PureAIWeb.EmberddingVectorControllerTest do
  use PureAIWeb.ConnCase

  import PureAI.ContextFixtures

  alias PureAI.Context.EmberddingVector

  @create_attrs %{
    sha: "some sha",
    text: "some text",
    vector: "some vector"
  }
  @update_attrs %{
    sha: "some updated sha",
    text: "some updated text",
    vector: "some updated vector"
  }
  @invalid_attrs %{sha: nil, text: nil, vector: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all embedding_vector", %{conn: conn} do
      conn = get(conn, ~p"/api/embedding_vector")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create emberdding_vector" do
    test "renders emberdding_vector when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/embedding_vector", emberdding_vector: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/embedding_vector/#{id}")

      assert %{
               "id" => ^id,
               "sha" => "some sha",
               "text" => "some text",
               "vector" => "some vector"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/embedding_vector", emberdding_vector: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update emberdding_vector" do
    setup [:create_emberdding_vector]

    test "renders emberdding_vector when data is valid", %{conn: conn, emberdding_vector: %EmberddingVector{id: id} = emberdding_vector} do
      conn = put(conn, ~p"/api/embedding_vector/#{emberdding_vector}", emberdding_vector: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/embedding_vector/#{id}")

      assert %{
               "id" => ^id,
               "sha" => "some updated sha",
               "text" => "some updated text",
               "vector" => "some updated vector"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, emberdding_vector: emberdding_vector} do
      conn = put(conn, ~p"/api/embedding_vector/#{emberdding_vector}", emberdding_vector: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete emberdding_vector" do
    setup [:create_emberdding_vector]

    test "deletes chosen emberdding_vector", %{conn: conn, emberdding_vector: emberdding_vector} do
      conn = delete(conn, ~p"/api/embedding_vector/#{emberdding_vector}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/embedding_vector/#{emberdding_vector}")
      end
    end
  end

  defp create_emberdding_vector(_) do
    emberdding_vector = emberdding_vector_fixture()
    %{emberdding_vector: emberdding_vector}
  end
end
