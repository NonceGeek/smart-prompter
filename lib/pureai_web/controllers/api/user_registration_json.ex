defmodule PureAIWeb.API.UserRegistrationJSON do
  @moduledoc false

  @doc """
  Renders a single topic.
  """
  def show(%{user: user, token: token}) do
    %{
      data: %{
        id: user.id,
        email: user.email,
        token: token
      }
    }
  end
end
