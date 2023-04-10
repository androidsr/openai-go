package vo

type PageInfoVO struct {
	Code  string      `json:"code"`
	Msg   string      `json:"msg"`
	Data  interface{} `json:"data"`
	Total int64       `json:"total" gorm:"column:total"`
}