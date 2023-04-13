package api

import (
	"context"
	"errors"
	"fmt"
	"io"
	"openai-go/config"
	"openai-go/utils"

	"github.com/dgrijalva/jwt-go"
	"github.com/gin-gonic/gin"
	openai "github.com/sashabaranov/go-openai"
)

var (
	client *openai.Client
)

type SysOpenAiApi struct {
	BaseApi
}

func init() {
	client = openai.NewClient(config.GetConfig().OpenAIKey)
}

//openai管理
func NewSysOpenAiApi(baseApi BaseApi) {
	m := SysOpenAiApi{baseApi}

	group := m.router.Group("/openai")
	group.POST("/send", m.Send)
}

//发送消息
func (m *SysOpenAiApi) Send(c *gin.Context) {
	tokenStr, _ := c.Cookie(AUTHORIZED)
	mp := jwt.MapClaims{}
	_, err := jwt.ParseWithClaims(tokenStr, &mp, func(token *jwt.Token) (interface{}, error) {
		return []byte("a!d@#$d%^&f*(g)12e345xzde6789x"), nil
	})
	if err != nil {
		c.Writer.WriteString(err.Error())
		return
	}
	userId := mp["user"]
	in := make(map[string]string, 0)
	if !utils.Bind(c, &in) {
		return
	}
	message := in["message"]
	ctx := context.Background()
	req := openai.ChatCompletionRequest{
		Model: openai.GPT3Dot5Turbo,
		Messages: []openai.ChatCompletionMessage{
			{
				Role:    openai.ChatMessageRoleUser,
				Content: message,
			},
		},
		Stream: true,
	}
	stream, err := client.CreateChatCompletionStream(ctx, req)
	if err != nil {
		c.Writer.WriteString(err.Error())
		return
	}
	defer stream.Close()
	for {
		response, err := stream.Recv()
		if errors.Is(err, io.EOF) {
			break
		}

		if err != nil {
			fmt.Println(err)
			c.Writer.WriteString(err.Error())
			break
		}
		result := response.Choices[0].Delta.Content
		err = sendMessage(userId.(string), result)
		if err != nil {
			break
		}
	}
}
