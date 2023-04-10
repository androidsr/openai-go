package db

type SysMenus struct {
	Id        string `json:"id" gorm:"column:id;primary_key"`
	Title     string `json:"title" gorm:"column:title"`
	Url       string `json:"url" gorm:"column:url"`
	Icon      string `json:"icon" gorm:"column:icon"`
	SuperId   string `json:"superId" gorm:"column:super_id"`
	BtnId     string `json:"btnId" gorm:"column:btn_id"`
	MenuOrder string `json:"menuOrder" gorm:"column:menu_order"`
}

func (SysMenus) GetTable() string {
	return "sys_users"
}

func (SysMenus) GetColumns() []string {
	return []string{"account", "pass", "name", "`phone`", "email", "sex", "age", "role_id"}
}