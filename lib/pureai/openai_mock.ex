defmodule PureAI.OpenAIMock do
  @moduledoc """
  Mocks the OpenAI API for testing purposes.

  ## Features

    - [x] models
    - [x] completions
    - [x] chat_completion

  """
  use GenServer

  require Logger

  defmodule State do
    defstruct []
  end

  def start_link(_args) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(_args) do
    {:ok, %State{}}
  end

  def models(), do: get_cached_openai_models()

  @doc """
  OpenAI.completions("text-davinci-003", prompt: "Say this is a test")
  """
  def completions(model, clauses) do
    {:ok,
     %{
       choices: [
         %{
           "finish_reason" => "stop",
           "index" => 0,
           "logprobs" => nil,
           "text" => "\n\nYes, this is a test."
         }
       ],
       created: 1_683_009_700,
       id: "cmpl-7BdzgE0NOyrNoGQBTazU6487t4YoC",
       model: "text-davinci-003",
       object: "text_completion",
       usage: %{
         "completion_tokens" => 9,
         "prompt_tokens" => 5,
         "total_tokens" => 14
       }
     }}
  end

  def completions() do
    completions("text-davinci-003", prompt: "Say this is a test")
  end

  @doc """
  OpenAI.chat_completion(model: "gpt-3.5-turbo",
    messages: [
      %{role: "system", content: "You are a helpful assistant."},
      %{role: "user", content: "Who won the world series in 2020?"},
      %{role: "assistant", content: "The Los Angeles Dodgers won the World Series in 2020."},
      %{role: "user", content: "Where was it played?"}
    ]
  )
  """
  def chat_completion(clauses) do
    {:ok,
     %{
       choices: [
         %{
           "finish_reason" => "stop",
           "index" => 0,
           "message" => %{
             "content" =>
               "Sure, here's an example of a simple GenServer in Elixir:\n\n```\ndefmodule MyServer do\n  use GenServer\n\n  def start_link do\n    GenServer.start_link(__MODULE__, %{})\n  end\n\n  def init(_args) do\n    {:ok, %{count: 0}}\n  end\n\n  def handle_call(:increment, _from, state) do\n    new_count = state[:count] + 1\n    {:reply, new_count, %{state | count: new_count}}\n  end\nend\n```\n\nIn this example, we define a GenServer module called `MyServer`. The `start_link` function is used to start the GenServer process, and `init` is used to initialize the state of the module (in this case, we're just setting an initial count to zero).\n\nWe also define a `handle_call` function to handle requests to increment the count. This function takes the current state of the module as its third argument, increments the count, and sends a response back to the caller with the new count and the updated state.\n\nTo use the GenServer, we can call `MyServer.start_link` to start the process, and then use the `GenServer.call` function to send requests to the server:\n\n```\n{:ok, pid} = MyServer.start_link\nnew_count = GenServer.call(pid, :increment)\n```\n\nThis will start the MyServer process and increment the count, returning the updated count.",
             "role" => "assistant"
           }
         }
       ],
       created: 1_683_010_429,
       id: "chatcmpl-7BeBRNMOqPUvrLfSfW1iPFMaXmqN6",
       model: "gpt-3.5-turbo-0301",
       object: "chat.completion",
       usage: %{
         "completion_tokens" => 306,
         "prompt_tokens" => 18,
         "total_tokens" => 324
       }
     }}
  end

  def chat_completion() do
    chat_completion(
      model: "gpt-3.5-turbo",
      messages: [%{role: "user", content: "Can you implement a simple Genserver example?"}]
    )
  end

  defp get_cached_openai_models do
    {:ok, data} =
      File.cwd!()
      |> Path.split()
      |> Enum.drop(-1)
      |> Kernel.++([
        "pureai",
        "priv",
        "openai_models.json"
      ])
      |> Path.join()
      |> File.read()

    {:ok, Jason.decode!(data)}
  end
end
