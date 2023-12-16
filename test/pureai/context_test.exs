defmodule PureAI.ContextTest do
  use PureAI.DataCase

  alias PureAI.Context

  describe "embedding_vector" do
    alias PureAI.Context.EmberddingVector

    import PureAI.ContextFixtures

    @invalid_attrs %{sha: nil, text: nil, vector: nil}

    test "list_embedding_vector/0 returns all embedding_vector" do
      emberdding_vector = emberdding_vector_fixture()
      assert Context.list_embedding_vector() == [emberdding_vector]
    end

    test "get_emberdding_vector!/1 returns the emberdding_vector with given id" do
      emberdding_vector = emberdding_vector_fixture()
      assert Context.get_emberdding_vector!(emberdding_vector.id) == emberdding_vector
    end

    test "create_emberdding_vector/1 with valid data creates a emberdding_vector" do
      valid_attrs = %{sha: "some sha", text: "some text", vector: "some vector"}

      assert {:ok, %EmberddingVector{} = emberdding_vector} = Context.create_emberdding_vector(valid_attrs)
      assert emberdding_vector.sha == "some sha"
      assert emberdding_vector.text == "some text"
      assert emberdding_vector.vector == "some vector"
    end

    test "create_emberdding_vector/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Context.create_emberdding_vector(@invalid_attrs)
    end

    test "update_emberdding_vector/2 with valid data updates the emberdding_vector" do
      emberdding_vector = emberdding_vector_fixture()
      update_attrs = %{sha: "some updated sha", text: "some updated text", vector: "some updated vector"}

      assert {:ok, %EmberddingVector{} = emberdding_vector} = Context.update_emberdding_vector(emberdding_vector, update_attrs)
      assert emberdding_vector.sha == "some updated sha"
      assert emberdding_vector.text == "some updated text"
      assert emberdding_vector.vector == "some updated vector"
    end

    test "update_emberdding_vector/2 with invalid data returns error changeset" do
      emberdding_vector = emberdding_vector_fixture()
      assert {:error, %Ecto.Changeset{}} = Context.update_emberdding_vector(emberdding_vector, @invalid_attrs)
      assert emberdding_vector == Context.get_emberdding_vector!(emberdding_vector.id)
    end

    test "delete_emberdding_vector/1 deletes the emberdding_vector" do
      emberdding_vector = emberdding_vector_fixture()
      assert {:ok, %EmberddingVector{}} = Context.delete_emberdding_vector(emberdding_vector)
      assert_raise Ecto.NoResultsError, fn -> Context.get_emberdding_vector!(emberdding_vector.id) end
    end

    test "change_emberdding_vector/1 returns a emberdding_vector changeset" do
      emberdding_vector = emberdding_vector_fixture()
      assert %Ecto.Changeset{} = Context.change_emberdding_vector(emberdding_vector)
    end
  end
end
