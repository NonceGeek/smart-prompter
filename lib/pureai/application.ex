defmodule PureAI.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      PureAIWeb.Telemetry,
      # Start the Ecto repository
      PureAI.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: PureAI.PubSub},
      # Start Finch
      {Finch, name: PureAI.Finch},
      # Start the Endpoint (http/https)
      PureAIWeb.Endpoint,
      # mock client
      {PureAI.OpenAIMock, []},
      {Oban, Application.fetch_env!(:pureai, Oban)}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PureAI.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PureAIWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
