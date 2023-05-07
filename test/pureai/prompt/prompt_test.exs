defmodule PureAI.PromptTest do
  @moduledoc false

  use PureAI.DataCase

  import PureAI.AccountsFixtures
  import PureAI.PromptFixtures

  alias PureAI.Prompt

  describe "prompt_templates" do
    alias PureAI.Prompt.PromptTemplate

    @invalid_attrs %{content: nil, is_default: nil}

    test "list_prompt_templates/0 returns all prompt_templates" do
      user = user_fixture()
      prompt_template = prompt_template_fixture(user)
      assert Prompt.list_prompt_templates() == [prompt_template]
    end

    # test "get_prompt_template!/1 returns the prompt_template with given id" do
    #   prompt_template = prompt_template_fixture()
    #   assert Prompt.get_prompt_template!(prompt_template.id) == prompt_template
    # end

    test "create_prompt_template/1 with valid data creates a prompt_template" do
      user = user_fixture()
      valid_attrs = %{content: "some content", is_default: true}
      assert {:ok, %PromptTemplate{} = prompt_template} = Prompt.create_prompt_template(valid_attrs, user)

      assert prompt_template.content == "some content"
      assert prompt_template.is_default == true
    end

    test "create_prompt_template/1 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Prompt.create_prompt_template(@invalid_attrs, user)
    end

    test "update_prompt_template/2 with valid data updates the prompt_template" do
      user = user_fixture()
      prompt_template = prompt_template_fixture(user)
      update_attrs = %{content: "some updated content", is_default: false}

      assert {:ok, %PromptTemplate{} = prompt_template} = Prompt.update_prompt_template(prompt_template, update_attrs, user)

      assert prompt_template.content == "some updated content"
      assert prompt_template.is_default == false
    end

    test "update_prompt_template/2 with invalid data returns error changeset" do
      user = user_fixture()
      prompt_template = prompt_template_fixture(user)

      assert {:error, %Ecto.Changeset{}} = Prompt.update_prompt_template(prompt_template, @invalid_attrs, user)

      assert prompt_template == Prompt.get_prompt_template!(prompt_template.id)
    end

    test "delete_prompt_template/1 deletes the prompt_template" do
      user = user_fixture()
      prompt_template = prompt_template_fixture(user)
      assert {:ok, %PromptTemplate{}} = Prompt.delete_prompt_template(prompt_template, user)
      assert_raise Ecto.NoResultsError, fn -> Prompt.get_prompt_template!(prompt_template.id) end
    end

    test "change_prompt_template/1 returns a prompt_template changeset" do
      user = user_fixture()
      prompt_template = prompt_template_fixture(user)
      assert %Ecto.Changeset{} = Prompt.change_prompt_template(prompt_template)
    end
  end
end
