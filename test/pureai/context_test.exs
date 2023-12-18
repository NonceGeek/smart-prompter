defmodule PureAI.ContextTest do
  use PureAI.DataCase

  alias PureAI.Context

  describe "embedding_vector" do
    alias PureAI.Context.EmbeddingVector

    import PureAI.ContextFixtures

    @invalid_attrs %{sha: nil, text: nil, vector: nil}

    test "list_embedding_vector/0 returns all embedding_vector" do
      embedding_vector = embedding_vector_fixture()
      assert Context.list_embedding_vector() == [embedding_vector]
    end

    test "get_embedding_vector!/1 returns the embedding_vector with given id" do
      embedding_vector = embedding_vector_fixture()
      assert Context.get_embedding_vector!(embedding_vector.id) == embedding_vector
    end

    test "create_embedding_vector/1 with valid data creates a embedding_vector" do
      valid_attrs = %{sha: "some sha", text: "some text", vector: "some vector"}

      assert {:ok, %EmbeddingVector{} = embedding_vector} = Context.create_embedding_vector(valid_attrs)
      assert embedding_vector.sha == "some sha"
      assert embedding_vector.text == "some text"
      assert embedding_vector.vector == "some vector"
    end

    test "create_embedding_vector/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Context.create_embedding_vector(@invalid_attrs)
    end

    test "update_embedding_vector/2 with valid data updates the embedding_vector" do
      embedding_vector = embedding_vector_fixture()
      update_attrs = %{sha: "some updated sha", text: "some updated text", vector: "some updated vector"}

      assert {:ok, %EmbeddingVector{} = embedding_vector} = Context.update_embedding_vector(embedding_vector, update_attrs)
      assert embedding_vector.sha == "some updated sha"
      assert embedding_vector.text == "some updated text"
      assert embedding_vector.vector == "some updated vector"
    end

    test "update_embedding_vector/2 with invalid data returns error changeset" do
      embedding_vector = embedding_vector_fixture()
      assert {:error, %Ecto.Changeset{}} = Context.update_embedding_vector(embedding_vector, @invalid_attrs)
      assert embedding_vector == Context.get_embedding_vector!(embedding_vector.id)
    end

    test "delete_embedding_vector/1 deletes the embedding_vector" do
      embedding_vector = embedding_vector_fixture()
      assert {:ok, %EmbeddingVector{}} = Context.delete_embedding_vector(embedding_vector)
      assert_raise Ecto.NoResultsError, fn -> Context.get_embedding_vector!(embedding_vector.id) end
    end

    test "change_embedding_vector/1 returns a embedding_vector changeset" do
      embedding_vector = embedding_vector_fixture()
      assert %Ecto.Changeset{} = Context.change_embedding_vector(embedding_vector)
    end
  end
end
