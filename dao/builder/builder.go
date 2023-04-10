package builder

import (
	"bytes"
	"fmt"
	"strings"
)

type QueryBuilder struct {
	sql    bytes.Buffer
	values []interface{}
}

func Builder() *QueryBuilder {
	helper := new(QueryBuilder)
	helper.sql = bytes.Buffer{}
	return helper
}

func (m *QueryBuilder) SQL(sql string) *QueryBuilder {
	m.sql.WriteString(sql)
	m.sql.WriteString(" where 1=1 ")
	return m
}

func (m *QueryBuilder) SELECT(col ...string) *QueryBuilder {
	m.sql.WriteString("select ")
	m.sql.WriteString(strings.Join(col, ", "))
	return m
}

func (m *QueryBuilder) FROM(tbName ...string) *QueryBuilder {
	m.sql.WriteString(" from ")
	m.sql.WriteString(strings.Join(tbName, " "))
	m.sql.WriteString(" where 1=1 ")
	return m
}

func LIKE(value interface{}) string {
	if value == nil || value == "" {
		return ""
	}
	return "%" + strings.TrimSpace(fmt.Sprintln(value)) + "%"
}

func RLIKE(value interface{}) string {
	if value == nil || value == "" {
		return ""
	}
	return strings.TrimSpace(fmt.Sprintln(value)) + "%"
}

func (m *QueryBuilder) APPEND(sql ...string) *QueryBuilder {
	m.sql.WriteString(" ")
	m.sql.WriteString(strings.Join(sql, " "))
	return m
}

func (m *QueryBuilder) NotEmpty(query string, value interface{}) *QueryBuilder {
	switch value.(type) {
	case string:
		if value == "" {
			return m
		}
	case []int64:
		if len(value.([]int64)) == 0 {
			return m
		}
	case []string:
		if len(value.([]string)) == 0 {
			return m
		}
	default:
		if value == nil || value == "" {
			return m
		}
	}

	m.sql.WriteString(" ")
	m.sql.WriteString(query)
	m.sql.WriteString(" ")
	m.values = append(m.values, value)
	return m
}

func (m *QueryBuilder) WHERE(cols []string, cond ...interface{}) *QueryBuilder {
	for i, v := range cond {
		switch v.(type) {
		case int64, int:
			if v.(int64) == 0 {
				continue
			}
		case string:
			if v.(string) == "" {
				continue
			}
		}
		m.sql.WriteString(" ")
		m.sql.WriteString(cols[i])
		m.sql.WriteString(" ")
		vs, ok := v.([]string)
		if ok {
			for _, d := range vs {
				m.values = append(m.values, d)
			}
		} else {
			m.values = append(m.values, v)
		}
	}
	return m
}

func (m *QueryBuilder) Build() (string, []interface{}) {
	sql := m.sql.String()
	values := m.values
	m.sql.Reset()
	m.values = []interface{}{}
	fmt.Printf("查询: %s\n参数: %s\n", sql, values)
	return sql, values
}
