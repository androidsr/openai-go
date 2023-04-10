package api

import (
	"openai-go/model/db"
	"openai-go/model/vo"
	"openai-go/utils"
	"fmt"
	"net/http"
	"strconv"
	"strings"
	"time"

	"github.com/dgrijalva/jwt-go"
	"github.com/gin-gonic/gin"
)

const (
	SUCCESS    = "0000"
	AUTHORIZED = "Authorized"
	SECRETKEY  = "a!d@#$d%^&f*(g)12e345xzde6789x"
	USER       = "SYS_USER"
	ROLE       = "SYS_ROLE"
)

type PermissionsApi struct {
	BaseApi
}

func NewPermissionsApi(baseApi BaseApi) {
	m := PermissionsApi{baseApi}
	//拦截器验证登录
	m.router.Use(m.Cors())
	m.router.Use(m.Before())

	//用户登录
	m.router.POST("/authorized", m.Authorized)
	m.router.DELETE("/logout", m.Logout)
	m.router.PUT("/repasswd", m.ResetPasswd)
	m.router.POST("/register", m.Register)
}

// 创建token
func (m *PermissionsApi) generate(c *gin.Context, claims jwt.MapClaims) (string, error) {
	token := jwt.New(jwt.SigningMethodHS256)
	if claims == nil {
		claims = make(jwt.MapClaims)
	}
	claims["exp"] = strconv.FormatInt(time.Now().Add(time.Hour*time.Duration(1)).Unix(), 10)
	claims["iat"] = strconv.FormatInt(time.Now().Unix(), 10)
	token.Claims = claims

	tokenString, err := token.SignedString([]byte(SECRETKEY))
	if err != nil {
		return "", err
	}
	c.SetCookie(AUTHORIZED, tokenString, 0, "/", "", false, true)
	return tokenString, nil
}

// 转换token
func (m *PermissionsApi) tokenToClaims(tokenStr string) (*jwt.Token, jwt.MapClaims, error) {
	mp := jwt.MapClaims{}

	token, err := jwt.ParseWithClaims(tokenStr, &mp, func(token *jwt.Token) (interface{}, error) {
		return []byte(SECRETKEY), nil
	})
	return token, mp, err
}

// 认证信息
func (m *PermissionsApi) validate(c *gin.Context) bool {
	tokenStr, _ := c.Cookie(AUTHORIZED)
	token, mp, err := m.tokenToClaims(tokenStr)
	if err == nil {
		if token.Valid {
			t, err := strconv.ParseInt(mp["iat"].(string), 10, 64)
			if err != nil {
				utils.FailResult(c, "安全验证失败")
				return false
			}
			second := (time.Now().Unix() - t) / 60
			if second > 50 && second < 60 {
				m.generate(c, mp)
			}
			c.Set(USER, mp["user"])
			c.Set(ROLE, mp["role"])
			return true
		} else {
			c.String(http.StatusUnauthorized, "%s", "认证失败")
			return false
		}
	} else {
		c.String(http.StatusUnauthorized, "%s", "认证失败")
		c.Abort()
		return false
	}
}

// 跨域处理
func (m *PermissionsApi) Cors() gin.HandlerFunc {
	return func(c *gin.Context) {
		method := c.Request.Method
		origin := c.Request.Header.Get("Origin")
		var headerKeys []string
		for k := range c.Request.Header {
			headerKeys = append(headerKeys, k)
		}
		headerStr := strings.Join(headerKeys, ", ")
		if headerStr != "" {
			headerStr = fmt.Sprintf("access-control-allow-origin, access-control-allow-headers, %s", headerStr)
		} else {
			headerStr = "access-control-allow-origin, access-control-allow-headers"
		}
		if origin != "" {
			c.Writer.Header().Set("Access-Control-Allow-Origin", "*")
			c.Header("Access-Control-Allow-Origin", "*")
			c.Header("Access-Control-Allow-Methods", "POST, GET, OPTIONS, PUT, DELETE,UPDATE")
			c.Header("Access-Control-Allow-Headers", "Authorization, Content-Length, X-CSRF-Token, Token,session,X_Requested_With,Accept, Origin, Host, Connection, Accept-Encoding, Accept-Language,DNT, X-CustomHeader, Keep-Alive, User-Agent, X-Requested-With, If-Modified-Since, Cache-Control, Content-Type, Pragma")
			c.Header("Access-Control-Expose-Headers", "Content-Length, Access-Control-Allow-Origin, Access-Control-Allow-Headers,Cache-Control,Content-Language,Content-Type,Expires,Last-Modified,Pragma,FooBar") // 跨域关键设置 让浏览器可以解析
			c.Header("Access-Control-Max-Age", "172800")                                                                                                                                                           // 缓存请求信息 单位为秒
			c.Header("Access-Control-Allow-Credentials", "false")                                                                                                                                                  //  跨域请求是否需要带cookie信息 默认设置为true
			c.Set("content-type", "application/json")                                                                                                                                                              // 设置返回格式是json
		}

		//放行所有OPTIONS方法
		if method == "OPTIONS" {
			c.JSON(http.StatusOK, "Options Request!")
		}
		// 处理请求
		c.Next() //  处理请求
	}
}

// 拦截器
func (m *PermissionsApi) Before() gin.HandlerFunc {
	return func(c *gin.Context) {
		if c.Request.URL.Path == "/api/authorized" || c.Request.URL.Path == "/api/register" {
			c.Next()
			return
		}
		valid := m.validate(c)
		if valid {
			c.Next()
		} else {
			c.Abort()
		}
	}
}

// 用户登录
func (m *PermissionsApi) Authorized(c *gin.Context) {
	user := struct {
		UserId string `json:"userId"`
		Passwd string `json:"passwd"`
	}{}
	utils.Bind(c, &user)
	if user.UserId == "" || user.Passwd == "" {
		c.JSON(http.StatusOK, vo.HttpResult{Code: "00001", Msg: "用户名或密码不能为空！"})
		return
	}
	data := new(db.SysUsers)
	err := m.db.Where("account = ?", user.UserId).First(data).Error
	if err != nil {
		utils.FailResult(c, "获取用户信息失败!")
		return
	}
	if data.Pass == "" || data.Pass != user.Passwd {
		c.JSON(http.StatusOK, vo.HttpResult{Code: "0001", Msg: "账号或密码不正确！"})
		return
	}
	claims := make(jwt.MapClaims)
	claims["user"] = data.Account
	claims["role"] = data.RoleId

	tokenStr, err := m.generate(c, claims)
	if err != nil {
		utils.FailResult(c, "创建认证信息失败")
		return
	}
	result := vo.LoginResultVO{HttpResult: vo.HttpResult{Code: SUCCESS, Msg: "登录成功"},
		Token: tokenStr, UserId: data.Account, UserName: data.Name}
	c.JSON(http.StatusOK, result)
}

// 修改密码
func (m *PermissionsApi) ResetPasswd(c *gin.Context) {
	info := struct {
		UserId    string `json:"userId"`
		NewPasswd string `json:"newPasswd"`
		Passwd    string `json:"passwd"`
	}{}
	utils.Bind(c, &info)
	if info.UserId == "" || info.Passwd == "" || info.NewPasswd == "" {
		c.JSON(http.StatusOK, vo.HttpResult{Code: "0001", Msg: "输入信息不完整"})
		return
	}
	data := new(db.SysUsers)
	err := m.db.Where("account = ?", info.UserId).First(data)
	if err != nil {
		fmt.Println(err)
		utils.FailResult(c, "获取用户信息失败!")
		return
	}

	if data.Pass != info.Passwd {
		c.JSON(http.StatusOK, vo.HttpResult{Code: "0001", Msg: "账号或密码不正确！"})
		return
	}
	data.Pass = info.NewPasswd
	m.db.Where("account = ?", info.UserId).Updates(data)
	utils.Success(c)
}

// 用户注册
func (m *PermissionsApi) Register(c *gin.Context) {
	data := new(db.SysUsers)
	utils.Bind(c, &data)
	data.RoleId = "61"
	m.db.Save(data)
	utils.Success(c)
}

// 退出登录
func (m *PermissionsApi) Logout(c *gin.Context) {
	utils.Success(c)
}
