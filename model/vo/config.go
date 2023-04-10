package vo

type ConfigVO struct {
	Name       string `json:"name"`
	TableName  string `json:"tableName"`
	IsNull     string `json:"is_null"`
	IsPk       string `json:"is_pk"`
	IsAuto     string `json:"is_auto"`
	ShowTable  string `json:"show_table"`
	ShowQuery  string `json:"show_query"`
	ShowHandle string `json:"show_handle"`
	WidgetType string `json:"widget_type"`
	SelectUrl  string `json:"select_url"`
	EnName     string `json:"en_name"`
	CnName     string `json:"cn_name"`
	DataType   string `json:"data_type"`
}
