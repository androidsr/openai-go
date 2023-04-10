package api

import (
	"net/http"
	"openai-go/dao/builder"
	"openai-go/model/db"
	"openai-go/model/dto"
	"openai-go/utils"
	"strings"

	"github.com/gin-gonic/gin"
)

type SysRoleMenuApi struct {
	BaseApi
}

//功能管理
func NewSysRoleMenuApi(baseApi BaseApi) {
	m := SysRoleMenuApi{baseApi}

	group := m.router.Group("/sysrolemenu")
	group.GET("/:id", m.Get)             //查询
	group.POST("", m.Post)               //增加
	group.PUT("/edit", m.Put)            //修改
	group.DELETE("/:id", m.Delete)       //删除
	group.PUT("", m.QueryTables)         //查询列表
	group.POST("/select", m.QuerySelect) //查询下拉
}

//查询
func (m *SysRoleMenuApi) Get(c *gin.Context) {
	id := c.Param("id")
	var ids []string
	if strings.Contains(id, "&") {
		ids = strings.Split(id, "&")
	} else {
		utils.FailResult(c, "请求参数不正确！")
		return
	}
	data := new(db.SysRoleMenu)
	err := m.db.First(data, "role_id = ? and menu_id = ?", ids[0], ids[1]).Error
	if err != nil {
		utils.FailResult(c, "获取对象失败")
		return
	}
	c.JSON(http.StatusOK, data)
}

//增加
func (m *SysRoleMenuApi) Post(c *gin.Context) {
	in := new(db.SysRoleMenu)
	if !utils.Bind(c, in) {
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
func (m *SysRoleMenuApi) Put(c *gin.Context) {
	in := new(db.SysRoleMenu)
	if !utils.Bind(c, in) {
		return
	}
	err := m.db.Where("role_id = ? and menu_id = ?", in.RoleId, in.MenuId).Updates(in).Error

	if err != nil {
		utils.FailResult(c, "更新数据失败")
		return
	}
	utils.Success(c)
}

//删除
func (m *SysRoleMenuApi) Delete(c *gin.Context) {
	id := c.Param("id")
	var ids []string
	if strings.Contains(id, "&") {
		ids = strings.Split(id, "&")
	} else {
		utils.FailResult(c, "请求参数不正确！")
		return
	}
	err := m.db.Where("role_id = ? and menu_id = ?", ids[0], ids[1]).Delete(db.SysRoleMenu{}).Error
	if err != nil {
		utils.FailResult(c, "删除数据失败")
		return
	}
	utils.Success(c)
}

type RoleMenuData struct {
	RoleId   string `json:"roleId" gorm:"column:role_id"`
	MenuId   string `json:"menuId" gorm:"column:menu_id"`
	Name     string `json:"name"`
	Title    string `json:"title"`
	ButtonId string `json:"buttonId" gorm:"column:button_ids"`
	BtnId    string `json:"btnId" gorm:"column:btn_id"`
}

//查询列表
func (m *SysRoleMenuApi) QueryTables(c *gin.Context) {
	in := new(struct {
		Page      dto.PageDTO    `json:"page"`
		QueryData db.SysRoleMenu `json:"queryData"`
	})
	if !utils.Bind(c, in) {
		return
	}

	q := in.QueryData
	sql, values := builder.Builder().SQL(`
		select a.*, b.name, c.title, c.btn_id from sys_role_menu a
		left join sys_roles b on a.role_id = b.id
		left join sys_menus c on a.menu_id = c.id
	`).NotEmpty("and b.id = ?", q.RoleId).NotEmpty("and c.id = ?", q.MenuId).
		APPEND(" and a.button_ids <> '' and a.button_ids is not null ").Build()
	result := FindPage(m.db, RoleMenuData{}, sql, values, in.Page)
	c.JSON(http.StatusOK, result)
}

//分页下拉
func (SysRoleMenuApi) QuerySelect(c *gin.Context) {

}
