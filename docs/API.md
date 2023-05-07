# API's

## Create New Chat

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

## Create New Chat With Prompt Template

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

## Add Message To Chat

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

## Get One Chat

```shell
curl --request GET \
  --url http://66.135.11.204/api/topics/7
```

## Add Prompt Template

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

## List Prompt Template

```shell
curl --request GET \
  --url http://66.135.11.204/api/prompt_templates
```

## Show Prompt Template

```shell
curl --request GET \
  --url http://localhost:4000/api/prompt_templates/1
```

## Update Prompt Template

```shell
curl --request PUT \
  --url http://localhost:4000/api/prompt_templates/2 \
  --header 'Content-Type: application/json' \
  --header 'authorization: Bearer Boz_ukeQ3ViIDmh3WEIcPd9P6HIzUfP06TBuNs94kq0' \
  --data '{
	"prompt_template": {
		"title": "你是一个翻译家111111111111111111",
		"content": "我希望你能充当英语翻译家。我将用中文与你交谈，而你将翻译成英语，现在我们开始练习。"
	}
}'
```

## Delete Prompt Template

```shell
curl --request DELETE \
  --url http://localhost:4000/api/prompt_templates/1

```