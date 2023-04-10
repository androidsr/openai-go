package api

import (
	"fmt"
	"net/http"

	"github.com/dgrijalva/jwt-go"
	"github.com/gorilla/websocket"
)

var (
	upgrader = websocket.Upgrader{
		CheckOrigin: func(r *http.Request) bool {
			return true
		},
	}
	clients = make(map[string]*websocket.Conn, 0)
)

func init() {
	go func() {
		http.HandleFunc("/ws", Ws)
		http.ListenAndServe(":10881", nil)
	}()
	fmt.Println("websocket 初始化完成")

}

func Ws(w http.ResponseWriter, r *http.Request) {
	fmt.Println("websocket 连接中...")
	tokenStr, err := r.Cookie("Authorized")
	if err != nil {
		w.Write([]byte(err.Error()))
		return
	}
	mp := jwt.MapClaims{}

	_, err = jwt.ParseWithClaims(tokenStr.Value, &mp, func(token *jwt.Token) (interface{}, error) {
		return []byte("a!d@#$d%^&f*(g)12e345xzde6789x"), nil
	})
	if err != nil {
		fmt.Println(err.Error())
		w.Write([]byte(err.Error()))
		return
	}
	userId := mp["user"].(string)
	c, err := upgrader.Upgrade(w, r, nil)
	if err != nil {
		w.Write([]byte(err.Error()))
		return
	}
	//defer c.Close()
	clients[userId] = c
	fmt.Println("当前在线用户：", userId, len(clients))
}

func sendMessage(userId, message string) error {
	defer func() {
		recover()
	}()
	client := clients[userId]
	err := client.WriteMessage(websocket.TextMessage, []byte(message))
	if err != nil {
		delete(clients, userId)
		client.Close()
	}
	return err
}
