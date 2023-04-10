package db

type SysButtons struct {
	Id      string `json:"id" gorm:"primaryKey"`
	Title   string `json:"title" gorm:"column:title"`
	Click   string `json:"click" gorm:"column:click"`
	Icon    string `json:"icon" gorm:"column:icon"`
	State   string `json:"state" gorm:"column:state"`
	OrderId string `json:"orderId" gorm:"column:order_id"`
}

func (SysButtons) GetTable() string {
	return "sys_users"
}

func (SysButtons) GetColumns() []string {
	return []string{"account", "pass", "name", "`phone`", "email", "sex", "age", "role_id"}
}
