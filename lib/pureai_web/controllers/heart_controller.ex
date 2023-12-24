defmodule PureAIWeb.HeartController do
  use PureAIWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    json(conn, %{hello: "world"})
  end
end
