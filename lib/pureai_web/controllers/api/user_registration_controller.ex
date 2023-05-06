defmodule PureAIWeb.API.UserRegistrationController do
  @moduledoc false

  use PureAIWeb, :controller

  alias PureAI.Accounts
  alias PureAI.Accounts.User
  alias PureAIWeb.UserAuth

  action_fallback PureAIWeb.FallbackController

  def create(conn, %{"user" => user_params}) do
    with {:ok, user} <- Accounts.register_user(user_params) do
      token = Accounts.generate_user_session_token(user)

      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/users/#{user}")
      |> render(:show, user: user, token: token)
    end

    # |> put_resp_header("location", ~p"/api/topics/#{topic}")
    # |> render(:show, topic: topic)
    # case Accounts.register_user(user_params) do
    #   {:ok, user} ->
    #     {:ok, _} =
    #       Accounts.deliver_user_confirmation_instructions(
    #         user,
    #         &url(~p"/users/confirm/#{&1}")
    #       )

    #     conn
    #     |> put_flash(:info, "User created successfully.")
    #     |> UserAuth.log_in_user(user)

    #   {:error, %Ecto.Changeset{} = changeset} ->
    #     render(conn, :new, changeset: changeset)
    # end
  end
end
