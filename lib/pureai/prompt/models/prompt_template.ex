defmodule PureAI.Prompt.Model.PromptTemplate do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  schema "prompt_templates" do
    field :content, :string
    field :is_default, :boolean, default: false
    field :title, :string

    belongs_to :user, PureAI.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(prompt_template, attrs) do
    required_fields = ~w(
      title
      content
      user_id
    )a

    optional_fields = ~w(
      is_default
    )a

    prompt_template
    |> cast(attrs, required_fields ++ optional_fields)
    |> validate_required(required_fields)
  end
end
