package api

import (
	"openai-go/model/db"
	"openai-go/model/dto"
	"openai-go/utils"
	"log"
	"net/http"
	"openai-go/dao/builder"

	"gorm.io/gorm"

	"github.com/gin-gonic/gin"
)

type SysRolesApi struct {
	BaseApi
}

//权限管理
func NewSysRolesApi(baseApi BaseApi) {
	m := SysRolesApi{baseApi}

	group := m.router.Group("/sysroles")
	group.GET("/:id", m.Get)             //查询
	group.POST("", m.Post)               //增加
	group.PUT("/edit", m.Put)            //修改
	group.DELETE("/:id", m.Delete)       //删除
	group.PUT("", m.QueryTables)         //查询列表
	group.POST("/select", m.QuerySelect) //查询下拉
}

type RolesData struct {
	Id      string   `json:"id"`
	Name    string   `json:"name"`
	MenuIds []string `json:"menuIds"`
}

//查询
func (m *SysRolesApi) Get(c *gin.Context) {
	id := c.Param("id")
	data := new(db.SysRoles)
	data.Id = id
	err := m.db.First(data, id).Error
	if err != nil {
		utils.FailResult(c, "获取对象失败!")
		return
	}

	roleMenu := make([]db.SysRoleMenu, 0)
	err = m.db.Where("role_id = ?", data.Id).Find(&roleMenu).Error
	if err != nil {
		utils.FailResult(c, "获取对象失败")
		return
	}
	result := RolesData{Id: id, Name: data.Name}
	menuIds := make([]string, 0)
	for _, v := range roleMenu {
		menuIds = append(menuIds, v.MenuId)
	}
	result.MenuIds = menuIds
	c.JSON(http.StatusOK, result)
}

//增加
func (m *SysRolesApi) Post(c *gin.Context) {
	in := RolesData{}
	if !utils.Bind(c, &in) {
		return
	}
	in.Id = m.getId()
	tx := m.db.Session(&gorm.Session{SkipDefaultTransaction: true})
	err := tx.Create(db.SysRoles{
		Id:   in.Id,
		Name: in.Name,
	}).Error
	if err != nil {
		tx.Rollback()
		log.Println(err)
		return
	}
	for _, v := range in.MenuIds {
		menu := new(db.SysMenus)
		err := tx.First(menu, "id = ?", v).Error
		if err != nil || menu == nil {
			log.Println(err)
			tx.Rollback()
			break
		}
		err = tx.Create(db.SysRoleMenu{RoleId: in.Id, MenuId: v, ButtonIds: menu.BtnId}).Error
		if err != nil {
			log.Println(err)
			tx.Rollback()
			break
		}
	}
	tx.Commit()
	utils.Success(c)
}

//修改
func (m *SysRolesApi) Put(c *gin.Context) {
	in := new(RolesData)
	if !utils.Bind(c, in) {
		return
	}
	oldMenuIds := make([]db.SysRoleMenu, 0)
	err := m.db.Where("role_id = ?", in.Id).Find(&oldMenuIds).Error
	if err != nil {
		utils.FailResult(c, err.Error())
		return
	}
	//删除不要需要的权限菜单
	tx := m.db.Session(&gorm.Session{SkipDefaultTransaction: true})
	for _, v := range oldMenuIds {
		flag := false
		for _, vv := range in.MenuIds {
			if v.MenuId == vv {
				flag = true
				break
			}
		}
		if !flag {
			err := tx.Where("role_id = ? and menu_id = ?", v.RoleId, v.MenuId).Delete(db.SysRoleMenu{}).Error
			if err != nil {
				tx.Rollback()
				utils.FailResult(c, err.Error())
				return
			}
		}
	}
	//更新权限并新增按钮权限列表（只更新未增加的）
	for _, v := range in.MenuIds {
		var b int64
		m.db.Model(db.SysRoleMenu{}).Where("role_id = ? and menu_id = ?", in.Id, v).Count(&b)
		if b == 0 {
			menu := new(db.SysMenus)
			err := m.db.First(menu, "id = ?", v).Error
			if err != nil || menu == nil {
				tx.Rollback()
				utils.FailResult(c, err.Error())
				return
			}
			err = tx.Create(db.SysRoleMenu{RoleId: in.Id, MenuId: v, ButtonIds: menu.BtnId}).Error
			if err != nil {
				tx.Rollback()
				utils.FailResult(c, err.Error())
				return
			}
		}
	}
	err = tx.Where("id = ?", in.Id).Updates(db.SysRoles{Id: in.Id, Name: in.Name}).Error
	if err != nil {
		tx.Rollback()
		utils.FailResult(c, err.Error())
		return
	}
	tx.Commit()
	utils.Success(c)
}

//删除
func (m *SysRolesApi) Delete(c *gin.Context) {
	id := c.Param("id")
	if id == "" {
		utils.FailResult(c, "主键不能为空")
		return
	}
	tx := m.db.Session(&gorm.Session{SkipDefaultTransaction: true})
	err := tx.Where("role_id = ?", id).Delete(db.SysRoleMenu{}).Error
	if err != nil {
		tx.Rollback()
		utils.FailResult(c, "删除失败")
		return
	}
	err = tx.Where("id = ?", id).Delete(db.SysRoles{}).Error
	if err != nil {
		tx.Rollback()
		utils.FailResult(c, "删除失败")
		return
	}
	tx.Commit()
	utils.Success(c)
}

//查询列表
func (m *SysRolesApi) QueryTables(c *gin.Context) {
	in := new(struct {
		Page      dto.PageDTO   `json:"page"`
		QueryData db.SysButtons `json:"queryData"`
	})
	if !utils.Bind(c, in) {
		return
	}

	q := in.QueryData
	sql, values := builder.Builder().SELECT("*").FROM("sys_roles").
		NotEmpty("and id = ?", q.Id).
		NotEmpty("and name = ?", q.Title).Build()
	result := FindPage(m.db, db.SysRoles{}, sql, values, in.Page)
	c.JSON(http.StatusOK, result)
}

//分页下拉
func (m *SysRolesApi) QuerySelect(c *gin.Context) {
	in := new(dto.SelectQueryDTO)
	if !utils.Bind(c, in) {
		return
	}
	q := in.QueryData
	sql, values := builder.Builder().SELECT("id as key_id", "name as title").
		FROM("sys_roles").APPEND("and id is not null").
		NotEmpty("and CONCAT(id,name) like ?", builder.LIKE(q.Filter)).
		NotEmpty("or id in ?", q.Selected).Build()
	result := FindList(m.db, sql, values, in.Page)

	utils.Success(c, result)
}
