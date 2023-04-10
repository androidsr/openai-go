package vo


type SelectVO struct {
	KeyId string `json:"keyId" db:"key_id"`
	Title string `json:"title"`
}
