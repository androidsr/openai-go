package api

import (
	"openai-go/dao/builder"
	"openai-go/model/db"
	"openai-go/model/dto"
	"openai-go/utils"
	"net/http"

	"github.com/gin-gonic/gin"
)

type SysButtonsApi struct {
	BaseApi
}

//按钮管理
func NewSysButtonsApi(baseApi BaseApi) {
	m := SysButtonsApi{baseApi}

	group := m.router.Group("/sysbuttons")
	group.GET("/:id", m.Get)             //查询
	group.POST("", m.Post)               //增加
	group.PUT("/edit", m.Put)            //修改
	group.DELETE("/:id", m.Delete)       //删除
	group.PUT("", m.QueryTables)         //查询列表
	group.POST("/select", m.QuerySelect) //查询下拉
}

//查询
func (m *SysButtonsApi) Get(c *gin.Context) {
	id := c.Param("id")
	data := new(db.SysButtons)
	err := m.db.First(data, id).Error
	if err != nil {
		utils.FailResult(c, "获取对象失败")
		return
	}
	c.JSON(http.StatusOK, data)
}

//增加
func (m *SysButtonsApi) Post(c *gin.Context) {
	in := new(db.SysButtons)
	if !utils.Bind(c, in) {
		return
	}
	in.Id = m.getId()
	err := m.db.Create(in).Error

	if err != nil {
		utils.FailResult(c, "插入数据失败!")
		return
	}
	utils.Success(c)
}

//修改
func (m *SysButtonsApi) Put(c *gin.Context) {
	in := new(db.SysButtons)
	if !utils.Bind(c, in) {
		return
	}
	err := m.db.Where("id = ?", in.Id).Updates(in).Error

	if err != nil {
		utils.FailResult(c, "更新数据失败!")
		return
	}
	utils.Success(c)
}

//删除
func (m *SysButtonsApi) Delete(c *gin.Context) {
	id := c.Param("id")
	if id == "" {
		utils.FailResult(c, "主键不能为空")
		return
	}
	err := m.db.Delete(db.SysButtons{}, "id = ?", id).Error
	if err != nil {
		utils.FailResult(c, "删除数据失败")
		return
	}
	utils.Success(c)
}

//查询列表
func (m *SysButtonsApi) QueryTables(c *gin.Context) {
	in := new(struct {
		Page      dto.PageDTO   `json:"page"`
		QueryData db.SysButtons `json:"queryData"`
	})
	if !utils.Bind(c, in) {
		return
	}
	q := in.QueryData
	sql, values := builder.Builder().SELECT("*").FROM("sys_buttons").
		NotEmpty("and id = ?", q.Id).
		NotEmpty("and click = ?", q.Click).
		NotEmpty("and state = ?", q.State).
		NotEmpty("and title like %?%", q.Title).Build()
	result := FindPage(m.db, db.SysButtons{}, sql, values, in.Page)
	c.JSON(http.StatusOK, result)
}

//分页下拉
func (m *SysButtonsApi) QuerySelect(c *gin.Context) {
	in := new(dto.SelectQueryDTO)
	if !utils.Bind(c, in) {
		return
	}

	q := in.QueryData

	sql, values := builder.Builder().SELECT("id as key_id", "title").
		FROM("sys_buttons").APPEND("and id is not null").
		NotEmpty("and CONCAT(id,title) like ?", builder.LIKE(q.Filter)).
		NotEmpty("or id in ?", q.Selected).Build()

	result := FindList(m.db, sql, values, in.Page)
	utils.Success(c, result)
}
