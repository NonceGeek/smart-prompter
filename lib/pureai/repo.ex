defmodule PureAI.Repo do
  @moduledoc false

  use Ecto.Repo, otp_app: :pureai, adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 10
end
