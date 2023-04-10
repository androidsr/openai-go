package api

import (
	"openai-go/dao/builder"
	"openai-go/model/db"
	"openai-go/model/dto"
	"openai-go/model/vo"
	"openai-go/utils"
	"net/http"

	"github.com/gin-gonic/gin"
)

type SysUsersApi struct {
	BaseApi
}

//用户管理
func NewSysUsersApi(baseApi BaseApi) {
	m := SysUsersApi{baseApi}

	group := m.router.Group("/sysusers")
	group.GET("/:id", m.Get)             //查询
	group.POST("", m.Post)               //增加
	group.PUT("/edit", m.Put)            //修改
	group.DELETE("/:id", m.Delete)       //删除
	group.PUT("", m.QueryTables)         //查询列表
	group.POST("/select", m.QuerySelect) //查询下拉
}

//查询
func (m *SysUsersApi) Get(c *gin.Context) {
	id := c.Param("id")
	data := new(db.SysUsers)
	err := m.db.First(data, "account = ?", id).Error
	if err != nil {
		utils.FailResult(c, "获取对象失败!")
		return
	}
	data.Pass = ""
	c.JSON(http.StatusOK, data)
}

//增加
func (m *SysUsersApi) Post(c *gin.Context) {
	in := db.SysUsers{}
	if !utils.Bind(c, &in) {
		return
	}
	if in.Account == "" {
		c.JSON(http.StatusOK, vo.HttpResult{Code: "0001", Msg: "账号不能为空！"})
		return
	}
	err := m.db.Create(in).Error
	if err != nil {
		utils.FailResult(c, "插入数据失败")
		return
	}
	utils.Success(c)
}

//修改
func (m *SysUsersApi) Put(c *gin.Context) {
	in := new(db.SysUsers)
	if !utils.Bind(c, in) {
		return
	}
	if in.Account == "" {
		utils.FailResult(c, "账号不能为空")
		return
	}
	err := m.db.Where("account = ?", in.Account).Updates(in).Error
	if err != nil {
		utils.FailResult(c, "更新数据失败")
		return
	}
	utils.Success(c)
}

//删除
func (m *SysUsersApi) Delete(c *gin.Context) {
	id := c.Param("id")
	if id == "" {
		c.JSON(http.StatusOK, vo.HttpResult{Code: "0001", Msg: "主键不能为空！"})
		return
	}
	err := m.db.Delete(db.SysUsers{}, "account = ?", id).Error
	if err != nil {
		utils.FailResult(c, "删除数据失败!")
		return
	}
	utils.Success(c)
}

//查询列表
func (m *SysUsersApi) QueryTables(c *gin.Context) {
	in := new(struct {
		Page      dto.PageDTO `json:"page"`
		QueryData db.SysUsers `json:"queryData"`
	})
	if !utils.Bind(c, in) {
		return
	}

	q := in.QueryData
	sql, values := builder.Builder().SELECT("*").FROM("sys_users").
		NotEmpty("and account = ?", q.Account).
		NotEmpty("and name like ?", builder.LIKE(q.Name)).
		NotEmpty("and phone = ?", q.Phone).
		NotEmpty("and email = ?", q.Email).
		NotEmpty("and sex = ?", q.Sex).
		NotEmpty("and age = ?", q.Age).
		NotEmpty("and role_id = ?", q.RoleId).Build()
	result := FindPage(m.db, db.SysUsers{}, sql, values, in.Page)

	c.JSON(http.StatusOK, result)
}

//分页下拉
func (m *SysUsersApi) QuerySelect(c *gin.Context) {
	in := new(dto.SelectQueryDTO)
	if !utils.Bind(c, in) {
		return
	}
	q := in.QueryData
	sql, values := builder.Builder().SELECT("account as key_id", "name as title").
		FROM("sys_users").APPEND("and account is not null").
		NotEmpty("and CONCAT(account,name) like ?", builder.LIKE(q.Filter)).
		NotEmpty("or account in ?", q.Selected).Build()
	result := FindList(m.db, sql, values, in.Page)

	utils.Success(c, result)
}
