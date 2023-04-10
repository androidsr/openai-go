package db

type SysUsers struct {
	Account string `json:"account" gorm:"column:account;primary_key"`
	Pass    string `json:"pass" gorm:"column:pass"`
	Name    string `json:"name" gorm:"column:name"`
	Phone   string `json:"phone" gorm:"column:phone"`
	Email   string `json:"email" gorm:"column:email"`
	Sex     string `json:"sex" gorm:"column:sex"`
	Age     string `json:"age" gorm:"column:age"`
	RoleId  string `json:"roleId" gorm:"column:role_id"`
}
