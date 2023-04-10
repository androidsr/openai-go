package db

type SysParams struct {
	Id         string `json:"id" gorm:"column:id;primary_key"`
	Title      string `json:"title" gorm:"column:title"`
	KeyId      string `json:"keyId" gorm:"column:key_id"`
	GroupName  string `json:"groupName" gorm:"column:group_name"`
	GroupId    string `json:"groupId" gorm:"column:group_id"`
	OtherValue string `json:"otherValue" gorm:"column:other_value"`
}

type SysRoleMenu struct {
	RoleId    string `json:"roleId" gorm:"column:role_id;primary_key"`
	MenuId    string `json:"menuId" gorm:"column:menu_id;primary_key"`
	ButtonIds string `json:"buttonIds" gorm:"column:button_ids"`
}

type SysRoles struct {
	Id   string `json:"id" gorm:"column:id;primary_key"`
	Name string `json:"name" gorm:"column:name"`
}
