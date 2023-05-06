defmodule PureAIWeb.API.UserSessionController do
  @moduledoc false

  use PureAIWeb, :controller

  alias PureAI.Accounts
  alias PureAIWeb.UserAuth

  action_fallback PureAIWeb.FallbackController

  def create(conn, %{"user" => user_params}) do
    %{"email" => email, "password" => password} = user_params

    with {:ok, user} <- Accounts.get_user_by_email_and_password(email, password) do
      token = Accounts.generate_user_session_token(user)

      conn
      |> json(%{
        id: user.id,
        email: user.email,
        token: token
      })
    end
  end

  def current_user(conn, _) do
    current_user = conn.assigns.current_user

    json(conn, %{
      id: current_user.id,
      email: current_user.email
    })
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "Logged out successfully.")
    |> UserAuth.log_out_user()
  end
end
