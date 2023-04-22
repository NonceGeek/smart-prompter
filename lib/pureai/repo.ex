defmodule PureAI.Repo do
  use Ecto.Repo,
    otp_app: :pureai,
    adapter: Ecto.Adapters.Postgres
end
