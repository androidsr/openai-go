package vo

type LoginResultVO struct {
	HttpResult
	Token    string `json:"token"`
	UserId   string `json:"userId"`
	UserName string `json:"userName"`
}
