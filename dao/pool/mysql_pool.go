package pool

import (
	"openai-go/config"

	"gorm.io/driver/mysql"
	_ "gorm.io/driver/mysql"
	"gorm.io/gorm"
	"gorm.io/gorm/schema"
)

var _db *gorm.DB

func init() {
	var err error
	_db, err = gorm.Open(mysql.New(mysql.Config{
		DSN:               config.GetConfig().Database.DataSourceName,
		DefaultStringSize: 256,
		// string 类型字段的默认长度
		DisableDatetimePrecision: true,
		// 禁用 datetime 精度，MySQL 5.6 之前的数据库不支持
		DontSupportRenameIndex: true,
		// 重命名索引时采用删除并新建的方式，MySQL 5.7 之前的数据库和 MariaDB 不支持重命名索引
		DontSupportRenameColumn: true,
		// 用 `change` 重命名列，MySQL 8 之前的数据库和 MariaDB 不支持重命名列
		SkipInitializeWithVersion: false,
		// 根据版本自动配置
	}), &gorm.Config{
		//Logger: logger.Default.LogMode(logger.Info),
		NamingStrategy: schema.NamingStrategy{
			SingularTable: true, // 表不加s
		},
	})
	if err != nil {
		panic(err)
	}
}

func GetDB() *gorm.DB {
	return _db
}
