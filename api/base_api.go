package api

import (
	"openai-go/model/dto"
	"openai-go/model/vo"
	"fmt"
	"log"

	"github.com/bwmarrin/snowflake"
	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

type Option func(*BaseApi)

type BaseApi struct {
	db     *gorm.DB
	router *gin.RouterGroup
	node   *snowflake.Node
}

func NewBaseApi(opts ...Option) BaseApi {
	api := BaseApi{}
	for _, opt := range opts {
		opt(&api)
	}
	return api
}
func WithGorm(db *gorm.DB) Option {
	return func(m *BaseApi) {
		m.db = db
	}
}

func WithRouterGroup(router *gin.RouterGroup) Option {
	return func(m *BaseApi) {
		m.router = router
	}
}

func WithSnowflake(node *snowflake.Node) Option {
	return func(m *BaseApi) {
		m.node = node
	}
}

func (m *BaseApi) getId() string {
	return m.node.Generate().String()
}

func FindPage[T interface{}](db *gorm.DB, _ T, sql string, values []interface{}, page dto.PageDTO) *vo.PageInfoVO {
	result := new(vo.PageInfoVO)

	/*err := db.Raw(&result.Total).Error
	if result.Total == 0 {
		fmt.Println(err)
		result.Code = "0000"
		result.Msg = "暂无数据"
		return result
	}*/
	result.Data = make([]T, 0)
	values = append(values, (page.Current-1)*page.Size)
	values = append(values, page.Size)
	sql += " limit ?,?"
	err := db.Raw(sql, values...).Find(&result.Data).Error
	if err != nil {
		log.Println(err)
		result.Code = "0002"
		result.Msg = err.Error()
		return result
	}
	result.Code = "0000"
	result.Msg = "查询成功"
	dataSize := len(result.Data.([]T))
	if dataSize == page.Size {
		result.Total = int64((page.Size * (page.Current)) + page.Size)
	} else {
		result.Total = int64((page.Size * (page.Current - 1)) + dataSize)
		fmt.Println(result.Total)
	}
	return result
}

func FindList(db *gorm.DB, sql string, values []interface{}, page dto.PageDTO) []vo.SelectVO {
	result := make([]vo.SelectVO, 0)
	values = append(values, (page.Current-1)*page.Size)
	values = append(values, page.Size)
	sql += " limit ?,?"
	err := db.Raw(sql, values...).Scan(&result).Error
	if err != nil {
		log.Println(err)
	}
	return result
}
