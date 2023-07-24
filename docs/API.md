# SmartPrompter Endpoint API

SmartPrompter 遵循标准的 RESTful 架构风格的 API 来进行数据交互，并使用 oAuth 认证协议来实现对用户数据的授权访问


## User (用户)

用户模型，包含3个API，用户注册，登录，以及获取用户的信息

### 注册账号

```shell
curl --request POST \
  --url http://66.135.11.204/api/users/register \
  --header 'Content-Type: application/json' \
  --data '{
	"user": {
		"email": "lisi@dao.com",
		"password": "123123123123"
	}
}'
```

### 登录用户

```shell
curl --request POST \
  --url http://66.135.11.204/api/users/log_in \
  --header 'Content-Type: application/json' \
  --data '{
	"user": {
		"email": "lisi@dao.com",
		"password": "123123123123"
	}
}'
```

### 获取当前账号信息

```shell
curl --request GET \
  --url http://66.135.11.204/api/current_user \
  --header 'Content-Type: application/json' \
  --header 'authorization: Bearer <<oauth_token>>'
```


## Topic (会话)

SmartPrompter 的会话包含如下功能

- 满足 OpenAI的 Chat 功能，建立持续对话通道.
- 支持才用模版，设置特定的上下文，比如希望当前会话充当一个【英语老师】, 帮你解答英语相关的问题.
- 支持设定会话的答复，帮助向量数据库训练模型。


### 获取当前登录用户的会话列表

```shell
curl --request GET \
  --url http://66.135.11.204/api/topics \
  --header 'authorization: Bearer <<oauth_token>>'
```

### 显示当前回话的信息

```shell
curl --request GET \
  --url http://66.135.11.204/api/topics/<<topic_id>> \
  --header 'authorization: Bearer <<oauth_token>>'
```

### 创建会话

```shell
curl --request POST \
  --url http://66.135.11.204/api/topics \
  --header 'Content-Type: application/json' \
  --header 'authorization: <<oauth_token>>' \
  --data '{
	"topic": {
		"content": "你认识坤坤吗？",
		"model": "gpt3.5"
	}
}'
```

### 创建会话并添加默认答复

```shell
curl --request POST \
  --url http://66.135.11.204/api/topic_with_answer \
  --header 'Content-Type: application/json' \
  --header 'authorization: Bearer <<oauth_token>>' \
  --data '{
	"topic": {
		"question": "你认识坤坤吗？",
		"answer": "123123"
	}
}'
```


### 创建会话指定特定模版

```shell
curl --request POST \
  --url http://66.135.11.204/api/topics \
  --header 'Content-Type: application/json' \
  --header 'authorization: Bearer <<oauth_token>>' \
  --data '{
	"topic": {
		"content": "我爱北京天安门",
		"prompt_template_id": 3
	}
}'
```

### 和会话持续沟通

```shell
curl --request POST \
  --url http://66.135.11.204/api/messages \
  --header 'Content-Type: application/json' \
  --header 'authorization: Bearer <<oauth_token>>' \
  --data '{
	"message": {
		"content": "大理美食",
		"topic_id": 16
	}
}'
```


## Prompt Template (模版)

模版，可以理解帮会话设定了上下文，类似一个特定领域专家的概念。
稍微有些抽象，我举几个例子

- 选择如下模版，会话上下文是关于旅游相关的信息

```shell
{
  "title": "导游",
  "content": "我想让你充当一个旅游向导。我将把我的位置写给你，你将建议在我的位置附近的一个地方参观。在某些情况下，我也会给你我要访问的地方的类型。你也会向我推荐与我的第一个地点相近的类似类型的地方"
}
```

- 选择如下模版，SmartPrompter 通过持续交互的方式帮你完善 prompt，更准备的 prompt 获取更确定的答案。

```shell
{
  "title": "Advanced",
  "content": "I want you to become my Expert Prompt Creator. Your goal is to help me craft the best possible prompt for my needs. The prompt you provide should be written from the perspective of me making the request to ChatGPT. Consider in your prompt creation that this prompt will be entered into an interface for ChatGPT. The process is as follows: \\n1. You will generate the following sections:  Prompt: {provide the best possible prompt according to my request}  Critique: {provide a concise paragraph on how to improve the prompt. Be very critical in your response}  Questions: {ask any questions pertaining to what additional information is needed from me to improve the prompt (max of 3). If the prompt needs more clarification or details in certain areas, ask questions to get more information to include in the prompt}   \\n2. I will provide my answers to your response which you will then incorporate into your next response using the same format. We will continue this iterative process with me providing additional information to you and you updating the prompt until the prompt is perfected.  Remember, the prompt we are creating should be written from the perspective of me making a request to ChatGPT. Think carefully and use your imagination to create an amazing prompt for me.  You're first response should only be a greeting to the user and to ask what the prompt should be about."
}
```

- 当然，你也可以和 openai 玩一个游戏 （猜猜看）。
```shell
{
  "title": "game",
  "content": "我希望你成为我的游戏伙伴，你的目标是让我猜到你心目中的数字，具体流程如下：游戏开始时，你心里想一个数字，当我输入的值小于你心目中的数字的时候，你提示我小于；当我输入的值大于你心目中的数字的时候，你提示我大于，让我们开始吧。"
}
```


### 获取所有模版列表


```shell
curl --request GET \
  --url http://66.135.11.204/api/prompt_templates \
  --header 'authorization: Bearer <<oauth_token>>'
```

### 创建模版

```shell
curl --request POST \
  --url http://66.135.11.204/api/prompt_templates \
  --header 'Content-Type: application/json' \
  --header 'authorization: Bearer <<oauth_token>>' \
  --data '{
	"prompt_template": {
		"title": "导游",
		"content": "我想让你充当一个旅游向导。我将把我的位置写给你，你将建议在我的位置附近的一个地方参观。在某些情况下，我也会给你我要访问的地方的类型。你也会向我推荐与我的第一个地点相近的类似类型的地方",
		"model": "gpt3.5"
	}
}'
```

### 更新模版

```shell
curl --request PUT \
  --url http://66.135.11.204/api/prompt_templates/4 \
  --header 'Content-Type: application/json' \
  --header 'authorization: Bearer <<oauth_token>>' \
  --data '{
	"prompt_template": {
		"content": "我想让你充当一个旅游向导。我将把我的位置写给你，你将建议在我的位置附近的一个地方参观。在某些情况下，我也会给你我要访问的地方的类型。你也会向我推荐与我的第一个地点相近的类似类型的地方。"
	}
}'
```

### 显示当前模版信息

```shell
curl --request GET \
  --url http://66.135.11.204/api/prompt_templates/1 \
  --header 'authorization: Bearer <<oauth_token>>'
```