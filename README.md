# PureAI

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Features

  - [ ] Generate a guest based on a cookie when the user is not logged in (OR only support logged user)
  - [x] Mock a simple OpenAI Server for develop
  - [x] RichText formatting support
  - [x] Async execution

## Stories

  - [x] 1 [DirectMode] Initiate my request directly
  - [ ] 2 [SmartMode] System automatic improvement request
  - [x] 3 [Template] Customise my request according to the prompt template(also direct)
  - [x] 4 [Advanced] Improve your request based on OpenAI's interactive.


## References

  - [OpenAI API](https://platform.openai.com/docs/api-reference/chat/create)
  - [PromptPerfect](https://promptperfect.jinaai.cn/prompts)
  - [prompts.chat](https://prompts.chat/#act-as-a-linux-terminal)
  - [OpenAI Elixir Client](https://github.com/mgallo/openai.ex)