package router

import (
	"openai-go/api"
	"openai-go/config"
	"openai-go/dao/pool"
	"openai-go/utils"

	"github.com/bwmarrin/snowflake"
	"github.com/gin-contrib/static"
	"github.com/gin-gonic/gin"
)

func NewRouter() *gin.Engine {
	cfg := config.GetConfig()
	node, _ := snowflake.NewNode(cfg.Server.WorkerId)
	server := gin.Default()
	server.Use(static.Serve("/", static.LocalFile(cfg.StaticDir, false)))

	group := server.Group("/api")
	handler := api.NewBaseApi(api.WithGorm(pool.GetDB()), api.WithRouterGroup(group), api.WithSnowflake(node))
	api.NewPermissionsApi(handler)
	api.NewSysButtonsApi(handler)
	api.NewSysMenusApi(handler)
	api.NewSysParamsApi(handler)
	api.NewSysRoleMenuApi(handler)
	api.NewSysRolesApi(handler)
	api.NewSysUsersApi(handler)

	api.NewSysOpenAiApi(handler)

	return server
}

func Recovery(c *gin.Context) {
	defer func() {
		if r := recover(); r != nil {
			utils.FailResult(c, "系统内部错误")
		}
	}()
	c.Next()
}
