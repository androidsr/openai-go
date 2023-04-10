package api

import (
	"openai-go/dao/builder"
	"openai-go/model/db"
	"openai-go/model/dto"
	"openai-go/utils"
	"net/http"
	"strings"

	"gorm.io/gorm"

	"github.com/gin-gonic/gin"
)

type SysMenusApi struct {
	BaseApi
}

//菜单管理
func NewSysMenusApi(baseApi BaseApi) {
	m := SysMenusApi{baseApi}

	group := m.router.Group("/sysmenus")
	group.GET("/:id", m.Get)                //查询
	group.POST("", m.Post)                  //增加
	group.PUT("/edit", m.Put)               //修改
	group.DELETE("/:id", m.Delete)          //删除
	group.PUT("", m.QueryTables)            //查询列表
	group.POST("/select", m.QuerySelect)    //查询下拉
	group.POST("/home", m.Home)             //主页菜单数据
	group.POST("/roles", m.Roles)           //权限功能菜单列表
	group.POST("/menuselect", m.MenuSelect) //菜单下拉
}

//查询
func (m *SysMenusApi) Get(c *gin.Context) {
	id := c.Param("id")
	data := new(db.SysMenus)
	err := m.db.First(data, id).Error

	if err != nil {
		utils.FailResult(c, "获取对象失败!")
		return
	}
	c.JSON(http.StatusOK, data)
}

//增加
func (m *SysMenusApi) Post(c *gin.Context) {
	in := new(db.SysMenus)
	if !utils.Bind(c, &in) {
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
func (m *SysMenusApi) Put(c *gin.Context) {
	in := new(db.SysMenus)
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
func (m *SysMenusApi) Delete(c *gin.Context) {
	id := c.Param("id")
	if id == "" {
		utils.FailResult(c, "主键不能为空")
		return
	}
	err := m.db.Delete(db.SysMenus{}, "id = ?", id).Error
	if err != nil {
		utils.FailResult(c, "删除数据失败!")
		return
	}
	utils.Success(c)
}

//查询列表
func (m *SysMenusApi) QueryTables(c *gin.Context) {
	in := new(struct {
		Page      dto.PageDTO `json:"page"`
		QueryData db.SysMenus `json:"queryData"`
	})

	if !utils.Bind(c, in) {
		return
	}

	q := in.QueryData
	sql, values := builder.Builder().SQL(`select * from sys_menus`).
		NotEmpty("and id = ?", q.Id).
		NotEmpty("and super_id = ?", q.SuperId).
		NotEmpty("and title like ?", builder.LIKE(q.Title)).
		NotEmpty("and url like ?", builder.LIKE(q.Url)).Build()
	result := FindPage(m.db, db.SysMenus{}, sql, values, in.Page)
	c.JSON(http.StatusOK, result)
}

//分页下拉
func (m *SysMenusApi) QuerySelect(c *gin.Context) {
	in := new(dto.SelectQueryDTO)
	if !utils.Bind(c, in) {
		return
	}

	q := in.QueryData
	sql, values := builder.Builder().SELECT("a.id as key_id", "title").FROM("sys_menus a").
		NotEmpty("and CONCAT(a.id,title) like ?", builder.LIKE(q.Filter)).
		NotEmpty("or a.id in ?", q.Selected).Build()
	result := FindList(m.db, sql, values, in.Page)
	utils.Success(c, result)
}

func (m *SysMenusApi) MenuSelect(c *gin.Context) {
	in := new(dto.SelectQueryDTO)
	if !utils.Bind(c, in) {
		return
	}
	q := in.QueryData
	bean := new(db.SysMenus)
	err := m.db.First(bean, "id = ?", q.Of).Error
	if err != nil {
		utils.FailResult(c, "获取菜单信息时失败!")
		return
	}

	q.Selected = append(q.Selected, strings.Split(bean.BtnId, ",")...)

	sql, values := builder.Builder().SELECT("id as key_id", "title").
		FROM("sys_buttons").APPEND("and id is not null").
		NotEmpty("and CONCAT(id,title) like ?", builder.LIKE(q.Filter)).
		NotEmpty("or id in ?", q.Selected).Build()
	result := FindList(m.db, sql, values, in.Page)
	utils.Success(c, result)
}

type Menus struct {
	Id        string          `json:"id"`
	Title     string          `json:"title"`
	Url       string          `json:"key"`
	Icon      string          `json:"icon"`
	SuperId   string          `json:"superId"`
	BtnId     string          `json:"btnId"`
	MenuOrder string          `json:"menuOrder"`
	Children  []Menus         `json:"children"`
	Buttons   []db.SysButtons `json:"buttons"`
}

func (mc *SysMenusApi) Home(c *gin.Context) {
	role := c.GetString(ROLE)
	ids := strings.Split(role, ",")
	if len(ids) < 1 {
		utils.FailResult(c, "用户无权限!")
		return
	}
	data := make([]db.SysMenus, 0)
	sql, _ := builder.Builder().SQL(`
		select a.* from sys_menus a
		left join sys_role_menu b on a.id = b.menu_id 
		left join sys_roles c on b.role_id = c.id 
 	`).NotEmpty("and c.id in ?", ids).APPEND("order by a.menu_order asc").Build()
	err := mc.db.Raw(sql, ids).Scan(&data).Error
	if err != nil {
		utils.FailResult(c, "查询数据失败")
		return
	}
	list := make([]Menus, 0)
	for _, m := range data {
		if m.SuperId != "" {
			continue
		}
		item := Menus{}
		item.Title = m.Title
		item.Id = m.Id
		if m.Url == "" {
			item.Url = m.Id
		} else {
			item.Url = m.Url
		}
		item.Children = readChild(mc.db, data, m, ids)
		list = append(list, item)
	}
	c.JSON(http.StatusOK, list)
}

func (mc *SysMenusApi) Roles(c *gin.Context) {
	data := make([]db.SysMenus, 0)

	err := mc.db.Find(&data).Error
	if err != nil {
		utils.FailResult(c, "查询数据失败")
		return
	}
	list := make([]Menus, 0)
	for _, m := range data {
		if m.SuperId != "" {
			continue
		}
		item := Menus{}
		item.Title = m.Title
		item.Id = m.Id
		item.Icon = m.Icon
		item.Url = m.Url
		item.Children = readChild(mc.db, data, m, nil)
		list = append(list, item)
	}
	c.JSON(http.StatusOK, list)
}

func readChild(orm *gorm.DB, data []db.SysMenus, suMenu db.SysMenus, roleIds []string) []Menus {
	result := make([]Menus, 0)
	for _, cur := range data {
		strId := suMenu.Id
		if cur.SuperId == strId {
			item := Menus{}
			item.Title = cur.Title
			if cur.Url == "" {
				item.Url = cur.Id
			} else {
				item.Url = cur.Url
			}
			item.Icon = cur.Icon
			item.Id = cur.Id
			if cur.BtnId != "" && len(roleIds) > 0 {
				buttons := make([]db.SysButtons, 0)
				for _, v := range roleIds {
					bean := new(db.SysRoleMenu)
					err := orm.Find(bean, "role_id = ? and menu_id = ?", v, cur.Id).Error
					if err != nil {
						return nil
					}

					btnInfo := make([]db.SysButtons, 0)
					ids := strings.Split(bean.ButtonIds, ",")

					mk := make([]interface{}, 0)
					for _, v := range ids {
						mk = append(mk, v)
					}
					err = orm.Model(db.SysButtons{}).Find(&btnInfo, "id in (?)", ids).Error
					if err != nil {
						return nil
					}
					buttons = append(buttons, btnInfo...)
				}
				item.Buttons = buttons
			}
			item.Children = readChild(orm, data, cur, roleIds)
			result = append(result, item)
		}
	}
	return result
}
