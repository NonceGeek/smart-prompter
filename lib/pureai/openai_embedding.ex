defmodule Pureai.OpenaiEmbedding do
  use HTTPoison.Base

  def ai_type() do
    Application.get_env(:openai, :api_type)
  end

  def api_key() do
    Application.get_env(:openai, :api_key)
  end

  def client() do
    Tesla.client([
      {Tesla.Middleware.BaseUrl, Application.get_env(:openai, :api_url)},
      Tesla.Middleware.JSON,
      {Tesla.Middleware.Headers, [{"Authorization", "Bearer #{api_key()}"}]}
    ])
  end

  def text_to_vetor(prompt) do
    client() |> text_to_vetor(prompt)
  end

  def text_to_vetor(client, prompt) do
    sha = hash_text(prompt)

    case PureAI.Context.get_embedding_vector_by_sha(sha) do
      nil ->
        ai_type = ai_type()
        mp = %{:input => prompt, :model => "text-embedding-ada-002"}
        {:ok, %Tesla.Env{status: status, body: %{"data" => [%{"embedding" => vectors}]}}} = do_text_to_vector(client, mp, :openai)
        Tesla.post(client, "/v1/embeddings", mp)

        case status do
          200 ->
            PureAI.Context.create_embedding_vector(%{sha: sha, text: prompt, vector: Jason.encode!(vectors)})

          _ ->
            {:error, status}
        end

      %{vector: _} = res ->
        {:ok, res}
    end
  end

  def do_text_to_vector(client, mp, :openai) do
    {:ok, %Tesla.Env{status: status, body: %{"data" => [%{"embedding" => vectors}]}}} =
      Tesla.post(
        client,
        "/v1/embeddings",
        mp
      )
  end

  def hash_text(text) do
    # binary_text = text |> String.to_charlist() |> :erlang.iolist_to_binary()
    hashed_binary = :crypto.hash(:sha256, text)
    Base.encode16(hashed_binary, case: :lower)
  end
end
