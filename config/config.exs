# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :pureai,
  namespace: PureAI,
  ecto_repos: [PureAI.Repo]

# Configures the endpoint
config :pureai, PureAIWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: PureAIWeb.ErrorHTML, json: PureAIWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: PureAI.PubSub,
  live_view: [signing_salt: "JZuqU5Xm"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :pureai, PureAI.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.2.7",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :openai,
  # find it at https://platform.openai.com/account/api-keys
  api_key: "your-api-key",
  client: PureAI.OpenAIMock

# # find it at https://platform.openai.com/account/org-settings under "Organization ID"
# organization_key: "your-organization-key",
# # optional, passed to [HTTPoison.Request](https://hexdocs.pm/httpoison/HTTPoison.Request.html) options
# http_options: [recv_timeout: 30_000],
# # optional, useful if you want to do local integration tests using Bypass or similar
# # (https://github.com/PSPDFKit-labs/bypass), do not use it for production code,
# # but only in your test config!
# api_url: "http://localhost/"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
