# PureAI

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Features

  - [ ] Generate a guest based on a cookie when the user is not logged in (OR only support logged user)
  - [ ] Mock a simple OpenAI Server for develop
  - [ ] RichText formatting support
  - [x] Async execution

## Stories

  - [ ] 1 [DirectMode] Initiate my request directly
  - [ ] 2 [SmartMode] System automatic improvement request
  - [ ] 3 [Template] Customise my request according to the prompt template(also direct)
  - [ ] 4 [Advanced] Improve your request based on OpenAI's interactive.


## Examples

* OpenAI.completions("text-davinci-003", prompt: "Say this is a test")

```shell
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
   created: 1683009700,
   id: "cmpl-7BdzgE0NOyrNoGQBTazU6487t4YoC",
   model: "text-davinci-003",
   object: "text_completion",
   usage: %{
     "completion_tokens" => 9,
     "prompt_tokens" => 5,
     "total_tokens" => 14
   }
 }}
```

* OpenAI.chat_completion(model: "gpt-3.5-turbo", messages: [%{role: "user", content: "Can you implement a simple Genserver example?"}])

```shell
{:ok,
 %{
   choices: [
     %{
       "finish_reason" => "stop",
       "index" => 0,
       "message" => %{
         "content" => "Sure, here's an example of a simple GenServer in Elixir:\n\n```\ndefmodule MyServer do\n  use GenServer\n\n  def start_link do\n    GenServer.start_link(__MODULE__, %{})\n  end\n\n  def init(_args) do\n    {:ok, %{count: 0}}\n  end\n\n  def handle_call(:increment, _from, state) do\n    new_count = state[:count] + 1\n    {:reply, new_count, %{state | count: new_count}}\n  end\nend\n```\n\nIn this example, we define a GenServer module called `MyServer`. The `start_link` function is used to start the GenServer process, and `init` is used to initialize the state of the module (in this case, we're just setting an initial count to zero).\n\nWe also define a `handle_call` function to handle requests to increment the count. This function takes the current state of the module as its third argument, increments the count, and sends a response back to the caller with the new count and the updated state.\n\nTo use the GenServer, we can call `MyServer.start_link` to start the process, and then use the `GenServer.call` function to send requests to the server:\n\n```\n{:ok, pid} = MyServer.start_link\nnew_count = GenServer.call(pid, :increment)\n```\n\nThis will start the MyServer process and increment the count, returning the updated count.",
         "role" => "assistant"
       }
     }
   ],
   created: 1683010429,
   id: "chatcmpl-7BeBRNMOqPUvrLfSfW1iPFMaXmqN6",
   model: "gpt-3.5-turbo-0301",
   object: "chat.completion",
   usage: %{
     "completion_tokens" => 306,
     "prompt_tokens" => 18,
     "total_tokens" => 324
   }
 }}
```