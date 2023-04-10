package main

import (
	"openai-go/config"
	"openai-go/router"
	"fmt"
	"log"
	"os"
)

func main() {
	os.RemoveAll("cache")
	log.SetFlags(log.Llongfile | log.LstdFlags)
	server := router.NewRouter()
	err := server.Run(":" + config.GetConfig().Server.Port)
	if err != nil {
		fmt.Println(err)
	}
}
