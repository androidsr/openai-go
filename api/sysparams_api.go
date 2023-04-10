package api

import (
	"openai-go/dao/builder"
	"openai-go/model/db"
	"openai-go/model/dto"
	"openai-go/utils"
	"net/http"

	"github.com/gin-gonic/gin"
)

type SysParamsApi struct {
	BaseApi
}

//参数管理
func NewSysParamsApi(baseApi BaseApi) {
	m := SysParamsApi{baseApi}

	group := m.router.Group("/sysparams")
	group.GET("/:id", m.Get)                   //查询
	group.POST("", m.Post)                     //增加
	group.PUT("/edit", m.Put)                  //修改
	group.DELETE("/:id", m.Delete)             //删除
	group.PUT("", m.QueryTables)               //查询列表
	group.POST("/select/:id", m.SelectByGroup) //按组查询
	group.POST("/getall", m.GetAll)            //查询所有参数
}

//查询
func (m *SysParamsApi) Get(c *gin.Context) {
	id := c.Param("id")
	data := new(db.SysParams)
	err := m.db.First(data, id).Error
	if err != nil {
		utils.FailResult(c, "查询失败")
		return
	}
	c.JSON(http.StatusOK, data)
}

//增加
func (m *SysParamsApi) Post(c *gin.Context) {
	in := new(db.SysParams)
	if !utils.Bind(c, in) {
		return
	}
	in.Id = m.getId()
	err := m.db.Create(in).Error

	if err != nil {
		utils.FailResult(c, "插入数据失败")
		return
	}
	utils.Success(c)
}

//修改
func (m *SysParamsApi) Put(c *gin.Context) {
	in := new(db.SysParams)
	if !utils.Bind(c, in) {
		return
	}
	err := m.db.Where("id = ?", in.Id).Updates(in).Error

	if err != nil {
		utils.FailResult(c, "更新数据失败")
		return
	}
	utils.Success(c)
}

//删除
func (m *SysParamsApi) Delete(c *gin.Context) {
	id := c.Param("id")
	if id == "" {
		utils.FailResult(c, "主键不能为空")
		return
	}
	err := m.db.Delete(db.SysParams{}, "id = ?", id).Error
	if err != nil {
		utils.FailResult(c, "删除数据失败")
		return
	}
	utils.Success(c)
}

//查询列表
func (m *SysParamsApi) QueryTables(c *gin.Context) {
	in := new(struct {
		Page      dto.PageDTO  `json:"page"`
		QueryData db.SysParams `json:"queryData"`
	})
	if !utils.Bind(c, in) {
		return
	}
	q := in.QueryData
	sql, values := builder.Builder().SELECT("*").FROM("sys_params").
		NotEmpty("and id = ?", q.Id).
		NotEmpty("and key_id = ?", q.KeyId).
		NotEmpty("and name like ?", builder.LIKE(q.Title)).
		NotEmpty("and group_name like ?", builder.LIKE(q.GroupName)).
		NotEmpty("and group_id = ?", q.GroupId).
		NotEmpty("and other_value like ?", builder.LIKE(q.OtherValue)).Build()
	result := FindPage(m.db, db.SysParams{}, sql, values, in.Page)
	c.JSON(http.StatusOK, result)
}

//分页下拉
func (m *SysParamsApi) QuerySelect(c *gin.Context) {
	in := new(dto.SelectQueryDTO)
	if !utils.Bind(c, in) {
		return
	}

	q := in.QueryData

	sql, values := builder.Builder().SELECT("id as key_id", "name as title").
		FROM("sys_params").APPEND("and id is not null").
		NotEmpty("and CONCAT(id,name) like ?", builder.LIKE(q.Filter)).
		NotEmpty("or id in ?", q.Selected).Build()
	result := FindList(m.db, sql, values, in.Page)
	utils.Success(c, result)
}

func (m *SysParamsApi) SelectByGroup(c *gin.Context) {
	id := c.Param("id")
	data := make([]db.SysParams, 0)
	err := m.db.Find(&data, "group_id = ?", id)
	if err != nil {
		utils.FailResult(c, "查询数据失败")
		return
	}
	utils.Success(c)
}

//加载全部参数
func (m *SysParamsApi) GetAll(c *gin.Context) {
	data := make([]db.SysParams, 0)
	err := m.db.Find(&data).Error
	if err != nil {
		utils.FailResult(c, "查询数据失败!")
		return
	}
	result := make(map[string][]ParamsData, 0)
	for _, v := range data {
		item := make([]ParamsData, 0)
		err := m.db.Model(db.SysParams{}).Find(&item, "group_id = ?", v.GroupId).Error
		if err != nil {
			utils.FailResult(c, "查询数据失败")
			return
		}
		result[v.GroupId] = item
	}
	c.JSON(http.StatusOK, result)
}

type ParamsData struct {
	KeyId string `json:"keyId" db:"key_id"`
	Title string `json:"title"`
}
