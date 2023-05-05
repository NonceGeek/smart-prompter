defmodule PureAI.PromptTest do
  @moduledoc false

  use PureAI.DataCase

  alias PureAI.Prompt

  describe "prompt_templates" do
    alias PureAI.Prompt.PromptTemplate

    import PureAI.PromptFixtures

    @invalid_attrs %{content: nil, is_default: nil}

    test "list_prompt_templates/0 returns all prompt_templates" do
      prompt_template = prompt_template_fixture()
      assert Prompt.list_prompt_templates() == [prompt_template]
    end

    test "get_prompt_template!/1 returns the prompt_template with given id" do
      prompt_template = prompt_template_fixture()
      assert Prompt.get_prompt_template!(prompt_template.id) == prompt_template
    end

    test "create_prompt_template/1 with valid data creates a prompt_template" do
      valid_attrs = %{content: "some content", is_default: true}

      assert {:ok, %PromptTemplate{} = prompt_template} = Prompt.create_prompt_template(valid_attrs)

      assert prompt_template.content == "some content"
      assert prompt_template.is_default == true
    end

    test "create_prompt_template/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Prompt.create_prompt_template(@invalid_attrs)
    end

    test "update_prompt_template/2 with valid data updates the prompt_template" do
      prompt_template = prompt_template_fixture()
      update_attrs = %{content: "some updated content", is_default: false}

      assert {:ok, %PromptTemplate{} = prompt_template} = Prompt.update_prompt_template(prompt_template, update_attrs)

      assert prompt_template.content == "some updated content"
      assert prompt_template.is_default == false
    end

    test "update_prompt_template/2 with invalid data returns error changeset" do
      prompt_template = prompt_template_fixture()

      assert {:error, %Ecto.Changeset{}} = Prompt.update_prompt_template(prompt_template, @invalid_attrs)

      assert prompt_template == Prompt.get_prompt_template!(prompt_template.id)
    end

    test "delete_prompt_template/1 deletes the prompt_template" do
      prompt_template = prompt_template_fixture()
      assert {:ok, %PromptTemplate{}} = Prompt.delete_prompt_template(prompt_template)
      assert_raise Ecto.NoResultsError, fn -> Prompt.get_prompt_template!(prompt_template.id) end
    end

    test "change_prompt_template/1 returns a prompt_template changeset" do
      prompt_template = prompt_template_fixture()
      assert %Ecto.Changeset{} = Prompt.change_prompt_template(prompt_template)
    end
  end
end
