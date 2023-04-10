package config

import (
	"io/ioutil"

	"gopkg.in/yaml.v2"
)

var _cfg *config

type config struct {
	StaticDir string `yaml:"static-dir"`
	Server    struct {
		Port     string `yaml:"port"`
		WorkerId int64  `yaml:"workerId"`
	}
	Database struct {
		DriverName     string `yaml:"driverName"`
		DataSourceName string `yaml:"dataSourceName"`
	}
	OpenAIKey string `yaml:"openAIKey"`
}

func init() {
	_cfg = new(config)
	bs, err := ioutil.ReadFile("application.yaml")
	if err != nil {
		panic("读取配置出错！")
	}
	err = yaml.Unmarshal(bs, &_cfg)
	if err != nil {
		panic("加载配置出错！")
	}
}

func GetConfig() *config {
	return _cfg
}
