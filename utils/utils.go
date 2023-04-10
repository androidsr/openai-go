package utils

import (
	"openai-go/model/vo"
	"net/http"
	"strconv"
	"time"

	"github.com/gin-gonic/gin"
)

func GetDateTime() string {
	return time.Now().Format("20060102150405")
}

func GetDate() string {
	return time.Now().Format("20060102")
}

func GetTime() string {
	return time.Now().Format("150405")
}

func ParseInt64(str string) int64 {
	v, err := strconv.ParseInt(str, 10, 64)
	if err != nil {
		panic(err)
	}
	return v
}

func ParseStr(v int64) string {
	return strconv.FormatInt(v, 10)
}
func Bind(c *gin.Context, in interface{}) bool {
	err := c.BindJSON(in)
	if err != nil {
		FailResult(c, "请求参数绑定处理失败")
		return false
	}
	return true
}

func FailResult(c *gin.Context, msg string) {
	c.JSON(http.StatusOK, vo.HttpResult{Code: "0001", Msg: msg})
}

func Success(c *gin.Context, data ...interface{}) {
	result := vo.HttpResult{Code: "0000", Msg: "处理成功"}
	if len(data) != 0 {
		result.Data = data[0]
	}
	c.JSON(http.StatusOK, result)
}
