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

## API's

* Create New Chat

```shell
curl --request POST \
  --url http://66.135.11.204/api/topics \
  --header 'Content-Type: application/json' \
  --data '{
	"topic": {
		"content": "你认识坤坤吗？"
	}
}'

```

* Create New Chat With Prompt Template

```shell
curl --request POST \
  --url http://66.135.11.204/api/topics \
  --header 'Content-Type: application/json' \
  --data '{
	"topic": {
		"content": "我爱北京天安门",
		"prompt_template_id": 2
	}
}'

```

* Add Message To Chat

```shell
curl --request POST \
  --url http://66.135.11.204/api/messages \
  --header 'Content-Type: application/json' \
  --data '{
	"message": {
		"content": "坤坤你真棒",
		"topic_id": 7
	}
}'
```

* Get One Chat

```shell
curl --request GET \
  --url http://66.135.11.204/api/topics/7
```

* Add Prompt Template

```shell
curl --request POST \
  --url http://66.135.11.204/api/prompt_templates \
  --header 'Content-Type: application/json' \
  --data '{
	"prompt_template": {
		"title": "你是一个翻译家",
		"content": "我希望你能充当英语翻译家。我将用中文与你交谈，而你将翻译成英语，现在我们开始练习。"
	}
}'
```

* List Prompt Template

```shell
curl --request GET \
  --url http://66.135.11.204/api/prompt_templates
```

* Show Prompt Template

```shell
curl --request GET \
  --url http://localhost:4000/api/prompt_templates/1
```

* Delete Prompt Template

```shell
curl --request DELETE \
  --url http://localhost:4000/api/prompt_templates/1

```


## References

  - [OpenAI API](https://platform.openai.com/docs/api-reference/chat/create)
  - [PromptPerfect](https://promptperfect.jinaai.cn/prompts)
  - [prompts.chat](https://prompts.chat/#act-as-a-linux-terminal)
  - [OpenAI Elixir Client](https://github.com/mgallo/openai.ex)