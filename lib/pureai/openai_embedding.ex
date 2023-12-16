defmodule Pureai.OpenaiEmbedding do
  use HTTPoison.Base

  def client() do
    Tesla.client([
      {Tesla.Middleware.BaseUrl, Application.get_env(:openai, :api_url)},
      Tesla.Middleware.JSON,
      {Tesla.Middleware.Headers, [{"api-key", Application.get_env(:openai, :api_key)}]}
    ])
  end

  def text_to_vetor(prompt) do
    client() |> text_to_vetor(prompt)
  end
  @doc """
  ex> Pureai.OpenaiEmbedding.text_to_vetor(client, prompt)
  {:ok,
     [-0.03971921, -0.0023152048, -0.018311761, 0.009149322,
      0.0024447383, 0.033108085, -0.034682162, -0.0013560017, 0.009457579,
      -0.031402834, -0.0070112008, 0.025172113, 0.0033268773, 0.007653949,
      2.3816111e-4, 0.024135847, 0.017655896, 0.011608818, 0.031009315,
      0.0015125895, -0.007903178, 0.015321015, 0.017524723, -0.023348808,
      -0.0108808065, 0.011503879, 0.025303287, -0.006686548, -0.013150101,
      0.0037876226, 0.03150777, -0.004184421, -0.030589562, -0.029146658,
      -0.0072341952, -0.018521639, 0.004692717, 0.009798629, 0.01958414,
      -0.013825642, 0.007817916, 0.0037482707, -0.007988441, -0.0020200654,
      0.01286152, ...]
  }
  """
  @spec text_to_vetor(binary() | Tesla.Client.t(), string()) :: {:error, nil | integer()} | {:ok, any()}
  def text_to_vetor(client, prompt) do
    sha = hash_text(prompt)

    case PureAI.Context.get_emberdding_vector_by_sha(sha) do
      nil ->
        mp = %{:input => prompt}
        {:ok, %Tesla.Env{status: status, body: %{"data" => [%{"embedding" => vectors}]}}} = Tesla.post(client, "/deployments/text-embedding-ada-002/embeddings?api-version=2023-06-01-preview", mp)

        case status do
          200 ->
            PureAI.Context.create_emberdding_vector(%{sha: sha, text: prompt, vector: Jason.encode!(vectors)})
            {:ok, vectors}

          _ ->
            {:error, status}
        end

      %{vector: vector} ->
        {:ok, Jason.decode!(vector)}
    end
  end

  def hash_text(text) do
    binary_text = text |> String.to_charlist() |> :erlang.iolist_to_binary()
    hashed_binary = :crypto.hash(:sha256, binary_text)
    Base.encode16(hashed_binary, case: :lower)
  end
end
