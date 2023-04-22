defmodule PureAI.Prompt.PromptTemplate do
  use Ecto.Schema
  import Ecto.Changeset

  schema "prompt_templates" do
    field :title, :string
    field :content, :string
    field :is_default, :boolean, default: false

    belongs_to :user, PureAI.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(prompt_template, attrs) do
    required_fields = ~w(
      content
    )a

    optional_fields = ~w(
      title
      user_id
      is_default
    )a

    prompt_template
    |> cast(attrs, required_fields ++ optional_fields)
    |> validate_required(required_fields)
  end
end
