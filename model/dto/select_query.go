package dto

type SelectQueryDTO struct {
	Page      PageDTO `json:"page"`
	QueryData struct {
		Filter   string   `json:"filter"`
		Selected []string `json:"selected"`
		P1       string   `json:"p1"`
		Of       string   `json:"of"`
	}
}
