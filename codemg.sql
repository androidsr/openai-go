/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 50731 (5.7.31-log)
 Source Host           : 172.16.9.19:3306
 Source Schema         : openai-go

 Target Server Type    : MySQL
 Target Server Version : 50731 (5.7.31-log)
 File Encoding         : 65001

 Date: 05/01/2023 11:35:11
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for common_dict
-- ----------------------------
DROP TABLE IF EXISTS `common_dict`;
CREATE TABLE `common_dict`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `group_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分组编号',
  `group_title` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分组标题',
  `dict_key` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字典KEY',
  `dict_title` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字典标题',
  `reserve1` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '预留字段1',
  `reserve2` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '预留字段2',
  `reserve3` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '预留字段3',
  `reserve4` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '预留字段4',
  `reserve5` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '预留字段5',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of common_dict
-- ----------------------------
INSERT INTO `common_dict` VALUES (8201461200874647552, 'GroupCode', '分组标题', 'DictKey', 'DictTitle', '', '', '', '', '', '2022-04-10 19:42:19', '2022-04-10 19:42:19');
INSERT INTO `common_dict` VALUES (8201465667229593600, 'GroupCode', '分组标题', 'DictKey', 'DictTitle', '', '', '', '', '', '2022-04-10 20:00:04', '2022-04-10 20:00:04');
INSERT INTO `common_dict` VALUES (8201472640915353600, 'GroupCode', '分组标题', 'DictKey', 'DictTitle', '', '', '', '', '', '2022-04-10 20:27:47', '2022-04-10 20:27:47');

-- ----------------------------
-- Table structure for si_database_type
-- ----------------------------
DROP TABLE IF EXISTS `si_database_type`;
CREATE TABLE `si_database_type`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `db_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据库名称',
  `table_sql` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '获取表信息',
  `table_detail` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '获取表详情',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of si_database_type
-- ----------------------------
INSERT INTO `si_database_type` VALUES (1553282696073973760, 'mysql', 'SELECT table_name as name,table_comment as comment  FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = \'%s\'', 'select column_name as col_name,column_comment as col_comment,column_type as col_type,is_nullable as is_null,column_key as col_key from information_schema.columns where table_name=\'%s\' and table_schema=\'%s\'');
INSERT INTO `si_database_type` VALUES (1554362407713771520, 'postgres', 'select\n        b.relname as name,\n        a.description as comment\nfrom\n        pg_description a\n        left join pg_class b on a.objoid = b.oid\n        left join pg_tables c on c.tablename = b.relname\nwhere  objsubid = 0 and c.schemaname = \'public\' and c.tableowner = \'%s\'\n', 'SELECT a.attname as col_name,col_description(a.attrelid,a.attnum) as col_comment,\nconcat_ws(\'\',t.typname,SUBSTRING(format_type(a.atttypid,a.atttypmod) from \'\\(.*\\)\')) as col_type,\ncase when a.attnotnull =true  then \'NO\' else \'YES\' end as is_null,\nCASE a.attname when \'id\' then \'PRI\'  else \'\' end as col_key\nFROM pg_class c, pg_attribute a , pg_type t, pg_description d,pg_constraint e\nwhere c.relname = \'%s\' and c.relname != \'%s\' and a.attnum>0 and a.attrelid = c.oid and a.atttypid = t.oid and  d.objoid=a.attrelid and d.objsubid=a.attnum and c.oid = e.conrelid \n');

-- ----------------------------
-- Table structure for si_templates
-- ----------------------------
DROP TABLE IF EXISTS `si_templates`;
CREATE TABLE `si_templates`  (
  `id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '模板类型',
  `pkg` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '模块名称',
  `context` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '模板内容',
  `path` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '路径',
  `is_form_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '是否组件',
  `crt_opr` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建人',
  `server_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '后台服务类型',
  `ui_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'UI类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '11' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of si_templates
-- ----------------------------
INSERT INTO `si_templates` VALUES ('1', '1', 'Controller.java', 'import lombok.extern.slf4j.Slf4j;\nimport org.springframework.beans.factory.annotation.Autowired;\nimport org.springframework.validation.annotation.Validated;\nimport org.springframework.web.bind.annotation.*;\nimport paas.web.validation.Insert;\nimport paas.web.validation.Update;\nimport paas.model.pagination.PageResult;\nimport java.io.Serializable;\n\n/**\n * {{.TableCnName}}\n *\n * @author {{.Author}}\n */\n@Slf4j\n@Api(tags = \"{{.TableCnName}}\")\n@RestController\n@RequestMapping(\"/{{.TableNameToUrlPath}}\")\npublic class {{.TableNameToTitle}}Controller {\n\n    @Autowired\n    {{.TableNameToTitle}}Service {{.TableNameToAttrName}}Service;\n\n    /**\n     * 主键查询\n     *\n     * @param id 主键\n     * @return\n     */\n    @ApiOperation(\"查询详情\")\n    @GetMapping(\"/{id}\")\n    public HttpResult<{{.TableNameToTitle}}VO> get(@PathVariable(\"id\") Serializable id) {\n        {{.TableNameToTitle}}VO result = {{.TableNameToAttrName}}Service.selectById(id);\n        return HttpResult.ok(result);\n    }\n\n    /**\n     * 新增\n     *\n     * @param dto 插入\n     * @return\n     */\n    @ApiOperation(\"新增\")\n    @PostMapping(\"/add\")\n    public HttpResult add(@RequestBody @Validated(Insert.class) {{.TableNameToTitle}}DTO dto) {\n        return HttpResult.isOk({{.TableNameToAttrName}}Service.save(dto) > 0);\n    }\n\n    /**\n     * 更新\n     *\n     * @param dto 更新\n     * @return\n     */\n    @ApiOperation(\"更新\")\n    @PutMapping(\"/update\")\n    public HttpResult update(@RequestBody @Validated(Update.class) {{.TableNameToTitle}}DTO dto) {\n        return HttpResult.isOk( {{.TableNameToAttrName}}Service.updateById(dto) > 0);\n    }\n\n    /**\n     * 主键删除\n     *\n     * @param id 主键\n     * @return\n     */\n    @ApiOperation(\"删除\")\n    @DeleteMapping(\"/delete/{id}\")\n    public HttpResult deleteById(@PathVariable(\"id\") Serializable id) {\n        return HttpResult.isOk({{.TableNameToAttrName}}Service.deleteById(id) > 0);\n    }\n\n    /**\n     * 查询列表\n     *\n     * @param query 条件和分页\n     * @return\n     */\n    @ApiOperation(\"分页列表查询\")\n    @PostMapping(\"/page\")\n    public HttpResult<PageResult<{{.TableNameToTitle}}VO>> queryPage(@RequestBody {{.TableNameToTitle}}QueryDTO query) {\n        return HttpResult.ok({{.TableNameToAttrName}}Service.queryPage(query));\n    }\n\n    /**\n     * 分页下拉选择数据\n     *\n     * @param query 查询条件\n     * @return\n     */\n    @ApiOperation(\"分页下拉查询\")\n    @PostMapping(\"/list\")\n    public HttpResult<PageResult<SelectVO>> queryList(@RequestBody SelectQueryDTO query) {\n        return HttpResult.ok({{.TableNameToAttrName}}Service.queryList(query));\n    }\n}\n', 'controller', '2', '', '1', 'HeyUI');
INSERT INTO `si_templates` VALUES ('10', '3', '/form.vue', '<template>\n  <div class=\"h-panel\">\n    <TitleBar></TitleBar>\n    <div class=\"h-panel-body bottom-line\">\n      <Form ref=\"form\" :validOnChange=\"true\" :showErrorTip=\"true\" labelPosition=\"left\" :labelWidth=\"110\" :rules=\"vRules\" :model=\"model\" mode=\"twocolumn\">\n{{range .TableDetail}}\n        {{GetWidget .}}\n{{end -}}\n      </Form>\n    </div>\n    <ButtonBar></ButtonBar>\n  </div>\n</template>\n\n<script>\nexport default {\n  async mounted() {\n    let id = this.$route.query.id;\n    if (!!id) {\n      this.model = await this.$store.dispatch(\"getFormData\", id);\n    }\n  },\n  data() {\n    return {\n      model: {\n{{range .TableDetail}}\n          {{.EnNameToCode}}: \"\",\n{{- end}}\n      },\n      vRules: {\n        required: [\n{{range .TableDetail}}\n          {{.EnNameToCode}},\n{{- end}}\n        ]\n      }\n    };\n  },\n  deactivated() {\n    this.$destroy(true);\n  }\n};\n</script>\n', 'heyui', '2', '', '1', 'HeyUI');
INSERT INTO `si_templates` VALUES ('11', '3', '/query.vue', '<template>\n  <div class=\"h-panel\">\n    <TitleBar></TitleBar>\n    <div class=\"h-panel-body bottom-line\">\n      <Form ref=\"form\" :validOnChange=\"true\" :showErrorTip=\"true\" labelPosition=\"true\" :labelWidth=\"110\" :rules=\"vRules\" :model=\"model\" mode=\"twocolumn\">\n{{range .TableDetail}}\n        {{GetWidget .}}\n{{- end}}\n      </Form>\n	</div>\n	<ButtonBar></ButtonBar>\n	</div>\n</template>\n\n<script>\nexport default {\n  data() {\n    return {\n      model: {\n{{range .TableDetail}}\n              {{.EnNameToCode}}: \"\",\n{{- end}}\n      },\n      vRules: {\n        required: []\n      }\n    };\n  },\n  methods: {}\n};\n</script>\n', 'heyui', '2', '', '1', 'HeyUI');
INSERT INTO `si_templates` VALUES ('12', '3', '上传', '<EasyUpload url=\"{{.SelectUrl}}\" prop=\"{{.EnNameToCode}}\" v-model=\"model.{{.EnNameToCode}}\" label=\"{{.CnName}}\"></EasyUpload>', 'widget', '1', 'sirui', '1', 'HeyUI');
INSERT INTO `si_templates` VALUES ('13', '3', '下拉', '<EasySelect label=\"{{.CnName}}\" prop=\"{{.EnNameToCode}}\" v-model=\"model.{{.EnNameToCode}}\"  params=\"{{.EnNameToCode}}\"></EasySelect>\n', 'widget', '1', 'sirui', '1', 'HeyUI');
INSERT INTO `si_templates` VALUES ('14', '3', '分页下拉', '<EasyPageSelect label=\"{{.CnName}}\" prop=\"{{.EnNameToCode}}\" v-model=\"model.{{.EnNameToCode}}\" url=\"{{.SelectUrl}}\"></EasyPageSelect>\n', 'widget', '1', 'sirui', '1', 'HeyUI');
INSERT INTO `si_templates` VALUES ('1461975883957927936', '1', 'DTO.java', 'import lombok.Data;\n\nimport javax.validation.constraints.NotBlank;\nimport javax.validation.constraints.NotNull;\nimport javax.validation.constraints.Null;\nimport javax.validation.constraints.Size;\nimport java.time.LocalDateTime;\nimport java.util.Date;\nimport paas.web.validation.Insert;\nimport paas.web.validation.Update;\n/**\n * {{.TableCnName}}-请求\n *\n * @author {{.Author}}\n */\n@Data\n@Builder\n@AllArgsConstructor\n@NoArgsConstructor\n@EqualsAndHashCode(callSuper = false)\npublic class {{.TableNameToTitle}}DTO extends BaseDTO implements Serializable {\n{{range .TableDetail}}\n    {{if ne (or .EnName \"id\"  \"create_time\" \"modify_time\" \"create_by\" \"modify_by\" \"create_by_name\" \"modify_by_name\") true}}\n    /**{{.CnName}}*/{{if .IsNull}}@NotNull(groups = {Insert.class, Update.class}, message = \"{{.CnName}}不能为空\"){{- end}} {{if .DataSize}}@Size(max = {{.DataSize}},message = \"{{.CnName}}不能超过{{.DataSize}}个字符\"){{- end}} {{if eq .EnNameToCode $.TableIdToCodeName}}@JsonFormat(shape = JsonFormat.Shape.STRING){{- end}}\n    private {{.DataTypeToCode}} {{.EnNameToCode}};\n    {{- end}}\n{{end}}\n}\n', 'dto', '2', '', '2', 'HeyUI');
INSERT INTO `si_templates` VALUES ('1461976092242870272', '1', 'QueryDTO.java', 'import java.time.LocalDateTime;\nimport java.util.Date;\n/**\n * {{.TableCnName}}-查询\n *\n * @author {{.Author}}\n */\n@Data\n@Builder\n@AllArgsConstructor\n@NoArgsConstructor\n@EqualsAndHashCode(callSuper = false)\npublic class {{.TableNameToTitle}}QueryDTO extends BaseQueryDTO  implements Serializable {\n{{range .TableDetail}}\n    {{if ne (or .EnName \"id\"  \"create_time\" \"modify_time\" \"create_by\" \"modify_by\" \"create_by_name\" \"modify_by_name\") true}}\n    /**{{.CnName}}*/{{if eq .EnNameToCode $.TableIdToCodeName}}@JsonFormat(shape = JsonFormat.Shape.STRING){{end}} {{if eq .DataTypeToCode \"Date\" }}@JsonFormat(pattern = \"yyyy-MM-dd HH:mm:ss\", timezone = \"GMT+8\"){{end}}\n    private {{.DataTypeToCode}} {{.EnNameToCode}};\n    {{- end}}\n{{- end -}}\n}\n', 'dto/query', '2', '', '2', 'HeyUI');
INSERT INTO `si_templates` VALUES ('1461976196316135424', '1', 'VO.java', 'import lombok.Data;\nimport java.time.LocalDateTime;\nimport java.util.Date;\n/**\n * {{.TableCnName}}-VO\n *\n * @author {{.Author}}\n */\n@ApiModel(\"{{.TableCnName}}-响应数据\")\n@Data\n@Builder\n@AllArgsConstructor\n@NoArgsConstructor\n@EqualsAndHashCode(callSuper = false)\npublic class {{.TableNameToTitle}}VO  extends BaseVO implements Serializable {\n{{range .TableDetail}}\n    {{if ne (or .EnName \"id\"  \"create_time\" \"modify_time\" \"create_by\" \"modify_by\" \"create_by_name\" \"modify_by_name\") true}}\n    @ApiModelProperty(\"{{.CnName}}\") {{if eq .EnNameToCode $.TableIdToCodeName}}@JsonFormat(shape = JsonFormat.Shape.STRING){{- end}}\n    private {{.DataTypeToCode}} {{.EnNameToCode}};\n    {{- end}}\n{{- end}}\n}\n', 'vo', '2', '', '1', 'HeyUI');
INSERT INTO `si_templates` VALUES ('1461976383101075456', '1', 'Excel.java', 'import lombok.Data;\nimport lombok.experimental.Accessors;\nimport java.time.LocalDateTime;\nimport java.io.Serializable;\nimport java.util.Date;\n\n/**\n * {{.TableCnName}}-报表\n *\n * @author {{.Author}}\n */\n@Data\n@Accessors(chain = true)\npublic class {{.TableNameToTitle}}Excel implements Serializable {\n{{range .TableDetail}}\n    @ExcelProperty(value = \"{{.CnName}}\")\n    private {{.DataTypeToCode}} {{.EnNameToCode}};\n{{end}}\n}\n', 'excel', '2', '', '1', 'HeyUI');
INSERT INTO `si_templates` VALUES ('15', '3', '文本', '<EasyInput label=\"{{.CnName}}\" prop=\"{{.EnNameToCode}}\" v-model=\"model.{{.EnNameToCode}}\"></EasyInput>\n', 'widget', '1', 'sirui', '1', 'HeyUI');
INSERT INTO `si_templates` VALUES ('1512799016520257536', '1', 'ControllerTests.java', 'import com.alibaba.fastjson.JSONObject;\nimport lombok.extern.slf4j.Slf4j;\nimport org.junit.jupiter.api.Test;\nimport yq.cloud.utils.OkHttpUtil;\n\n@Slf4j\npublic class {{.TableNameToTitle}}ControllerTests {\n    private String modelPath = \"{{.TableNameToUrlPath}}\";\n\n\n    @Test\n    public void page() {\n        String url = BaseTests.url + modelPath + \"/page\";\n        log.info(\"列表->: {}\", url);\n        {{.TableNameToTitle}}QueryDTO query = new {{.TableNameToTitle}}QueryDTO();\n        query.setCurrent(0);\n        query.setSize(10);\n         String data = JSONObject.toJSONString(query);\n        log.info(\"请求数据：{}\", data);\n        String result = OkHttpUtil.sendPost(url, data);\n        log.info(\"<-响应结果:\\n {}\", result);\n    }\n\n\n    @Test\n    public void get() {\n        String url = BaseTests.url + modelPath + \"/:id\";\n        log.info(\"查询->: {}\", url);\n        String result = OkHttpUtil.sendGet(url);\n        log.info(\"<-响应结果: {}\", result);\n    }\n\n    @Test\n    public void post() {\n        String url = BaseTests.url + modelPath + \"/add\";\n        log.info(\"新增->: {}\", url);\n        {{.TableNameToTitle}}DTO dto = new {{.TableNameToTitle}}DTO();\n        String data = JSONObject.toJSONString(dto);\n        log.info(\"请求数据：{}\", data);\n        String result = OkHttpUtil.sendPost(url, JSONObject.toJSONString(dto));\n        log.info(\"<-新增响应结果:\\n {}\", result);\n    }\n\n    @Test\n    public void update() {\n        String url = BaseTests.url + modelPath + \"/update\";\n        log.info(\"更新->: {}\", url);\n        {{.TableNameToTitle}}DTO dto = new {{.TableNameToTitle}}DTO();\n\n        String data = JSONObject.toJSONString(dto);\n        log.info(\"请求数据：{}\", data);\n        String result = OkHttpUtil.sendPut(url, data);\n        log.info(\"<-更新响应结果:\\n {}\", result);\n    }\n\n    @Test\n    public void delete() {\n        String url = BaseTests.url + modelPath + \"/delete/\" + \":id\";\n        log.info(\"删除->: {}\", url);\n        String result = OkHttpUtil.sendDelete(url);\n        log.info(\"<-响应结果:\\n {}\", result);\n    }\n}\n', 'tests', '2', '', '1', 'HeyUI');
INSERT INTO `si_templates` VALUES ('1595654491653279744', '1', 'Facade.java', '\nimport io.swagger.annotations.ApiOperation;\nimport org.springframework.cloud.openfeign.FeignClient;\nimport org.springframework.validation.annotation.Validated;\nimport org.springframework.web.bind.annotation.*;\nimport paas.model.web.HttpResult;\nimport paas.web.validation.Insert;\nimport paas.web.validation.Update;\nimport java.io.Serializable;\n\n@FeignClient(name = \"服务名\", contextId = \"{{.TableNameToTitle}}Facade\", path = \"/{{.TableNameToUrlPath}}\", fallback = {{.TableNameToTitle}}FacadeFallback.class)\npublic interface {{.TableNameToTitle}}Facade {\n\n    @ApiOperation(\"查询详情\")\n    @GetMapping(\"/{id}\")\n    HttpResult<{{.TableNameToTitle}}VO> get(@PathVariable(\"id\") Serializable id);\n\n    @ApiOperation(\"新增\")\n    @PostMapping(\"/add\")\n    HttpResult add(@RequestBody @Validated(Insert.class) {{.TableNameToTitle}}DTO dto);\n\n    @ApiOperation(\"更新\")\n    @PutMapping(\"/update\")\n    HttpResult update(@RequestBody @Validated(Update.class) {{.TableNameToTitle}}DTO dto);\n\n    @ApiOperation(\"删除\")\n    @DeleteMapping(\"/delete/{id}\")\n    HttpResult deleteById(@PathVariable(\"id\") Serializable id);\n}\n', 'feign', '2', '', '1', 'HeyUI');
INSERT INTO `si_templates` VALUES ('1595655261941403648', '1', 'FacadeFallback.java', '\nimport lombok.extern.slf4j.Slf4j;\nimport org.springframework.stereotype.Component;\nimport paas.model.web.HttpResult;\nimport com.wisesoft.scm.finance.common.enums.ResultMessage;\n\nimport java.io.Serializable;\n\n@Slf4j\n@Component\npublic class {{.TableNameToTitle}}FacadeFallback implements {{.TableNameToTitle}}Facade {\n\n    @Override\n    public HttpResult<{{.TableNameToTitle}}VO> get(Serializable id) {\n        return HttpResult.fail(ResultMessage.NET_FAILURE);\n    }\n\n    @Override\n    public HttpResult add({{.TableNameToTitle}}DTO dto) {\n        return HttpResult.fail(ResultMessage.NET_FAILURE);\n    }\n\n    @Override\n    public HttpResult update({{.TableNameToTitle}}DTO dto) {\n        return HttpResult.fail(ResultMessage.NET_FAILURE);\n    }\n\n    @Override\n    public HttpResult deleteById(Serializable id) {\n        return HttpResult.fail(ResultMessage.NET_FAILURE);\n    }\n}\n', 'feign/fallback', '2', '', '1', 'HeyUI');
INSERT INTO `si_templates` VALUES ('16', '3', '日期', '<EasyDate label=\"{{.CnName}}\" prop=\"{{.EnNameToCode}}\" v-model=\"model.{{.EnNameToCode}}\"></EasyDate>\n', 'widget', '1', 'sirui', '1', 'HeyUI');
INSERT INTO `si_templates` VALUES ('1610833391257653248', '1', 'Controller.java', 'import lombok.extern.slf4j.Slf4j;\nimport org.springframework.beans.factory.annotation.Autowired;\nimport org.springframework.validation.annotation.Validated;\nimport org.springframework.web.bind.annotation.*;\nimport paas.web.validation.Insert;\nimport paas.web.validation.Update;\nimport paas.model.pagination.PageResult;\nimport java.io.Serializable;\n\n/**\n * {{.TableCnName}}\n *\n * @author {{.Author}}\n */\n@Slf4j\n@RestController\n@RequestMapping(\"/{{.TableNameToUrlPath}}\")\npublic class {{.TableNameToTitle}}Controller {\n\n    @Autowired\n    {{.TableNameToTitle}}Service {{.TableNameToAttrName}}Service;\n\n    /**\n     * 主键查询\n     *\n     * @param id 主键\n     * @return\n     */\n    @GetMapping(\"/{id}\")\n    public HttpResult<{{.TableNameToTitle}}VO> get(@PathVariable(\"id\") Serializable id) {\n        {{.TableNameToTitle}}VO result = {{.TableNameToAttrName}}Service.selectById(id);\n        return HttpResult.ok(result);\n    }\n\n    /**\n     * 新增\n     *\n     * @param dto 插入\n     * @return\n     */\n    @PostMapping(\"/add\")\n    public HttpResult add(@RequestBody @Validated(Insert.class) {{.TableNameToTitle}}DTO dto) {\n        return HttpResult.isOk({{.TableNameToAttrName}}Service.save(dto) > 0);\n    }\n\n    /**\n     * 更新\n     *\n     * @param dto 更新\n     * @return\n     */\n    @PutMapping(\"/update\")\n    public HttpResult update(@RequestBody @Validated(Update.class) {{.TableNameToTitle}}DTO dto) {\n        return HttpResult.isOk( {{.TableNameToAttrName}}Service.updateById(dto) > 0);\n    }\n\n    /**\n     * 主键删除\n     *\n     * @param id 主键\n     * @return\n     */\n    @DeleteMapping(\"/delete/{id}\")\n    public HttpResult deleteById(@PathVariable(\"id\") Serializable id) {\n        return HttpResult.isOk({{.TableNameToAttrName}}Service.deleteById(id) > 0);\n    }\n\n    /**\n     * 查询列表\n     *\n     * @param query 条件和分页\n     * @return\n     */\n    @PostMapping(\"/page\")\n    public HttpResult<PageResult<{{.TableNameToTitle}}VO>> queryPage(@RequestBody {{.TableNameToTitle}}QueryDTO query) {\n        return HttpResult.ok({{.TableNameToAttrName}}Service.queryPage(query));\n    }\n\n    /**\n     * 分页下拉选择数据\n     *\n     * @param query 查询条件\n     * @return\n     */\n    @PostMapping(\"/list\")\n    public HttpResult<PageResult<SelectVO>> queryList(@RequestBody SelectQueryDTO query) {\n        return HttpResult.ok({{.TableNameToAttrName}}Service.queryList(query));\n    }\n}\n', 'controller', '2', '', '2', 'HeyUI');
INSERT INTO `si_templates` VALUES ('1610834277069492224', '1', 'DTO.java', 'import lombok.Data;\n\nimport javax.validation.constraints.NotBlank;\nimport javax.validation.constraints.NotNull;\nimport javax.validation.constraints.Null;\nimport javax.validation.constraints.Size;\nimport java.time.LocalDateTime;\nimport java.util.Date;\nimport paas.web.validation.Insert;\nimport paas.web.validation.Update;\n/**\n * {{.TableCnName}}-请求\n *\n * @author {{.Author}}\n */\n@ApiModel(\"{{.TableCnName}}-请求数据\")\n@Data\n@Builder\n@AllArgsConstructor\n@NoArgsConstructor\n@EqualsAndHashCode(callSuper = false)\npublic class {{.TableNameToTitle}}DTO extends BaseDTO implements Serializable {\n{{range .TableDetail}}\n    {{if ne (or .EnName \"id\"  \"create_time\" \"modify_time\" \"create_by\" \"modify_by\" \"create_by_name\" \"modify_by_name\") true}}\n    @ApiModelProperty(value = \"{{.CnName}}\" {{if .IsNull}}, required = true{{- end}}){{if .IsNull}}@NotNull(groups = {Insert.class, Update.class}, message = \"{{.CnName}}不能为空\"){{- end}} {{if .DataSize}}@Size(max = {{.DataSize}},message = \"{{.CnName}}不能超过{{.DataSize}}个字符\"){{- end}} {{if eq .EnNameToCode $.TableIdToCodeName}}@JsonFormat(shape = JsonFormat.Shape.STRING){{- end}}\n    private {{.DataTypeToCode}} {{.EnNameToCode}};\n    {{- end}}\n{{end}}\n}\n', 'dto', '2', '', '1', 'HeyUI');
INSERT INTO `si_templates` VALUES ('1610837922255212544', '1', 'Facade.java', '\nimport io.swagger.annotations.ApiOperation;\nimport org.springframework.cloud.openfeign.FeignClient;\nimport org.springframework.validation.annotation.Validated;\nimport org.springframework.web.bind.annotation.*;\nimport paas.model.web.HttpResult;\nimport paas.web.validation.Insert;\nimport paas.web.validation.Update;\nimport java.io.Serializable;\n\n@FeignClient(name = \"服务名\", contextId = \"{{.TableNameToTitle}}Facade\", path = \"/{{.TableNameToUrlPath}}\", fallback = {{.TableNameToTitle}}FacadeFallback.class)\npublic interface {{.TableNameToTitle}}Facade {\n\n    @ApiOperation(\"查询详情\")\n    @GetMapping(\"/{id}\")\n    HttpResult<{{.TableNameToTitle}}VO> get(@PathVariable(\"id\") Serializable id);\n\n    @ApiOperation(\"新增\")\n    @PostMapping(\"/add\")\n    HttpResult add(@RequestBody @Validated(Insert.class) {{.TableNameToTitle}}DTO dto);\n\n    @ApiOperation(\"更新\")\n    @PutMapping(\"/update\")\n    HttpResult update(@RequestBody @Validated(Update.class) {{.TableNameToTitle}}DTO dto);\n\n    @ApiOperation(\"删除\")\n    @DeleteMapping(\"/delete/{id}\")\n    HttpResult deleteById(@PathVariable(\"id\") Serializable id);\n}\n', 'feign', '2', '', '2', 'HeyUI');
INSERT INTO `si_templates` VALUES ('1610837956547842048', '1', 'FacadeFallback.java', '\nimport lombok.extern.slf4j.Slf4j;\nimport org.springframework.stereotype.Component;\nimport paas.model.web.HttpResult;\nimport com.wisesoft.scm.finance.common.enums.ResultMessage;\n\nimport java.io.Serializable;\n\n@Slf4j\n@Component\npublic class {{.TableNameToTitle}}FacadeFallback implements {{.TableNameToTitle}}Facade {\n\n    @Override\n    public HttpResult<{{.TableNameToTitle}}VO> get(Serializable id) {\n        return HttpResult.fail(ResultMessage.NET_FAILURE);\n    }\n\n    @Override\n    public HttpResult add({{.TableNameToTitle}}DTO dto) {\n        return HttpResult.fail(ResultMessage.NET_FAILURE);\n    }\n\n    @Override\n    public HttpResult update({{.TableNameToTitle}}DTO dto) {\n        return HttpResult.fail(ResultMessage.NET_FAILURE);\n    }\n\n    @Override\n    public HttpResult deleteById(Serializable id) {\n        return HttpResult.fail(ResultMessage.NET_FAILURE);\n    }\n}\n', 'feign/fallback', '2', '', '2', 'HeyUI');
INSERT INTO `si_templates` VALUES ('1610838237599764480', '1', 'QueryDTO.java', 'import java.time.LocalDateTime;\nimport java.util.Date;\n/**\n * {{.TableCnName}}-查询\n *\n * @author {{.Author}}\n */\n@ApiModel(\"{{.TableCnName}}-查询数据\")\n@Data\n@Builder\n@AllArgsConstructor\n@NoArgsConstructor\n@EqualsAndHashCode(callSuper = false)\npublic class {{.TableNameToTitle}}QueryDTO extends BaseQueryDTO  implements Serializable {\n{{range .TableDetail}}\n    {{if ne (or .EnName \"id\"  \"create_time\" \"modify_time\" \"create_by\" \"modify_by\" \"create_by_name\" \"modify_by_name\") true}}\n    @ApiModelProperty(\"{{.CnName}}\") {{if eq .EnNameToCode $.TableIdToCodeName}}@JsonFormat(shape = JsonFormat.Shape.STRING){{end}} {{if eq .DataTypeToCode \"Date\" }}@JsonFormat(pattern = \"yyyy-MM-dd HH:mm:ss\", timezone = \"GMT+8\"){{end}}\n    private {{.DataTypeToCode}} {{.EnNameToCode}};\n    {{- end}}\n{{- end -}}\n}\n', 'dto/query', '2', '', '1', 'HeyUI');
INSERT INTO `si_templates` VALUES ('1610838530211188736', '1', 'VO.java', 'import lombok.Data;\nimport java.time.LocalDateTime;\nimport java.util.Date;\n/**\n * {{.TableCnName}}-VO\n *\n * @author {{.Author}}\n */\n@Data\n@Builder\n@AllArgsConstructor\n@NoArgsConstructor\n@EqualsAndHashCode(callSuper = false)\npublic class {{.TableNameToTitle}}VO  extends BaseVO implements Serializable {\n{{range .TableDetail}}\n    {{if ne (or .EnName \"id\"  \"create_time\" \"modify_time\" \"create_by\" \"modify_by\" \"create_by_name\" \"modify_by_name\") true}}\n    /**{{.CnName}}*/{{if eq .EnNameToCode $.TableIdToCodeName}}@JsonFormat(shape = JsonFormat.Shape.STRING){{- end}}\n    private {{.DataTypeToCode}} {{.EnNameToCode}};\n    {{- end}}\n{{- end}}\n}\n', 'vo', '2', '', '2', 'HeyUI');
INSERT INTO `si_templates` VALUES ('1610838587685736448', '1', 'Excel.java', 'import lombok.Data;\nimport lombok.experimental.Accessors;\nimport java.time.LocalDateTime;\nimport java.io.Serializable;\nimport java.util.Date;\n\n/**\n * {{.TableCnName}}-报表\n *\n * @author {{.Author}}\n */\n@Data\n@Accessors(chain = true)\npublic class {{.TableNameToTitle}}Excel implements Serializable {\n{{range .TableDetail}}\n    @ExcelProperty(value = \"{{.CnName}}\")\n    private {{.DataTypeToCode}} {{.EnNameToCode}};\n{{end}}\n}\n', 'excel', '2', '', '2', 'HeyUI');
INSERT INTO `si_templates` VALUES ('1610838624515919872', '1', 'ControllerTests.java', 'import com.alibaba.fastjson.JSONObject;\nimport lombok.extern.slf4j.Slf4j;\nimport org.junit.jupiter.api.Test;\nimport yq.cloud.utils.OkHttpUtil;\n\n@Slf4j\npublic class {{.TableNameToTitle}}ControllerTests {\n    private String modelPath = \"{{.TableNameToUrlPath}}\";\n\n\n    @Test\n    public void page() {\n        String url = BaseTests.url + modelPath + \"/page\";\n        log.info(\"列表->: {}\", url);\n        {{.TableNameToTitle}}QueryDTO query = new {{.TableNameToTitle}}QueryDTO();\n        query.setCurrent(0);\n        query.setSize(10);\n         String data = JSONObject.toJSONString(query);\n        log.info(\"请求数据：{}\", data);\n        String result = OkHttpUtil.sendPost(url, data);\n        log.info(\"<-响应结果:\\n {}\", result);\n    }\n\n\n    @Test\n    public void get() {\n        String url = BaseTests.url + modelPath + \"/:id\";\n        log.info(\"查询->: {}\", url);\n        String result = OkHttpUtil.sendGet(url);\n        log.info(\"<-响应结果: {}\", result);\n    }\n\n    @Test\n    public void post() {\n        String url = BaseTests.url + modelPath + \"/add\";\n        log.info(\"新增->: {}\", url);\n        {{.TableNameToTitle}}DTO dto = new {{.TableNameToTitle}}DTO();\n        String data = JSONObject.toJSONString(dto);\n        log.info(\"请求数据：{}\", data);\n        String result = OkHttpUtil.sendPost(url, JSONObject.toJSONString(dto));\n        log.info(\"<-新增响应结果:\\n {}\", result);\n    }\n\n    @Test\n    public void update() {\n        String url = BaseTests.url + modelPath + \"/update\";\n        log.info(\"更新->: {}\", url);\n        {{.TableNameToTitle}}DTO dto = new {{.TableNameToTitle}}DTO();\n\n        String data = JSONObject.toJSONString(dto);\n        log.info(\"请求数据：{}\", data);\n        String result = OkHttpUtil.sendPut(url, data);\n        log.info(\"<-更新响应结果:\\n {}\", result);\n    }\n\n    @Test\n    public void delete() {\n        String url = BaseTests.url + modelPath + \"/delete/\" + \":id\";\n        log.info(\"删除->: {}\", url);\n        String result = OkHttpUtil.sendDelete(url);\n        log.info(\"<-响应结果:\\n {}\", result);\n    }\n}\n', 'tests', '2', '', '2', 'HeyUI');
INSERT INTO `si_templates` VALUES ('1610838701309431808', '1', '.java', 'import com.baomidou.mybatisplus.annotation.TableName;\n\nimport lombok.Data;\nimport java.io.Serializable;\nimport lombok.EqualsAndHashCode;\nimport java.time.LocalDateTime;\nimport java.util.Date;\n/**\n * {{.TableCnName}}\n *\n * @author {{.Author}}\n */\n@Data\n@TableName(value = \"{{.TableName}}\")\n@EqualsAndHashCode(callSuper = true)\npublic class {{.TableNameToTitle}} extends BaseEntity implements Serializable {\n{{range .TableDetail}}\n    {{if ne (or .EnName \"id\"  \"create_time\" \"modify_time\" \"create_by\" \"modify_by\") true}}\n     /**\n     * {{.CnName}}\n     */\n    private {{.DataTypeToCode}} {{.EnNameToCode}};\n    {{- end}}\n{{- end}}\n   \n    public static class DB {\n        {{range .TableDetail}}\n            public static final String {{.EnNameToCode}} = \"{{.EnName}}\";\n        {{- end}}\n    }\n}\n', 'entity', '2', '', '1', 'HeyUI');
INSERT INTO `si_templates` VALUES ('1610838769030664192', '1', 'Mapper.java', 'import com.baomidou.mybatisplus.core.metadata.IPage;\nimport org.apache.ibatis.annotations.Mapper;\nimport org.apache.ibatis.annotations.Param;\n\nimport java.util.List;\n\n/**\n * {{.TableCnName}}\n *\n * @author {{.Author}}\n **/\n@Mapper\npublic interface {{.TableNameToTitle}}Mapper extends RootMapper<{{.TableNameToTitle}}> {\n\n    /**\n     * 分页查询\n     *\n     * @param page 分页参数\n     * @return 查询结果\n     */\n    List<{{.TableNameToTitle}}> queryPage(@Param(\"page\") IPage<{{.TableNameToTitle}}> page, @Param(\"query\") {{.TableNameToTitle}}QueryDTO query);\n\n    /**\n     * 分页下拉选择数据\n     *\n     * @param query 查询条件\n     * @return\n     */\n    List<SelectVO> queryList(@Param(\"page\") IPage<SelectVO> page, @Param(\"query\") SelectQueryDTO query);\n}\n', 'mapper', '2', '', '2', 'HeyUI');
INSERT INTO `si_templates` VALUES ('1610838801746235392', '1', 'Mapper.xml', '<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<!DOCTYPE mapper PUBLIC \"-//mybatis.org//DTD Mapper 3.0//EN\" \"http://mybatis.org/dtd/mybatis-3-mapper.dtd\">\n<mapper namespace=\"mapper.{{.TableNameToTitle}}Mapper\">\n    <sql id=\"base_column_list\">\n        {{$size := len .TableDetail -}}\n        {{range $i,$v := .TableDetail}}{{$v.EnName}}{{if ne (inc $i 1) $size}}, {{end}}{{end}}\n    </sql>\n    <!-- 分页查询多条数据 -->\n    <select id=\"queryPage\" resultType=\"db.{{.TableNameToTitle}}\">\n        select \n        <include refid=\"base_column_list\"></include>\n        from {{.TableName}} a\n        <where>\n\n{{range .TableDetail}}\n        {{if ne (or .EnName  \"create_time\" \"modify_time\"  \"create_by_name\" \"modify_by_name\") true}}<if test=\"query.{{.EnNameToCode}} != null and query.{{.EnNameToCode}} != \'\' \">and a.{{.EnName}}= #{query.{{.EnNameToCode}}}</if>{{- end}}\n{{- end}}\n          <if test=\"query.startDate != null\">\n                to_date(to_char(CREATE_TIME,\'yyyy-mm-dd\'),\'yyyy-mm-dd\')\n                between #{query.startDate} AND #{query.endDate}\n          </if>\n        </where>\n        ${query.page.orderBy}\n    </select>\n\n <!-- 分页下拉选择数据 -->\n    <select id=\"queryList\" resultType=\"paas.model.vo.SelectVO\">\n        select {{.TableId}} as value,{{.TableAutoName}} as label from {{.TableName}} a\n        <where>\n            <if test=\"query.value != null\">and a.{{.TableId}} = #{query.value}</if>\n            <if test=\"query.label != null\">and a.{{.TableAutoName}} like CONCAT(\'%\',#{query.label},\'%\') </if>\n        </where>\n        ${query.page.orderBy}\n    </select>\n\n    <!-- 批量插入 -->\n    <insert id=\"batchAdd\">\n        INSERT INTO {{.TableName}} (\n            <include refid=\"base_column_list\"></include>\n        ) VALUES\n        <foreach collection=\"list\" item=\"item\" separator=\",\">\n        (\n            {{range $i,$v := .TableDetail}}#{item.{{$v.EnNameToCode}}}{{if ne (inc $i 1) $size}}, {{end}}{{- end}}\n        )\n        </foreach>\n    </insert>\n</mapper>\n\n', 'mapper_xml', '2', '', '2', 'HeyUI');
INSERT INTO `si_templates` VALUES ('1610838844272283648', '1', 'Service.java', 'import java.io.Serializable;\nimport java.util.List;\nimport paas.model.pagination.PageResult;\n\n/**\n * {{.TableCnName}}\n *\n * @author {{.Author}}\n **/\npublic interface {{.TableNameToTitle}}Service  {\n\n    /**\n     * 查询详情\n     *\n     * @param id 主键\n     * @return 实体对象\n     */\n    {{.TableNameToTitle}}VO selectById(Serializable id);\n\n    /**\n     * 增加\n     *\n     * @param dto 请求参数\n     * @return 响应码和响应消息\n     */\n    int save({{.TableNameToTitle}}DTO dto);\n\n    /**\n     * 修改\n     *\n     * @param dto 请求参数\n     * @return 响应码和响应消息\n     */\n    int updateById({{.TableNameToTitle}}DTO dto);\n\n    /**\n     * 删除\n     *\n     * @param id 主键\n     * @return 响应码和响应消息\n     */\n    int deleteById(Serializable id);\n\n    /**\n     * 列表查询\n     *\n     * @param query 请求参数\n     * @return 列表数据集合\n     */\n    PageResult<{{.TableNameToTitle}}VO> queryPage({{.TableNameToTitle}}QueryDTO query);\n\n    /**\n     * 分页下拉数据\n     *\n     * @param query\n     * @return\n     */\n    PageResult<SelectVO> queryList(SelectQueryDTO query);\n\n    /**\n     * 批量插入操作\n     *\n     * @param data\n     * @return\n     */\n    HttpResult batchAdd(List<{{.TableNameToTitle}}> data);\n}\n', 'service', '2', '', '2', 'HeyUI');
INSERT INTO `si_templates` VALUES ('1610838879605100544', '1', 'ServiceImpl.java', 'import com.baomidou.mybatisplus.core.metadata.IPage;\n\nimport org.springframework.stereotype.Service;\nimport org.springframework.transaction.annotation.Transactional;\n\nimport org.springframework.beans.factory.annotation.Autowired;\nimport java.io.Serializable;\nimport java.util.List;\nimport paas.model.pagination.PageResult;\n\n/**\n * {{.TableCnName}}\n *\n * @author {{.Author}}\n **/\n@Slf4j\n@Service\npublic class {{.TableNameToTitle}}ServiceImpl implements {{.TableNameToTitle}}Service {\n\n    @Autowired\n    {{.TableNameToTitle}}Mapper {{.TableNameToAttrName}}Mapper;\n\n    /**\n     * 查询\n     *\n     * @param id 主键\n     * @return 实体对象\n     */\n    @Override\n    public {{.TableNameToTitle}}VO selectById(Serializable id) {\n        {{.TableNameToTitle}}VO result = PaasUtils.copy({{.TableNameToAttrName}}Mapper.selectById(id), {{.TableNameToTitle}}VO::new);\n        return result;\n    }\n\n    /**\n     * 增加\n     *\n     * @param dto 请求参数\n     * @return 插入条数\n     */\n    @Override\n    public int save({{.TableNameToTitle}}DTO dto) {\n          {{.TableNameToTitle}} entity = PaasUtils.copy(dto, {{.TableNameToTitle}}::new);\n        return {{.TableNameToAttrName}}Mapper.insert(entity);\n    }\n\n    /**\n     * 修改\n     *\n     * @param dto 请求参数\n     * @return 更新条数\n     */\n    @Override\n    public int updateById({{.TableNameToTitle}}DTO dto) {\n        {{.TableNameToTitle}} entity = {{.TableNameToAttrName}}Mapper.selectById(dto.getId());\n        Asserts.isTrueError(entity == null, ResultMessage.NOT_FOUND);\n        PaasUtils.copyIgnoreNull(dto, entity);\n        return {{.TableNameToAttrName}}Mapper.updateById(entity);\n    }\n\n    /**\n     * 删除\n     *\n     * @param id 主键\n     * @return 删除条数\n     */\n    @Override\n    public int deleteById(Serializable id) {\n        return {{.TableNameToAttrName}}Mapper.deleteById(id);\n    }\n\n    /**\n     * 列表查询\n     *\n     * @param query 请求参数\n     * @return 列表数据集合\n     */\n    @Override\n    public PageResult<{{.TableNameToTitle}}VO> queryPage({{.TableNameToTitle}}QueryDTO query) {\n        IPage<{{.TableNameToTitle}}> page = MybatisHandler.convert(query.getPage());\n        List<{{.TableNameToTitle}}> data = {{.TableNameToAttrName}}Mapper.queryPage(page, query);\n        List<{{.TableNameToTitle}}VO> result = PaasUtils.copyListTo(data, {{.TableNameToTitle}}VO::new);\n        return MybatisHandler.convert(page, result);\n    }\n\n    /**\n     * 分页下拉选择数据\n     *\n     * @param query 查询条件\n     * @return\n     */\n    @Override\n    public PageResult<SelectVO> queryList(SelectQueryDTO query) {\n        IPage<SelectVO> page = MybatisHandler.convert(query.getPage());\n        List<SelectVO> data = {{.TableNameToAttrName}}Mapper.queryList(page, query);\n        List<SelectVO> result = PaasUtils.copyListTo(data, SelectVO::new);\n        return MybatisHandler.convert(page, result);\n    }\n\n    /**\n     * 批量插入数据\n     *\n     * @param data\n     * @return\n     */\n    @Override\n    @Transactional\n    public HttpResult batchAdd(List<{{.TableNameToTitle}}> data) {\n        List<List<{{.TableNameToTitle}}>> items = PaasUtils.splitList(data, PaasUtils.BATCH_ADD_SIZE);\n        for (List<{{.TableNameToTitle}}> item : items) {\n            {{.TableNameToAttrName}}Mapper.batchAdd(item);\n        }\n        return HttpResult.ok();\n    }\n}\n', 'service/impl', '2', '', '2', 'HeyUI');
INSERT INTO `si_templates` VALUES ('2', '1', '.java', 'import com.baomidou.mybatisplus.annotation.TableName;\n\nimport lombok.Data;\nimport java.io.Serializable;\nimport lombok.EqualsAndHashCode;\nimport java.time.LocalDateTime;\nimport java.util.Date;\n/**\n * {{.TableCnName}}\n *\n * @author {{.Author}}\n */\n@Data\n@TableName(value = \"{{.TableName}}\")\n@EqualsAndHashCode(callSuper = true)\npublic class {{.TableNameToTitle}} extends BaseEntity implements Serializable {\n{{range .TableDetail}}\n    {{if ne (or .EnName \"id\"  \"create_time\" \"modify_time\" \"create_by\" \"modify_by\") true}}\n     /**\n     * {{.CnName}}\n     */\n    private {{.DataTypeToCode}} {{.EnNameToCode}};\n    {{- end}}\n{{- end}}\n   \n    public static class DB {\n        {{range .TableDetail}}\n            public static final String {{.EnNameToCode}} = \"{{.EnName}}\";\n        {{- end}}\n    }\n}\n', 'entity', '2', '', '2', 'HeyUI');
INSERT INTO `si_templates` VALUES ('3', '1', 'Mapper.java', 'import com.baomidou.mybatisplus.core.metadata.IPage;\nimport org.apache.ibatis.annotations.Mapper;\nimport org.apache.ibatis.annotations.Param;\n\nimport java.util.List;\n\n/**\n * {{.TableCnName}}\n *\n * @author {{.Author}}\n **/\n@Mapper\npublic interface {{.TableNameToTitle}}Mapper extends RootMapper<{{.TableNameToTitle}}> {\n\n    /**\n     * 分页查询\n     *\n     * @param page 分页参数\n     * @return 查询结果\n     */\n    List<{{.TableNameToTitle}}> queryPage(@Param(\"page\") IPage<{{.TableNameToTitle}}> page, @Param(\"query\") {{.TableNameToTitle}}QueryDTO query);\n\n    /**\n     * 分页下拉选择数据\n     *\n     * @param query 查询条件\n     * @return\n     */\n    List<SelectVO> queryList(@Param(\"page\") IPage<SelectVO> page, @Param(\"query\") SelectQueryDTO query);\n}\n', 'mapper', '2', '', '1', 'HeyUI');
INSERT INTO `si_templates` VALUES ('4', '1', 'Mapper.xml', '<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<!DOCTYPE mapper PUBLIC \"-//mybatis.org//DTD Mapper 3.0//EN\" \"http://mybatis.org/dtd/mybatis-3-mapper.dtd\">\n<mapper namespace=\"mapper.{{.TableNameToTitle}}Mapper\">\n    <sql id=\"base_column_list\">\n        {{$size := len .TableDetail -}}\n        {{range $i,$v := .TableDetail}}{{$v.EnName}}{{if ne (inc $i 1) $size}}, {{end}}{{end}}\n    </sql>\n    <!-- 分页查询多条数据 -->\n    <select id=\"queryPage\" resultType=\"db.{{.TableNameToTitle}}\">\n        select \n        <include refid=\"base_column_list\"></include>\n        from {{.TableName}} a\n        <where>\n\n{{range .TableDetail}}\n        {{if ne (or .EnName  \"create_time\" \"modify_time\"  \"create_by_name\" \"modify_by_name\") true}}<if test=\"query.{{.EnNameToCode}} != null and query.{{.EnNameToCode}} != \'\' \">and a.{{.EnName}}= #{query.{{.EnNameToCode}}}</if>{{- end}}\n{{- end}}\n          <if test=\"query.startDate != null\">\n                to_date(to_char(CREATE_TIME,\'yyyy-mm-dd\'),\'yyyy-mm-dd\')\n                between #{query.startDate} AND #{query.endDate}\n          </if>\n        </where>\n        ${query.page.orderBy}\n    </select>\n\n <!-- 分页下拉选择数据 -->\n    <select id=\"queryList\" resultType=\"paas.model.vo.SelectVO\">\n        select {{.TableId}} as value,{{.TableAutoName}} as label from {{.TableName}} a\n        <where>\n            <if test=\"query.value != null\">and a.{{.TableId}} = #{query.value}</if>\n            <if test=\"query.label != null\">and a.{{.TableAutoName}} like CONCAT(\'%\',#{query.label},\'%\') </if>\n        </where>\n        ${query.page.orderBy}\n    </select>\n\n    <!-- 批量插入 -->\n    <insert id=\"batchAdd\">\n        INSERT INTO {{.TableName}} (\n            <include refid=\"base_column_list\"></include>\n        ) VALUES\n        <foreach collection=\"list\" item=\"item\" separator=\",\">\n        (\n            {{range $i,$v := .TableDetail}}#{item.{{$v.EnNameToCode}}}{{if ne (inc $i 1) $size}}, {{end}}{{- end}}\n        )\n        </foreach>\n    </insert>\n</mapper>\n\n', 'mapper_xml', '2', '', '1', 'HeyUI');
INSERT INTO `si_templates` VALUES ('5', '1', 'Service.java', 'import java.io.Serializable;\nimport java.util.List;\nimport paas.model.pagination.PageResult;\n\n/**\n * {{.TableCnName}}\n *\n * @author {{.Author}}\n **/\npublic interface {{.TableNameToTitle}}Service  {\n\n    /**\n     * 查询详情\n     *\n     * @param id 主键\n     * @return 实体对象\n     */\n    {{.TableNameToTitle}}VO selectById(Serializable id);\n\n    /**\n     * 增加\n     *\n     * @param dto 请求参数\n     * @return 响应码和响应消息\n     */\n    int save({{.TableNameToTitle}}DTO dto);\n\n    /**\n     * 修改\n     *\n     * @param dto 请求参数\n     * @return 响应码和响应消息\n     */\n    int updateById({{.TableNameToTitle}}DTO dto);\n\n    /**\n     * 删除\n     *\n     * @param id 主键\n     * @return 响应码和响应消息\n     */\n    int deleteById(Serializable id);\n\n    /**\n     * 列表查询\n     *\n     * @param query 请求参数\n     * @return 列表数据集合\n     */\n    PageResult<{{.TableNameToTitle}}VO> queryPage({{.TableNameToTitle}}QueryDTO query);\n\n    /**\n     * 分页下拉数据\n     *\n     * @param query\n     * @return\n     */\n    PageResult<SelectVO> queryList(SelectQueryDTO query);\n\n    /**\n     * 批量插入操作\n     *\n     * @param data\n     * @return\n     */\n    HttpResult batchAdd(List<{{.TableNameToTitle}}> data);\n}\n', 'service', '2', '', '1', 'HeyUI');
INSERT INTO `si_templates` VALUES ('6', '1', 'ServiceImpl.java', 'import com.baomidou.mybatisplus.core.metadata.IPage;\n\nimport org.springframework.stereotype.Service;\nimport org.springframework.transaction.annotation.Transactional;\n\nimport org.springframework.beans.factory.annotation.Autowired;\nimport java.io.Serializable;\nimport java.util.List;\nimport paas.model.pagination.PageResult;\n\n/**\n * {{.TableCnName}}\n *\n * @author {{.Author}}\n **/\n@Slf4j\n@Service\npublic class {{.TableNameToTitle}}ServiceImpl implements {{.TableNameToTitle}}Service {\n\n    @Autowired\n    {{.TableNameToTitle}}Mapper {{.TableNameToAttrName}}Mapper;\n\n    /**\n     * 查询\n     *\n     * @param id 主键\n     * @return 实体对象\n     */\n    @Override\n    public {{.TableNameToTitle}}VO selectById(Serializable id) {\n        {{.TableNameToTitle}}VO result = PaasUtils.copy({{.TableNameToAttrName}}Mapper.selectById(id), {{.TableNameToTitle}}VO::new);\n        return result;\n    }\n\n    /**\n     * 增加\n     *\n     * @param dto 请求参数\n     * @return 插入条数\n     */\n    @Override\n    public int save({{.TableNameToTitle}}DTO dto) {\n          {{.TableNameToTitle}} entity = PaasUtils.copy(dto, {{.TableNameToTitle}}::new);\n        return {{.TableNameToAttrName}}Mapper.insert(entity);\n    }\n\n    /**\n     * 修改\n     *\n     * @param dto 请求参数\n     * @return 更新条数\n     */\n    @Override\n    public int updateById({{.TableNameToTitle}}DTO dto) {\n        {{.TableNameToTitle}} entity = {{.TableNameToAttrName}}Mapper.selectById(dto.getId());\n        Asserts.isTrueError(entity == null, ResultMessage.NOT_FOUND);\n        PaasUtils.copyIgnoreNull(dto, entity);\n        return {{.TableNameToAttrName}}Mapper.updateById(entity);\n    }\n\n    /**\n     * 删除\n     *\n     * @param id 主键\n     * @return 删除条数\n     */\n    @Override\n    public int deleteById(Serializable id) {\n        return {{.TableNameToAttrName}}Mapper.deleteById(id);\n    }\n\n    /**\n     * 列表查询\n     *\n     * @param query 请求参数\n     * @return 列表数据集合\n     */\n    @Override\n    public PageResult<{{.TableNameToTitle}}VO> queryPage({{.TableNameToTitle}}QueryDTO query) {\n        IPage<{{.TableNameToTitle}}> page = MybatisHandler.convert(query.getPage());\n        List<{{.TableNameToTitle}}> data = {{.TableNameToAttrName}}Mapper.queryPage(page, query);\n        List<{{.TableNameToTitle}}VO> result = PaasUtils.copyListTo(data, {{.TableNameToTitle}}VO::new);\n        return MybatisHandler.convert(page, result);\n    }\n\n    /**\n     * 分页下拉选择数据\n     *\n     * @param query 查询条件\n     * @return\n     */\n    @Override\n    public PageResult<SelectVO> queryList(SelectQueryDTO query) {\n        IPage<SelectVO> page = MybatisHandler.convert(query.getPage());\n        List<SelectVO> data = {{.TableNameToAttrName}}Mapper.queryList(page, query);\n        List<SelectVO> result = PaasUtils.copyListTo(data, SelectVO::new);\n        return MybatisHandler.convert(page, result);\n    }\n\n    /**\n     * 批量插入数据\n     *\n     * @param data\n     * @return\n     */\n    @Override\n    @Transactional\n    public HttpResult batchAdd(List<{{.TableNameToTitle}}> data) {\n        List<List<{{.TableNameToTitle}}>> items = PaasUtils.splitList(data, PaasUtils.BATCH_ADD_SIZE);\n        for (List<{{.TableNameToTitle}}> item : items) {\n            {{.TableNameToAttrName}}Mapper.batchAdd(item);\n        }\n        return HttpResult.ok();\n    }\n}\n', 'service/impl', '2', '', '1', 'HeyUI');
INSERT INTO `si_templates` VALUES ('7', '2', '/model.go', 'type TableNameToTitle struct {\n{{range .TableDetail}}\n	{{ToTitle .EnName}} String `json:\"{{.EnNameToCode}}\" db:\"{{.EnNameToCode}}\"` //{{.CnName}}\n{{end}}\n}\n', 'go/model', '2', '', '1', 'HeyUI');
INSERT INTO `si_templates` VALUES ('8', '2', 'Controller.go', 'package controller\n\nimport (\n        \"@_package/middleware\"\n	\"fmt\"\n	\"net/http\"\n	\"@_package/model\"\n	\"@_package/sqlbuilder\"\n	\"@_package/utils\"\n	\"@_package/vo\"\n\n	\"github.com/gin-gonic/gin\"\n)\n\ntype @_ObjectNameController struct {\n	cols  []string\n	table string\n}\n\nfunc (m *@_ObjectNameController) initData() {\n	m.table = \"@_TableName\"\n	m.cols = []string{ \n@_for\n            \"@_fieldName\", \n@_end\n\n         }\n}\n\n//@_modelName\nfunc New@_ObjectNameController(router *gin.RouterGroup) {\n	m := new(@_ObjectNameController)\n	m.initData()\n\n	group := router.Group(\"/@_path\")\n	group.GET(\"/:id\", m.Get)             //查询\n	group.POST(\"\", m.Post)               //增加\n	group.PUT(\"/edit\", m.Put)            //修改\n	group.DELETE(\"/:id\", m.Delete)       //删除\n	group.PUT(\"\", m.QueryTables)         //查询列表\n	group.POST(\"/select\", m.QuerySelect) //查询下拉\n}\n\n//查询\nfunc (m *@_ObjectNameController) Get(c *gin.Context) {\n	id := c.Param(\"id\")\n	data := new(model.@_ObjectName)\n\n	builder := sqlbuilder.NewSelect()\n	builder.Select(m.cols...).From(m.table)\n	builder.Where([]string{\"and @_id = ?\"}, id)\n\n	sql, args := builder.ToSql()\n	err := db.Get(data, sql, args...)\n\n	if utils.IsError(err) {\n		utils.Fail(c, \"获取对象失败!\")\n		return\n	}\n	c.JSON(http.StatusOK, data)\n}\n\n//增加\nfunc (m *@_ObjectNameController) Post(c *gin.Context) {\n	in := new(model.@_ObjectName)\n	if !utils.Bind(c, in) {\n		return\n	}\n	in.@_Id.SetValid(middleware.Generate())\n\n	builder := sqlbuilder.NewInsert(m.table)\n	builder.Cols(m.cols...)\n	builder.Values(\n@_for\nin.@_FieldName_M,\n@_end\n)\n	sql, args := builder.ToSql()\n	_, err := db.Exec(sql, args...)\n	if utils.IsError(err) {\n		utils.Fail(c, \"插入数据失败\")\n		return\n	}\n	utils.Success(c)\n}\n\n//修改\nfunc (m *@_ObjectNameController) Put(c *gin.Context) {\n	in := new(model.@_ObjectName)\n	if !utils.Bind(c, in) {\n		return\n	}\n	if in.@_Id.String == \"\" {\n		utils.Fail(c, \"主键不能为空\")\n		return\n	}\n	builder := sqlbuilder.NewUpdate(m.table)\n	builder.Cols(m.cols...)\n	builder.Set(\n@_for\nin.@_FieldName_M,\n@_end\n)\n	builder.Where(\"@_id = ?\", in.@_Id)\n	sql, args := builder.ToSql()\n	_, err := db.Exec(sql, args...)\n	if utils.IsError(err) {\n		utils.Fail(c, \"更新数据失败\")\n		return\n	}\n	utils.Success(c)\n}\n\n//删除\nfunc (m *@_ObjectNameController) Delete(c *gin.Context) {\n	id := c.Param(\"id\")\n	if id == \"\" {\n		c.JSON(http.StatusOK, vo.Result{Code: \"0001\", Msg: \"主键不能为空！\"})\n		return\n	}\n\n	sql := fmt.Sprintf(\"delete from %s where @_id = ?\", m.table)\n	_, err := db.Exec(sql, id)\n	if utils.IsError(err) {\n		utils.Fail(c, \"删除数据失败!\")\n		return\n	}\n	utils.Success(c)\n}\n\n//查询列表\nfunc (m *@_ObjectNameController) QueryTables(c *gin.Context) {\n	in := new(struct {\n		Page      vo.PageInfo    `json:\"page\"`\n		QueryData model.@_ObjectName `json:\"queryData\"`\n	})\n	if !utils.Bind(c, in) {\n		return\n	}\n	\n	data := make([]model.@_ObjectName, 0)\n        q := in.QueryData\n	builder := sqlbuilder.NewSelect()\n	builder.Select(m.cols...).From(m.table)\nbuilder.Where([]string{\n@_for\n\"and @_enName = ?\",\\n\n@_end\n},\n@_for\nq.@_FieldName_M,\n@_end\n)\n\n	sql, values := builder.ToSql()\n	result := db.QueryTables(&data, sql, values, in.Page)\n	c.JSON(http.StatusOK, result)\n}\n\n//分页下拉\nfunc (m *@_ObjectNameController) QuerySelect(c *gin.Context) {\n	in := new(vo.SelectRequest)\n	if !utils.Bind(c, in) {\n		return\n	}\n	q := in.QueryData\n	builder := sqlbuilder.NewSelect()\n	builder.Select(\"@_id as key_id\", \"@_dbName as title\")\n	builder.From(m.table).Add(\"and @_id is not null\")\n	builder.Where([]string{\n		builder.Like(\"and CONCAT(@_id,@_dbName)\"),\n		sqlbuilder.In(\"or @_id\", q.Selected)}, q.Filter, q.Selected)\n\n	sql, values := builder.ToSql()\n	result := db.QuerySelect(sql, values, in.Page)\n	utils.Success(c, result)\n}\n', 'go/controller', '2', '', '1', 'HeyUI');
INSERT INTO `si_templates` VALUES ('9', '3', '/index.vue', '<template>\n  <div class=\"h-panel\">\n    <IndexBar></IndexBar>\n    <PageTable :columns=\"columns\"></PageTable>\n  </div>\n</template>\n\n<script>\nexport default {\n  mounted() {\n  },\n  data() {\n    return {\n	  columns: [\n{{range .TableDetail}}\n              { title: \"{{.CnName}}\", prop: \"{{.EnNameToCode}}\" },\n{{- end}}\n          ],\n    };\n  },\n  methods: {\n  }\n};\n</script>\n', 'heyui', '2', '', '1', 'HeyUI');

-- ----------------------------
-- Table structure for sr_group_member
-- ----------------------------
DROP TABLE IF EXISTS `sr_group_member`;
CREATE TABLE `sr_group_member`  (
  `crt_opr` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建用户',
  `crt_ts` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT '' COMMENT '创建时间',
  `id` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '主键',
  `max_member` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '最大人数',
  `member_ids` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '团队成员',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '团队名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sr_group_member
-- ----------------------------
INSERT INTO `sr_group_member` VALUES ('sirui', '20220420214346', '1516774626896646144', '6', 'sirui', '我的团队');
INSERT INTO `sr_group_member` VALUES ('sirui', '20221125144201', '1596031432721960960', '6', 'sirui,admin,wisesoft,hxx', '智胜集成');
INSERT INTO `sr_group_member` VALUES ('sirui', '20220420213816', '4', '5', 'sirui', '我个人');
INSERT INTO `sr_group_member` VALUES ('qpy', '20210316185457', '5', '', 'qpy', 'test');

-- ----------------------------
-- Table structure for sr_modular
-- ----------------------------
DROP TABLE IF EXISTS `sr_modular`;
CREATE TABLE `sr_modular`  (
  `crt_opr` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建用户',
  `crt_ts` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '创建时间',
  `id` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '主键',
  `modular_id` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '表名称',
  `modular_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '功能名称',
  `project_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '所属项目',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sr_modular
-- ----------------------------
INSERT INTO `sr_modular` VALUES ('sirui', '20210413120532', '1381820825933651969', 'test', '测试', 'testpid');
INSERT INTO `sr_modular` VALUES ('sirui', '20210413120615', '1381821004254490626', 'test', '测试', 'testpid');
INSERT INTO `sr_modular` VALUES ('sirui', '20210413120709', '1381821232734957570', 'test', '测试', 'testpid');
INSERT INTO `sr_modular` VALUES ('sirui', '20210413120709', '1381821241576550402', 'test', '测试', 'testpid');
INSERT INTO `sr_modular` VALUES ('sirui', '20210413120709', '1381821242809675777', 'test', '测试', 'testpid');
INSERT INTO `sr_modular` VALUES ('sirui', '20210413120709', '1381821243719839745', 'test', '测试', 'testpid');
INSERT INTO `sr_modular` VALUES ('sirui', '20210413120709', '1381821244994908162', 'test', '测试', 'testpid');
INSERT INTO `sr_modular` VALUES ('sirui', '20210413120709', '1381821246454525954', 'test', '测试', 'testpid');
INSERT INTO `sr_modular` VALUES ('sirui', '20210413120709', '1381821247536656386', 'test', '测试', 'testpid');
INSERT INTO `sr_modular` VALUES ('sirui', '20210413120709', '1381821248396488706', 'test', '测试', 'testpid');
INSERT INTO `sr_modular` VALUES ('sirui', '20210413120709', '1381821249453453314', 'test', '测试', 'testpid');
INSERT INTO `sr_modular` VALUES ('sirui', '20210413120709', '1381821250145513474', 'test', '测试', 'testpid');
INSERT INTO `sr_modular` VALUES ('sirui', '20210529233200', '1398663420449914880', 'si_templates', '11', '1398663419967569920');
INSERT INTO `sr_modular` VALUES ('sirui', '20210529233200', '1398663420491857920', 'sr_group_member', '', '1398663419967569920');
INSERT INTO `sr_modular` VALUES ('sirui', '20210529233200', '1398663420508635136', 'sr_modular', '', '1398663419967569920');
INSERT INTO `sr_modular` VALUES ('sirui', '20210529233200', '1398663420529606656', 'sr_modulecfg', '', '1398663419967569920');
INSERT INTO `sr_modular` VALUES ('sirui', '20210529233200', '1398663420546383872', 'sr_project', '', '1398663419967569920');
INSERT INTO `sr_modular` VALUES ('sirui', '20210529233200', '1398663420567355392', 'sys_buttons', '', '1398663419967569920');
INSERT INTO `sr_modular` VALUES ('sirui', '20210529233200', '1398663420584132608', 'sys_menus', '', '1398663419967569920');
INSERT INTO `sr_modular` VALUES ('sirui', '20210529233200', '1398663420613492736', 'sys_params', '', '1398663419967569920');
INSERT INTO `sr_modular` VALUES ('sirui', '20210529233200', '1398663420630269952', 'sys_role_menu', '', '1398663419967569920');
INSERT INTO `sr_modular` VALUES ('sirui', '20210529233200', '1398663420647047168', 'sys_roles', '', '1398663419967569920');
INSERT INTO `sr_modular` VALUES ('sirui', '20210529233200', '1398663420668018688', 'sys_users', '', '1398663419967569920');
INSERT INTO `sr_modular` VALUES ('sirui', '20220901094849', '1565154677916438528', 'common_dict', '业务数据字典', '1516331395016822784');
INSERT INTO `sr_modular` VALUES ('sirui', '20220901094849', '1565154677949992960', 'hl_cloud_tenement_info', '惠旅云平台租户信息', '1516331395016822784');
INSERT INTO `sr_modular` VALUES ('sirui', '20220901094849', '1565154677975158784', 'sys_log', '操作日志', '1516331395016822784');
INSERT INTO `sr_modular` VALUES ('sirui', '20220901094849', '1565154678080016384', 'sys_menus', '菜单管理', '1516331395016822784');
INSERT INTO `sr_modular` VALUES ('sirui', '20220901094849', '1565154678117765120', 'sys_role_menu', '权限菜单', '1516331395016822784');
INSERT INTO `sr_modular` VALUES ('sirui', '20220901094849', '1565154678142930944', 'sys_roles', '权限管理', '1516331395016822784');
INSERT INTO `sr_modular` VALUES ('sirui', '20220901094849', '1565154678163902464', 'sys_users', '用户管理', '1516331395016822784');
INSERT INTO `sr_modular` VALUES ('sirui', '20220901094849', '1565154678193262592', 'yq_analysis_dicts', '数据分析词典', '1516331395016822784');
INSERT INTO `sr_modular` VALUES ('sirui', '20220901094849', '1565154678210039808', 'yq_data_channel_info', '采集渠道配置', '1516331395016822784');
INSERT INTO `sr_modular` VALUES ('sirui', '20220901094849', '1565154678268760064', 'yq_event_type_config', '事件模板配置', '1516331395016822784');
INSERT INTO `sr_modular` VALUES ('sirui', '20220901094849', '1565154678289731584', 'yq_report_template', '舆情报告模板配置', '1516331395016822784');
INSERT INTO `sr_modular` VALUES ('sirui', '20220901094849', '1565154678306508800', 'yq_tenement_channel', '租户采集渠道配置', '1516331395016822784');
INSERT INTO `sr_modular` VALUES ('sirui', '20220901094849', '1565154678331674624', 'yq_tenement_config', '租户采集配置表', '1516331395016822784');
INSERT INTO `sr_modular` VALUES ('sirui', '20220901094849', '1565154678373617664', 'yq_tenement_filter', '租户采集过虑器', '1516331395016822784');
INSERT INTO `sr_modular` VALUES ('sirui', '20220906134722', '1567026650967707648', 'yq_coll_content', '', '1539071400248086528');
INSERT INTO `sr_modular` VALUES ('sirui', '20220906134722', '1567026651093536768', 'yq_coll_emotion_days', '文章情感类型-日期汇总', '1539071400248086528');
INSERT INTO `sr_modular` VALUES ('sirui', '20220906134722', '1567026651139674112', 'yq_coll_emotion_group', '文章情感类型-日期汇总', '1539071400248086528');
INSERT INTO `sr_modular` VALUES ('sirui', '20220906134722', '1567026651223560192', 'yq_coll_emotion_media_days', '情感类型分类媒体类型汇总统计', '1539071400248086528');
INSERT INTO `sr_modular` VALUES ('sirui', '20220906134722', '1567026651290669056', 'yq_coll_emotion_media_group', '情感类型分类媒体类型汇总统计', '1539071400248086528');
INSERT INTO `sr_modular` VALUES ('sirui', '20220906134722', '1567026651378749440', 'yq_coll_event_type', '文章事件分类', '1539071400248086528');
INSERT INTO `sr_modular` VALUES ('sirui', '20220906134722', '1567026651420692480', 'yq_coll_info', '采集文章信息', '1539071400248086528');
INSERT INTO `sr_modular` VALUES ('sirui', '20220906134722', '1567026651500384256', 'yq_coll_info_test', '采集文章信息', '1539071400248086528');
INSERT INTO `sr_modular` VALUES ('sirui', '20220906134722', '1567026651563298816', 'yq_coll_perception_type', '采集分类信息（感知类）', '1539071400248086528');
INSERT INTO `sr_modular` VALUES ('sirui', '20220906134722', '1567026651634601984', 'yq_coll_ranking_days', '文章媒体排行-日期汇总', '1539071400248086528');
INSERT INTO `sr_modular` VALUES ('sirui', '20220906134722', '1567026651705905152', 'yq_coll_ranking_info', '文章媒体排行-日期汇总', '1539071400248086528');
INSERT INTO `sr_modular` VALUES ('sirui', '20220906134722', '1567026651789791232', 'yq_coll_satisfaction_group', '舆情数据分类统计分析', '1539071400248086528');
INSERT INTO `sr_modular` VALUES ('sirui', '20220906134722', '1567026651861094400', 'yq_coll_service_type_test', '采集数据分类', '1539071400248086528');
INSERT INTO `sr_modular` VALUES ('sirui', '20220906134722', '1567026651944980480', 'yq_collect_log', '采集数据日志', '1539071400248086528');
INSERT INTO `sr_modular` VALUES ('sirui', '20220906134722', '1567026652007895040', 'yq_comment_ranking_days', '评论媒体排行-日期汇总', '1539071400248086528');
INSERT INTO `sr_modular` VALUES ('sirui', '20220906134722', '1567026652066615296', 'yq_comment_ranking_info', '评论媒体排行-日期汇总', '1539071400248086528');
INSERT INTO `sr_modular` VALUES ('sirui', '20220906134722', '1567026652150501376', 'yq_comment_sen_group', '评论评价类型-日期汇总', '1539071400248086528');
INSERT INTO `sr_modular` VALUES ('sirui', '20220906134722', '1567026652200833024', 'yq_comment_sen_media_group', '评价类型分类媒体类型汇总统计', '1539071400248086528');
INSERT INTO `sr_modular` VALUES ('sirui', '20220906134722', '1567026652238581760', 'yq_comment_sentiment_days', '评论评价类型-日期汇总', '1539071400248086528');
INSERT INTO `sr_modular` VALUES ('sirui', '20220906134722', '1567026652288913408', 'yq_comment_sentiment_media_days', '评价类型分类媒体类型汇总统计', '1539071400248086528');
INSERT INTO `sr_modular` VALUES ('sirui', '20220906134722', '1567026652389576704', 'yq_comments', '采集评论信息', '1539071400248086528');
INSERT INTO `sr_modular` VALUES ('sirui', '20220906134722', '1567026652452491264', 'yq_comments_test', '采集评论信息', '1539071400248086528');
INSERT INTO `sr_modular` VALUES ('sirui', '20220906134722', '1567026652586708992', 'yq_day_volume', '日声量趋势', '1539071400248086528');
INSERT INTO `sr_modular` VALUES ('sirui', '20220906134722', '1567026652720926720', 'yq_report_record', '舆情报告记录', '1539071400248086528');
INSERT INTO `sr_modular` VALUES ('sirui', '20220906134722', '1567026652825784320', 'yq_word_lively_days', '词云统计', '1539071400248086528');
INSERT INTO `sr_modular` VALUES ('sirui', '20220906134722', '1567026652939030528', 'yq_word_lively_info', '词云统计', '1539071400248086528');
INSERT INTO `sr_modular` VALUES ('sirui', '20221130091753', '1597761802538586112', 'cn_audit_record', '审核记录', '1590505182045671424');
INSERT INTO `sr_modular` VALUES ('sirui', '20221130091753', '1597761802576334848', 'doc_storage_record', '文档存储管理', '1590505182045671424');
INSERT INTO `sr_modular` VALUES ('sirui', '20221130091753', '1597761802647638016', 'scm_company_acct', '企业账户管理', '1590505182045671424');
INSERT INTO `sr_modular` VALUES ('sirui', '20221130091753', '1597761802676998144', 'scm_company_active_acct', '企业账户动账记录', '1590505182045671424');
INSERT INTO `sr_modular` VALUES ('sirui', '20221130091753', '1597761802697969664', 'scm_company_cash_deposit', '保证金管理', '1590505182045671424');
INSERT INTO `sr_modular` VALUES ('sirui', '20221130091753', '1597761802723135488', 'scm_company_chain', '供应关系管理', '1590505182045671424');
INSERT INTO `sr_modular` VALUES ('sirui', '20221130091753', '1597761802748301312', 'scm_company_financial', '企业财务数据', '1590505182045671424');
INSERT INTO `sr_modular` VALUES ('sirui', '20221130091753', '1597761802773467136', 'scm_company_info', '企业信息管理', '1590505182045671424');
INSERT INTO `sr_modular` VALUES ('sirui', '20221130091753', '1597761802798632960', 'scm_company_invoice', '企业开票管理', '1590505182045671424');
INSERT INTO `sr_modular` VALUES ('sirui', '20221130091753', '1597761802827993088', 'scm_company_modify_record', '企业信息变更记录', '1590505182045671424');
INSERT INTO `sr_modular` VALUES ('sirui', '20221130091753', '1597761802848964608', 'scm_company_product', '企业产品绑定', '1590505182045671424');
INSERT INTO `sr_modular` VALUES ('sirui', '20221130091753', '1597761802886713344', 'scm_company_recipient', '企业收件人管理', '1590505182045671424');
INSERT INTO `sr_modular` VALUES ('sirui', '20221130091753', '1597761802920267776', 'scm_company_ukey', '企业U盾管理', '1590505182045671424');
INSERT INTO `sr_modular` VALUES ('sirui', '20221130091753', '1597761802970599424', 'scm_credit_apply', '统一授信申请', '1590505182045671424');
INSERT INTO `sr_modular` VALUES ('sirui', '20221130091753', '1597761802999959552', 'scm_credit_single_apply', '单笔授信申请', '1590505182045671424');
INSERT INTO `sr_modular` VALUES ('sirui', '20221130091753', '1597761803025125376', 'scm_document_template', '文档模板管理', '1590505182045671424');
INSERT INTO `sr_modular` VALUES ('sirui', '20221130091753', '1597761803050291200', 'scm_document_template_fill', '文档模板填充管理', '1590505182045671424');
INSERT INTO `sr_modular` VALUES ('sirui', '20221130091753', '1597761803075457024', 'scm_document_template_type', '文档模板类型', '1590505182045671424');
INSERT INTO `sr_modular` VALUES ('sirui', '20221130091753', '1597761803134177280', 'scm_external_inter_config', '外部接口管理', '1590505182045671424');
INSERT INTO `sr_modular` VALUES ('sirui', '20221130091753', '1597761803163537408', 'scm_loan_quota', '额度管理', '1590505182045671424');
INSERT INTO `sr_modular` VALUES ('sirui', '20221130091753', '1597761803188703232', 'scm_product_info', '产品管理', '1590505182045671424');
INSERT INTO `sr_modular` VALUES ('sirui', '20221130091753', '1597761803213869056', 'scm_quota_usage_record', '额度使用记录', '1590505182045671424');
INSERT INTO `sr_modular` VALUES ('sirui', '20221130091753', '1597761803239034880', 'scm_rate_info', '费率管理', '1590505182045671424');
INSERT INTO `sr_modular` VALUES ('sirui', '20221130091753', '1597761803264200704', 'sys_business_params', '系统业务字典', '1590505182045671424');
INSERT INTO `sr_modular` VALUES ('sirui', '20221130091753', '1597761803289366528', 'sys_log_record', '系统日志', '1590505182045671424');
INSERT INTO `sr_modular` VALUES ('sirui', '20221130091753', '1597761803314532352', 'sys_notify_record', '通知信息', '1590505182045671424');
INSERT INTO `sr_modular` VALUES ('sirui', '20221130091753', '1597761803339698176', 'sys_notify_template', '消息模板', '1590505182045671424');
INSERT INTO `sr_modular` VALUES ('sirui', '20230105112922', '1610840854564442112', 'sys_region_code', '地区编码表', '1590505182045671424');

-- ----------------------------
-- Table structure for sr_modulecfg
-- ----------------------------
DROP TABLE IF EXISTS `sr_modulecfg`;
CREATE TABLE `sr_modulecfg`  (
  `cn_name` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '描述',
  `data_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '数据类型',
  `en_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '字段',
  `id` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '主键',
  `is_auto` char(1) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT '' COMMENT '自增',
  `is_null` char(1) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT '' COMMENT '非空',
  `is_pk` char(1) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT '' COMMENT '主键',
  `project_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '项目名称',
  `select_url` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT '' COMMENT '地址',
  `show_handle` char(1) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT '' COMMENT '编辑',
  `show_query` char(1) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT '' COMMENT '查询',
  `show_table` char(1) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT '' COMMENT '列表',
  `table_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '库表名称',
  `widget_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT '' COMMENT '组件类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sr_modulecfg
-- ----------------------------
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'id', '1565154678671413248', '', '1', '1', '1516331395016822784', '', '1', '1', '1', '1565154678163902464', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'id', '1565154678683996160', '', '1', '1', '1516331395016822784', '', '1', '1', '1', '1565154677916438528', '15');
INSERT INTO `sr_modulecfg` VALUES ('', 'bigint(20)', 'id', '1565154678692384768', '', '1', '1', '1516331395016822784', '', '1', '1', '1', '1565154678117765120', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'id', '1565154678696579072', '', '1', '1', '1516331395016822784', '', '1', '1', '1', '1565154678193262592', '15');
INSERT INTO `sr_modulecfg` VALUES ('ID', 'bigint(20)', 'ID', '1565154678696579073', '', '1', '1', '1516331395016822784', '', '1', '1', '1', '1565154678306508800', '15');
INSERT INTO `sr_modulecfg` VALUES ('ID', 'bigint(20)', 'ID', '1565154678696579074', '', '1', '1', '1516331395016822784', '', '1', '1', '1', '1565154678210039808', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'id', '1565154678696579075', '', '1', '1', '1516331395016822784', '', '1', '1', '1', '1565154678289731584', '15');
INSERT INTO `sr_modulecfg` VALUES ('租户ID', 'varchar(32)', 'id', '1565154678696579076', '', '1', '1', '1516331395016822784', '', '1', '1', '1', '1565154677949992960', '15');
INSERT INTO `sr_modulecfg` VALUES ('自增编号', 'bigint(20)', 'id', '1565154678704967680', '', '1', '1', '1516331395016822784', '', '1', '1', '1', '1565154678080016384', '15');
INSERT INTO `sr_modulecfg` VALUES ('ID', 'bigint(20)', 'ID', '1565154678981791744', '', '1', '1', '1516331395016822784', '', '1', '1', '1', '1565154678331674624', '15');
INSERT INTO `sr_modulecfg` VALUES ('登录密码', 'varchar(256)', 'login_password', '1565154678981791745', '', '1', '0', '1516331395016822784', '', '1', '1', '1', '1565154678163902464', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'id', '1565154678981791746', '', '1', '1', '1516331395016822784', '', '1', '1', '1', '1565154678373617664', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'id', '1565154678981791747', '', '1', '1', '1516331395016822784', '', '1', '1', '1', '1565154678268760064', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键id', 'bigint(32)', 'id', '1565154678981791748', '', '1', '1', '1516331395016822784', '', '1', '1', '1', '1565154677975158784', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'id', '1565154678981791749', '', '1', '1', '1516331395016822784', '', '1', '1', '1', '1565154678142930944', '15');
INSERT INTO `sr_modulecfg` VALUES ('分组编号', 'varchar(64)', 'group_id', '1565154678985986048', '', '1', '0', '1516331395016822784', '', '1', '1', '1', '1565154677916438528', '15');
INSERT INTO `sr_modulecfg` VALUES ('采集数据源账号', 'varchar(64)', 'DS_ACCOUNT', '1565154679006957568', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678306508800', '15');
INSERT INTO `sr_modulecfg` VALUES ('租户别名', 'varchar(64)', 'tenement_alias', '1565154679116009472', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678331674624', '15');
INSERT INTO `sr_modulecfg` VALUES ('菜单名称', 'varchar(64)', 'title', '1565154679116009473', '', '1', '0', '1516331395016822784', '', '1', '1', '1', '1565154678080016384', '15');
INSERT INTO `sr_modulecfg` VALUES ('登陆账号', 'varchar(100)', 'admin_user_account', '1565154679120203776', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154677949992960', '15');
INSERT INTO `sr_modulecfg` VALUES ('分组编号', 'varchar(64)', 'group_id', '1565154679120203777', '', '1', '0', '1516331395016822784', '', '1', '1', '1', '1565154678193262592', '15');
INSERT INTO `sr_modulecfg` VALUES ('模板名称', 'varchar(255)', 'report_name', '1565154679124398080', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678289731584', '15');
INSERT INTO `sr_modulecfg` VALUES ('姓名', 'varchar(50)', 'name', '1565154679124398081', '', '1', '0', '1516331395016822784', '', '1', '1', '1', '1565154678163902464', '15');
INSERT INTO `sr_modulecfg` VALUES ('采集数据源密码', 'varchar(64)', 'DS_PASSWD', '1565154679136980992', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678306508800', '15');
INSERT INTO `sr_modulecfg` VALUES ('权限编号', 'bigint(20)', 'role_id', '1565154679136980993', '', '1', '0', '1516331395016822784', '', '1', '1', '1', '1565154678117765120', '15');
INSERT INTO `sr_modulecfg` VALUES ('租户编号', 'varchar(64)', 'scenic_code', '1565154679136980994', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678373617664', '15');
INSERT INTO `sr_modulecfg` VALUES ('用户名', 'varchar(50)', 'username', '1565154679141175296', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154677975158784', '15');
INSERT INTO `sr_modulecfg` VALUES ('角色名称', 'varchar(50)', 'name', '1565154679145369600', '', '1', '0', '1516331395016822784', '', '1', '1', '1', '1565154678142930944', '15');
INSERT INTO `sr_modulecfg` VALUES ('数据源代码', 'varchar(64)', 'DS_CODE', '1565154679145369601', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678210039808', '15');
INSERT INTO `sr_modulecfg` VALUES ('分组标题', 'varchar(64)', 'group_title', '1565154679149563904', '', '1', '0', '1516331395016822784', '', '1', '1', '1', '1565154677916438528', '15');
INSERT INTO `sr_modulecfg` VALUES ('事件类型名称', 'varchar(64)', 'event_type_name', '1565154679149563905', '', '1', '0', '1516331395016822784', '', '1', '1', '1', '1565154678268760064', '15');
INSERT INTO `sr_modulecfg` VALUES ('景区代码', 'varchar(64)', 'scenic_code', '1565154679166341120', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678331674624', '15');
INSERT INTO `sr_modulecfg` VALUES ('访问地址', 'varchar(120)', 'url', '1565154679178924032', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678080016384', '15');
INSERT INTO `sr_modulecfg` VALUES ('登陆用户ID', 'varchar(100)', 'admin_user_id', '1565154679183118336', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154677949992960', '15');
INSERT INTO `sr_modulecfg` VALUES ('手机号', 'varchar(11)', 'phone', '1565154679183118337', '', '1', '0', '1516331395016822784', '', '1', '1', '1', '1565154678163902464', '15');
INSERT INTO `sr_modulecfg` VALUES ('渠道编号', 'bigint(20)', 'channel_id', '1565154679183118338', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678373617664', '15');
INSERT INTO `sr_modulecfg` VALUES ('模板内容', 'text', 'report_content', '1565154679187312640', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678289731584', '15');
INSERT INTO `sr_modulecfg` VALUES ('分组标题', 'varchar(100)', 'group_title', '1565154679187312641', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678193262592', '15');
INSERT INTO `sr_modulecfg` VALUES ('执行时间', 'datetime', 'exec_time', '1565154679187312642', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678306508800', '15');
INSERT INTO `sr_modulecfg` VALUES ('请求方法', 'varchar(200)', 'method', '1565154679187312643', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154677975158784', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'create_time', '1565154679191506944', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678142930944', '15');
INSERT INTO `sr_modulecfg` VALUES ('菜单编号', 'bigint(20)', 'menu_id', '1565154679191506945', '', '1', '0', '1516331395016822784', '', '1', '1', '1', '1565154678117765120', '15');
INSERT INTO `sr_modulecfg` VALUES ('数据源名称', 'varchar(200)', 'DS_NAME', '1565154679208284160', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678210039808', '15');
INSERT INTO `sr_modulecfg` VALUES ('关键词', 'text', 'keyword', '1565154679208284161', '', '1', '0', '1516331395016822784', '', '1', '1', '1', '1565154678268760064', '15');
INSERT INTO `sr_modulecfg` VALUES ('字典KEY', 'varchar(64)', 'dict_key', '1565154679212478464', '', '1', '0', '1516331395016822784', '', '1', '1', '1', '1565154677916438528', '15');
INSERT INTO `sr_modulecfg` VALUES ('修改时间', 'datetime', 'MODIFY_TIME', '1565154679220867072', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678331674624', '15');
INSERT INTO `sr_modulecfg` VALUES ('菜单图标', 'varchar(64)', 'icon', '1565154679241838592', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678080016384', '15');
INSERT INTO `sr_modulecfg` VALUES ('邮箱', 'varchar(50)', 'email', '1565154679241838593', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678163902464', '15');
INSERT INTO `sr_modulecfg` VALUES ('景区代码', 'varchar(64)', 'scenic_code', '1565154679246032896', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678289731584', '15');
INSERT INTO `sr_modulecfg` VALUES ('下次执行时间', 'datetime', 'next_exec_time', '1565154679250227200', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678306508800', '15');
INSERT INTO `sr_modulecfg` VALUES ('排除关键词', 'text', 'exclude_word', '1565154679250227201', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678373617664', '15');
INSERT INTO `sr_modulecfg` VALUES ('词典标题', 'varchar(100)', 'dict_title', '1565154679254421504', '', '1', '0', '1516331395016822784', '', '1', '1', '1', '1565154678193262592', '15');
INSERT INTO `sr_modulecfg` VALUES ('执行时长(毫秒)', 'bigint(20)', 'time', '1565154679254421505', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154677975158784', '15');
INSERT INTO `sr_modulecfg` VALUES ('事件类型', 'varchar(64)', 'event_type', '1565154679254421506', '', '1', '0', '1516331395016822784', '', '1', '1', '1', '1565154678268760064', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'create_time', '1565154679254421507', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678117765120', '15');
INSERT INTO `sr_modulecfg` VALUES ('供应商名称', 'varchar(200)', 'SUPPLIER_NAME', '1565154679254421508', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678210039808', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'CREATE_TIME', '1565154679258615808', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678331674624', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新时间', 'datetime', 'modify_time', '1565154679258615809', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678142930944', '15');
INSERT INTO `sr_modulecfg` VALUES ('字典标题', 'varchar(64)', 'dict_title', '1565154679258615810', '', '1', '0', '1516331395016822784', '', '1', '1', '1', '1565154677916438528', '15');
INSERT INTO `sr_modulecfg` VALUES ('省ID', 'varchar(100)', 'province_id', '1565154679267004416', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154677949992960', '15');
INSERT INTO `sr_modulecfg` VALUES ('上级编号', 'bigint(20)', 'super_id', '1565154679279587328', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678080016384', '15');
INSERT INTO `sr_modulecfg` VALUES ('性别', 'int(11)', 'sex', '1565154679317336064', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678163902464', '15');
INSERT INTO `sr_modulecfg` VALUES ('分析词典内容', 'text', 'dict_content', '1565154679321530368', '', '1', '0', '1516331395016822784', '', '1', '1', '1', '1565154678193262592', '15');
INSERT INTO `sr_modulecfg` VALUES ('修改时间', 'datetime', 'MODIFY_TIME', '1565154679321530369', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678289731584', '15');
INSERT INTO `sr_modulecfg` VALUES ('包含关键司', 'text', 'include_word', '1565154679321530370', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678373617664', '15');
INSERT INTO `sr_modulecfg` VALUES ('预留字段1', 'varchar(64)', 'reserve1', '1565154679430582272', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154677916438528', '15');
INSERT INTO `sr_modulecfg` VALUES ('状态', 'int(11)', 'state', '1565154679430582273', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678331674624', '15');
INSERT INTO `sr_modulecfg` VALUES ('是否预警', 'int(1)', 'event_warning', '1565154679430582274', '', '1', '0', '1516331395016822784', '', '1', '1', '1', '1565154678268760064', '15');
INSERT INTO `sr_modulecfg` VALUES ('时间间隔（分）', 'int(11)', 'interval_time', '1565154679430582275', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678306508800', '15');
INSERT INTO `sr_modulecfg` VALUES ('地址', 'varchar(400)', 'URL', '1565154679430582276', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678210039808', '15');
INSERT INTO `sr_modulecfg` VALUES ('IP地址', 'varchar(64)', 'ip', '1565154679430582277', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154677975158784', '15');
INSERT INTO `sr_modulecfg` VALUES ('年龄', 'int(11)', 'age', '1565154679430582278', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678163902464', '15');
INSERT INTO `sr_modulecfg` VALUES ('省名称', 'varchar(100)', 'province_name', '1565154679430582279', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154677949992960', '15');
INSERT INTO `sr_modulecfg` VALUES ('子路径正则', 'varchar(1000)', 'reg_exp', '1565154679430582280', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678080016384', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新时间', 'datetime', 'modify_time', '1565154679434776576', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678117765120', '15');
INSERT INTO `sr_modulecfg` VALUES ('修改时间', 'datetime', 'MODIFY_TIME', '1565154679434776577', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678373617664', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建人', 'varchar(64)', 'CREATE_USER', '1565154679434776578', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678193262592', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'CREATE_TIME', '1565154679455748096', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678289731584', '15');
INSERT INTO `sr_modulecfg` VALUES ('城市ID', 'varchar(100)', 'city_id', '1565154679476719616', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154677949992960', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'create_time', '1565154679480913920', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154677975158784', '15');
INSERT INTO `sr_modulecfg` VALUES ('角色权限', 'bigint(20)', 'role_id', '1565154679480913921', '', '1', '0', '1516331395016822784', '', '1', '1', '1', '1565154678163902464', '15');
INSERT INTO `sr_modulecfg` VALUES ('预留字段2', 'varchar(64)', 'reserve2', '1565154679480913922', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154677916438528', '15');
INSERT INTO `sr_modulecfg` VALUES ('修改人', 'varchar(64)', 'MODIFY_USER', '1565154679485108224', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678193262592', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'CREATE_TIME', '1565154679485108225', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678373617664', '15');
INSERT INTO `sr_modulecfg` VALUES ('回调地址', 'varchar(255)', 'callback_url', '1565154679489302528', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678331674624', '15');
INSERT INTO `sr_modulecfg` VALUES ('修改时间', 'datetime', 'MODIFY_TIME', '1565154679489302529', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678306508800', '15');
INSERT INTO `sr_modulecfg` VALUES ('数据源说明', 'varchar(100)', 'description', '1565154679489302530', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678210039808', '15');
INSERT INTO `sr_modulecfg` VALUES ('排序', 'int(11)', 'menu_order', '1565154679493496832', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678080016384', '15');
INSERT INTO `sr_modulecfg` VALUES ('修改时间', 'datetime', 'MODIFY_TIME', '1565154679493496833', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678268760064', '15');
INSERT INTO `sr_modulecfg` VALUES ('模板参数', 'text', 'report_args', '1565154679510274048', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678289731584', '15');
INSERT INTO `sr_modulecfg` VALUES ('租户id', 'varchar(64)', 'tenant_id', '1565154679510274049', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154677975158784', '15');
INSERT INTO `sr_modulecfg` VALUES ('预留字段3', 'varchar(64)', 'reserve3', '1565154679522856960', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154677916438528', '15');
INSERT INTO `sr_modulecfg` VALUES ('城市名称', 'varchar(255)', 'city_name', '1565154679527051264', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154677949992960', '15');
INSERT INTO `sr_modulecfg` VALUES ('排除作者', 'text', 'exclude_author', '1565154679527051265', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678373617664', '15');
INSERT INTO `sr_modulecfg` VALUES ('登录账号', 'varchar(100)', 'login_user', '1565154679527051266', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678163902464', '15');
INSERT INTO `sr_modulecfg` VALUES ('状态', 'bigint(2)', 'STATE', '1565154679531245568', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678210039808', '15');
INSERT INTO `sr_modulecfg` VALUES ('修改时间', 'datetime', 'MODIFY_TIME', '1565154679535439872', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678193262592', '15');
INSERT INTO `sr_modulecfg` VALUES ('查询最大时间间隔', 'int(11)', 'query_max_day', '1565154679535439873', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678331674624', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'CREATE_TIME', '1565154679539634176', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678268760064', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'CREATE_TIME', '1565154679543828480', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678306508800', '15');
INSERT INTO `sr_modulecfg` VALUES ('菜单类型', 'varchar(50)', 'menu_type', '1565154679543828481', '', '1', '0', '1516331395016822784', '', '1', '1', '1', '1565154678080016384', '15');
INSERT INTO `sr_modulecfg` VALUES ('是否默认模板', 'smallint(6)', 'is_default', '1565154679548022784', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678289731584', '15');
INSERT INTO `sr_modulecfg` VALUES ('访问地址', 'varchar(255)', 'url', '1565154679564800000', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154677975158784', '15');
INSERT INTO `sr_modulecfg` VALUES ('包含作者', 'text', 'include_author', '1565154679564800001', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678373617664', '15');
INSERT INTO `sr_modulecfg` VALUES ('租户编号', 'varchar(64)', 'tenement_id', '1565154679564800002', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678163902464', '15');
INSERT INTO `sr_modulecfg` VALUES ('采集频率', 'int(6)', 'FREQUENCY', '1565154679573188608', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678210039808', '15');
INSERT INTO `sr_modulecfg` VALUES ('预留字段4', 'varchar(64)', 'reserve4', '1565154679573188609', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154677916438528', '15');
INSERT INTO `sr_modulecfg` VALUES ('区县ID', 'varchar(100)', 'county_id', '1565154679573188610', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154677949992960', '15');
INSERT INTO `sr_modulecfg` VALUES ('租户地区', 'varchar(120)', 'region', '1565154679686434816', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678331674624', '15');
INSERT INTO `sr_modulecfg` VALUES ('区县名称', 'varchar(100)', 'county_name', '1565154679690629120', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154677949992960', '15');
INSERT INTO `sr_modulecfg` VALUES ('采集渠道ID', 'bigint(20)', 'CHANNEL_ID', '1565154679690629121', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678306508800', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'CREATE_TIME', '1565154679690629122', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678193262592', '15');
INSERT INTO `sr_modulecfg` VALUES ('模板类型', 'smallint(6)', 'template_type', '1565154679690629123', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678289731584', '15');
INSERT INTO `sr_modulecfg` VALUES ('排除媒体', 'text', 'exclude_media', '1565154679694823424', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678373617664', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'modify_time', '1565154679694823425', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154677975158784', '15');
INSERT INTO `sr_modulecfg` VALUES ('账户平台类型', 'varchar(50)', 'platform_user_type', '1565154679699017728', '', '1', '0', '1516331395016822784', '', '1', '1', '1', '1565154678163902464', '15');
INSERT INTO `sr_modulecfg` VALUES ('备注', 'varchar(200)', 'REMARK', '1565154679699017729', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678210039808', '15');
INSERT INTO `sr_modulecfg` VALUES ('景区代码', 'varchar(64)', 'scenic_code', '1565154679703212032', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678268760064', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'create_time', '1565154679707406336', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678080016384', '15');
INSERT INTO `sr_modulecfg` VALUES ('字典值', 'varchar(200)', 'dict_value', '1565154679753543680', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154677916438528', '15');
INSERT INTO `sr_modulecfg` VALUES ('账户开始日期', 'varchar(100)', 'begin_date', '1565154679761932288', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154677949992960', '15');
INSERT INTO `sr_modulecfg` VALUES ('租户系统名称', 'varchar(255)', 'app_name', '1565154679761932289', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678331674624', '15');
INSERT INTO `sr_modulecfg` VALUES ('状态', 'int(11)', 'state', '1565154679766126592', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678306508800', '15');
INSERT INTO `sr_modulecfg` VALUES ('字典编号', 'varchar(64)', 'dict_id', '1565154679770320896', '', '1', '0', '1516331395016822784', '', '1', '1', '1', '1565154678193262592', '15');
INSERT INTO `sr_modulecfg` VALUES ('账户有效期', 'datetime', 'in_date', '1565154679770320897', '', '1', '0', '1516331395016822784', '', '1', '1', '1', '1565154678163902464', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新时间', 'datetime', 'modify_time', '1565154679774515200', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678080016384', '15');
INSERT INTO `sr_modulecfg` VALUES ('包含媒体', 'text', 'include_media', '1565154679774515201', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678373617664', '15');
INSERT INTO `sr_modulecfg` VALUES ('相似数量', 'int(10)', 'similar_num', '1565154679782903808', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678268760064', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建人', 'varchar(64)', 'CREATE_USER', '1565154679782903809', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678210039808', '15');
INSERT INTO `sr_modulecfg` VALUES ('全局编号', 'varchar(64)', 'overall_id', '1565154679904538624', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678193262592', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'create_time', '1565154679904538625', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154677916438528', '15');
INSERT INTO `sr_modulecfg` VALUES ('租户配置主键', 'bigint(20)', 'tenement_config_id', '1565154679908732928', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678306508800', '15');
INSERT INTO `sr_modulecfg` VALUES ('子租户', 'text', 'tenement_sub_id', '1565154679908732929', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678331674624', '15');
INSERT INTO `sr_modulecfg` VALUES ('排除标题', 'text', 'exclude_title', '1565154679917121536', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678373617664', '15');
INSERT INTO `sr_modulecfg` VALUES ('相似分值', 'float', 'similar_score', '1565154679921315840', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678268760064', '15');
INSERT INTO `sr_modulecfg` VALUES ('修改人', 'varchar(64)', 'MODIFY_USER', '1565154679925510144', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678210039808', '15');
INSERT INTO `sr_modulecfg` VALUES ('账户截止日期', 'varchar(100)', 'end_date', '1565154679925510145', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154677949992960', '15');
INSERT INTO `sr_modulecfg` VALUES ('固定KEY', 'varchar(256)', 'fixed_key', '1565154679933898752', '', '1', '0', '1516331395016822784', '', '1', '1', '1', '1565154678163902464', '15');
INSERT INTO `sr_modulecfg` VALUES ('租户关键词', 'text', 'tenement_keyword', '1565154680084893696', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678331674624', '15');
INSERT INTO `sr_modulecfg` VALUES ('租户全称', 'varchar(100)', 'full_name', '1565154680093282304', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154677949992960', '15');
INSERT INTO `sr_modulecfg` VALUES ('包含标题', 'text', 'include_title', '1565154680093282305', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678373617664', '15');
INSERT INTO `sr_modulecfg` VALUES ('状态', 'int(11)', 'state', '1565154680093282306', '', '1', '0', '1516331395016822784', '', '1', '1', '1', '1565154678163902464', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新时间', 'datetime', 'modify_time', '1565154680097476608', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154677916438528', '15');
INSERT INTO `sr_modulecfg` VALUES ('修改时间', 'datetime', 'MODIFY_TIME', '1565154680101670912', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678210039808', '15');
INSERT INTO `sr_modulecfg` VALUES ('租户简称', 'varchar(100)', 'short_name', '1565154680202334208', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154677949992960', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'create_time', '1565154680206528512', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678163902464', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'CREATE_TIME', '1565154680210722816', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678210039808', '15');
INSERT INTO `sr_modulecfg` VALUES ('用户级别', 'int(11)', 'level', '1565154680235888640', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154677949992960', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新时间', 'datetime', 'modify_time', '1565154680298803200', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678163902464', '15');
INSERT INTO `sr_modulecfg` VALUES ('用户性质（government:政府；）', 'varchar(100)', 'nature', '1565154680323969024', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154677949992960', '15');
INSERT INTO `sr_modulecfg` VALUES ('分析处理器', 'varchar(255)', 'analysis_handler_bean', '1565154680328163328', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678210039808', '15');
INSERT INTO `sr_modulecfg` VALUES ('状态（0：启用；1：停用）', 'varchar(100)', 'state', '1565154680357523456', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154677949992960', '15');
INSERT INTO `sr_modulecfg` VALUES ('联系电话', 'varchar(100)', 'telphone', '1565154680378494976', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154677949992960', '15');
INSERT INTO `sr_modulecfg` VALUES ('采集处理器类', 'varchar(255)', 'collect_handler_bean', '1565154680382689280', '', '0', '0', '1516331395016822784', '', '1', '1', '1', '1565154678210039808', '15');
INSERT INTO `sr_modulecfg` VALUES ('ID', 'bigint(20)', 'id', '1567026653438152704', '', '1', '1', '1539071400248086528', '', '1', '1', '1', '1567026652586708992', '15');
INSERT INTO `sr_modulecfg` VALUES ('ID', 'bigint(20)', 'id', '1567026653450735616', '', '1', '1', '1539071400248086528', '', '1', '1', '1', '1567026651420692480', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'id', '1567026653450735617', '', '1', '1', '1539071400248086528', '', '1', '1', '1', '1567026652720926720', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'id', '1567026653450735618', '', '1', '1', '1539071400248086528', '', '1', '1', '1', '1567026652288913408', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'id', '1567026653454929920', '', '1', '1', '1539071400248086528', '', '1', '1', '1', '1567026652825784320', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'id', '1567026653459124224', '', '1', '1', '1539071400248086528', '', '1', '1', '1', '1567026651223560192', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'id', '1567026653459124225', '', '1', '1', '1539071400248086528', '', '1', '1', '1', '1567026652150501376', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'id', '1567026653459124226', '', '1', '0', '1539071400248086528', '', '1', '1', '1', '1567026650967707648', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'id', '1567026653459124227', '', '1', '1', '1539071400248086528', '', '1', '1', '1', '1567026651093536768', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'id', '1567026653459124228', '', '1', '0', '1539071400248086528', '', '1', '1', '1', '1567026651139674112', '15');
INSERT INTO `sr_modulecfg` VALUES ('ID', 'bigint(20)', 'id', '1567026653463318528', '', '1', '1', '1539071400248086528', '', '1', '1', '1', '1567026651500384256', '15');
INSERT INTO `sr_modulecfg` VALUES ('ID', 'bigint(20)', 'id', '1567026653463318529', '', '1', '1', '1539071400248086528', '', '1', '1', '1', '1567026651944980480', '15');
INSERT INTO `sr_modulecfg` VALUES ('ID', 'bigint(20)', 'id', '1567026653463318530', '', '1', '1', '1539071400248086528', '', '1', '1', '1', '1567026652452491264', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'id', '1567026653463318531', '', '1', '1', '1539071400248086528', '', '1', '1', '1', '1567026651378749440', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'id', '1567026653471707136', '', '1', '1', '1539071400248086528', '', '1', '1', '1', '1567026652007895040', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'id', '1567026653471707137', '', '1', '1', '1539071400248086528', '', '1', '1', '1', '1567026652066615296', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'id', '1567026653471707138', '', '1', '1', '1539071400248086528', '', '1', '1', '1', '1567026651290669056', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'id', '1567026653471707139', '', '1', '1', '1539071400248086528', '', '1', '1', '1', '1567026651789791232', '15');
INSERT INTO `sr_modulecfg` VALUES ('ID', 'bigint(20)', 'id', '1567026653471707140', '', '1', '1', '1539071400248086528', '', '1', '1', '1', '1567026652389576704', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'id', '1567026653475901440', '', '1', '1', '1539071400248086528', '', '1', '1', '1', '1567026651634601984', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'id', '1567026653475901441', '', '1', '1', '1539071400248086528', '', '1', '1', '1', '1567026651563298816', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'id', '1567026653475901442', '', '1', '1', '1539071400248086528', '', '1', '1', '1', '1567026652939030528', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'id', '1567026653475901443', '', '1', '1', '1539071400248086528', '', '1', '1', '1', '1567026652200833024', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'id', '1567026653475901444', '', '1', '1', '1539071400248086528', '', '1', '1', '1', '1567026652238581760', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'id', '1567026653480095744', '', '1', '1', '1539071400248086528', '', '1', '1', '1', '1567026651705905152', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'id', '1567026653484290048', '', '1', '1', '1539071400248086528', '', '1', '1', '1', '1567026651861094400', '15');
INSERT INTO `sr_modulecfg` VALUES ('租户ID', 'varchar(64)', 'tenement_id', '1567026653526233088', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652586708992', '15');
INSERT INTO `sr_modulecfg` VALUES ('报告名称', 'varchar(255)', 'report_name', '1567026653572370432', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652720926720', '15');
INSERT INTO `sr_modulecfg` VALUES ('景区代码', 'varchar(64)', 'scenic_code', '1567026653572370433', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651139674112', '15');
INSERT INTO `sr_modulecfg` VALUES ('景区代码', 'varchar(64)', 'scenic_code', '1567026653572370434', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651500384256', '15');
INSERT INTO `sr_modulecfg` VALUES ('租户ID', 'varchar(64)', 'tenement_id', '1567026653572370435', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651944980480', '15');
INSERT INTO `sr_modulecfg` VALUES ('数据类型', 'smallint(6)', 'data_type', '1567026653572370436', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651223560192', '15');
INSERT INTO `sr_modulecfg` VALUES ('采集来源名称', 'varchar(255)', 'source_name', '1567026653576564736', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652066615296', '15');
INSERT INTO `sr_modulecfg` VALUES ('数据类型', 'smallint(6)', 'data_type', '1567026653576564737', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652288913408', '15');
INSERT INTO `sr_modulecfg` VALUES ('景区代码', 'varchar(64)', 'scenic_code', '1567026653576564738', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652939030528', '15');
INSERT INTO `sr_modulecfg` VALUES ('景区代码', 'varchar(64)', 'scenic_code', '1567026653576564739', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651093536768', '15');
INSERT INTO `sr_modulecfg` VALUES ('景区代码', 'varchar(64)', 'scenic_code', '1567026653576564740', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651420692480', '15');
INSERT INTO `sr_modulecfg` VALUES ('景区代码', 'varchar(64)', 'scenic_code', '1567026653580759040', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651789791232', '15');
INSERT INTO `sr_modulecfg` VALUES ('关联资讯ID', 'bigint(20)', 'coll_id', '1567026653580759041', '', '1', '0', '1539071400248086528', '', '1', '1', '1', '1567026650967707648', '15');
INSERT INTO `sr_modulecfg` VALUES ('景区代码', 'varchar(64)', 'scenic_code', '1567026653580759042', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652452491264', '15');
INSERT INTO `sr_modulecfg` VALUES ('采集来源名称', 'varchar(255)', 'source_name', '1567026653580759043', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651634601984', '15');
INSERT INTO `sr_modulecfg` VALUES ('原数据类型（评论/咨讯）', 'varchar(3)', 'data_source_type', '1567026653584953344', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651563298816', '15');
INSERT INTO `sr_modulecfg` VALUES ('景区代码', 'varchar(64)', 'scenic_code', '1567026653584953345', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652825784320', '15');
INSERT INTO `sr_modulecfg` VALUES ('采集来源名称', 'varchar(255)', 'source_name', '1567026653589147648', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652007895040', '15');
INSERT INTO `sr_modulecfg` VALUES ('景区代码', 'varchar(64)', 'scenic_code', '1567026653589147649', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652389576704', '15');
INSERT INTO `sr_modulecfg` VALUES ('数据类型', 'smallint(6)', 'data_type', '1567026653589147650', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651290669056', '15');
INSERT INTO `sr_modulecfg` VALUES ('数据类型', 'smallint(6)', 'data_type', '1567026653593341952', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652200833024', '15');
INSERT INTO `sr_modulecfg` VALUES ('景区代码', 'varchar(64)', 'scenic_code', '1567026653593341953', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652150501376', '15');
INSERT INTO `sr_modulecfg` VALUES ('原数据类型（评论/咨讯）', 'varchar(3)', 'data_source_type', '1567026653593341954', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651378749440', '15');
INSERT INTO `sr_modulecfg` VALUES ('采集来源名称', 'varchar(255)', 'source_name', '1567026653593341955', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651705905152', '15');
INSERT INTO `sr_modulecfg` VALUES ('数据源类型', 'varchar(3)', 'data_source_type', '1567026653652062208', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651861094400', '15');
INSERT INTO `sr_modulecfg` VALUES ('景区代码', 'varchar(64)', 'scenic_code', '1567026653652062209', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652586708992', '15');
INSERT INTO `sr_modulecfg` VALUES ('情绪类型', 'int(11)', 'emotion_type', '1567026653677228032', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651139674112', '15');
INSERT INTO `sr_modulecfg` VALUES ('媒体类型', 'varchar(64)', 'media_type', '1567026653677228033', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651223560192', '15');
INSERT INTO `sr_modulecfg` VALUES ('数据类型', 'char(3)', 'data_type', '1567026653677228034', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651789791232', '15');
INSERT INTO `sr_modulecfg` VALUES ('感知分类类型', 'varchar(64)', 'data_type', '1567026653681422336', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651563298816', '15');
INSERT INTO `sr_modulecfg` VALUES ('关键词', 'varchar(128)', 'word_name', '1567026653681422337', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652939030528', '15');
INSERT INTO `sr_modulecfg` VALUES ('报告参数', 'longtext', 'report_args', '1567026653681422338', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652720926720', '15');
INSERT INTO `sr_modulecfg` VALUES ('采集来源排行', 'int(11)', 'source_score', '1567026653681422339', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652007895040', '15');
INSERT INTO `sr_modulecfg` VALUES ('采集来源排行', 'int(11)', 'source_score', '1567026653681422340', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652066615296', '15');
INSERT INTO `sr_modulecfg` VALUES ('情绪类型', 'int(11)', 'emotion_type', '1567026653685616640', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651093536768', '15');
INSERT INTO `sr_modulecfg` VALUES ('文章来源', 'varchar(100)', 'origin_web_site_name', '1567026653685616641', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651500384256', '15');
INSERT INTO `sr_modulecfg` VALUES ('资讯内容', 'text', 'content', '1567026653748531200', '', '1', '0', '1539071400248086528', '', '1', '1', '1', '1567026650967707648', '15');
INSERT INTO `sr_modulecfg` VALUES ('事件分类类型', 'varchar(64)', 'data_type', '1567026653748531201', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651378749440', '15');
INSERT INTO `sr_modulecfg` VALUES ('媒体类型', 'varchar(64)', 'media_type', '1567026653748531202', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651290669056', '15');
INSERT INTO `sr_modulecfg` VALUES ('发布时间', 'datetime', 'publish_time', '1567026653752725504', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652452491264', '15');
INSERT INTO `sr_modulecfg` VALUES ('媒体类型', 'varchar(64)', 'media_type', '1567026653807251456', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652200833024', '15');
INSERT INTO `sr_modulecfg` VALUES ('数据类型', 'varchar(64)', 'data_type', '1567026653807251457', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651861094400', '15');
INSERT INTO `sr_modulecfg` VALUES ('关键词', 'varchar(128)', 'word_name', '1567026653807251458', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652825784320', '15');
INSERT INTO `sr_modulecfg` VALUES ('景区代码', 'varchar(64)', 'scenic_code', '1567026653807251459', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651944980480', '15');
INSERT INTO `sr_modulecfg` VALUES ('统计日期', 'date', 'volume_date', '1567026653807251460', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652586708992', '15');
INSERT INTO `sr_modulecfg` VALUES ('景区代码', 'varchar(64)', 'scenic_code', '1567026653807251461', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652238581760', '15');
INSERT INTO `sr_modulecfg` VALUES ('文章来源', 'varchar(100)', 'origin_web_site_name', '1567026653807251462', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651420692480', '15');
INSERT INTO `sr_modulecfg` VALUES ('发布时间', 'datetime', 'publish_time', '1567026653807251463', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652389576704', '15');
INSERT INTO `sr_modulecfg` VALUES ('媒体类型', 'varchar(64)', 'media_type', '1567026653807251464', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652288913408', '15');
INSERT INTO `sr_modulecfg` VALUES ('采集来源排行', 'int(11)', 'source_score', '1567026653811445760', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651705905152', '15');
INSERT INTO `sr_modulecfg` VALUES ('累计数量', 'int(11)', 'data_count', '1567026653811445761', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651789791232', '15');
INSERT INTO `sr_modulecfg` VALUES ('情绪类型', 'int(11)', 'sentiment_type', '1567026653811445762', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652150501376', '15');
INSERT INTO `sr_modulecfg` VALUES ('采集来源排行', 'int(11)', 'source_score', '1567026653811445763', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651634601984', '15');
INSERT INTO `sr_modulecfg` VALUES ('景区代码', 'varchar(64)', 'scenic_code', '1567026653928886272', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652066615296', '15');
INSERT INTO `sr_modulecfg` VALUES ('热词分数', 'double', 'word_score', '1567026653928886273', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652939030528', '15');
INSERT INTO `sr_modulecfg` VALUES ('原数据编号', 'bigint(20)', 'data_source_id', '1567026653928886274', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651563298816', '15');
INSERT INTO `sr_modulecfg` VALUES ('景区代码', 'varchar(64)', 'scenic_code', '1567026653928886275', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652007895040', '15');
INSERT INTO `sr_modulecfg` VALUES ('累计数量', 'int(11)', 'data_count', '1567026653933080576', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651093536768', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'CREATE_TIME', '1567026653933080577', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652720926720', '15');
INSERT INTO `sr_modulecfg` VALUES ('累计数量', 'int(11)', 'data_count', '1567026653937274880', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651139674112', '15');
INSERT INTO `sr_modulecfg` VALUES ('汇总数量', 'bigint(20)', 'data_count', '1567026653941469184', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651223560192', '15');
INSERT INTO `sr_modulecfg` VALUES ('汇总数量', 'bigint(20)', 'data_count', '1567026653941469185', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651290669056', '15');
INSERT INTO `sr_modulecfg` VALUES ('汇总数量', 'bigint(20)', 'data_count', '1567026653987606528', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652200833024', '15');
INSERT INTO `sr_modulecfg` VALUES ('原数据编号', 'bigint(20)', 'data_source_id', '1567026653987606529', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651378749440', '15');
INSERT INTO `sr_modulecfg` VALUES ('数据源编号', 'bigint(20)', 'data_source_id', '1567026653987606530', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651861094400', '15');
INSERT INTO `sr_modulecfg` VALUES ('媒体类型', 'varchar(200)', 'media', '1567026654046326784', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651500384256', '15');
INSERT INTO `sr_modulecfg` VALUES ('景点名称', 'varchar(200)', 'target_name', '1567026654046326785', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652452491264', '15');
INSERT INTO `sr_modulecfg` VALUES ('采集日期', 'date', 'collect_date', '1567026654046326786', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651944980480', '15');
INSERT INTO `sr_modulecfg` VALUES ('修改时间', 'timestamp', 'modify_time', '1567026654046326787', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026650967707648', '15');
INSERT INTO `sr_modulecfg` VALUES ('媒体类型', 'varchar(200)', 'media', '1567026654046326788', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651420692480', '15');
INSERT INTO `sr_modulecfg` VALUES ('情绪类型', 'int(11)', 'sentiment_type', '1567026654138601472', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652238581760', '15');
INSERT INTO `sr_modulecfg` VALUES ('修改时间', 'datetime', 'modify_time', '1567026654138601473', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651093536768', '15');
INSERT INTO `sr_modulecfg` VALUES ('修改时间', 'datetime', 'modify_time', '1567026654142795776', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651139674112', '15');
INSERT INTO `sr_modulecfg` VALUES ('汇总日期', 'date', 'collect_date', '1567026654142795777', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651223560192', '15');
INSERT INTO `sr_modulecfg` VALUES ('汇总数量', 'bigint(20)', 'data_count', '1567026654142795778', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652288913408', '15');
INSERT INTO `sr_modulecfg` VALUES ('汇总日期', 'date', 'collect_date', '1567026654146990080', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651290669056', '15');
INSERT INTO `sr_modulecfg` VALUES ('热词分数', 'double', 'word_score', '1567026654146990081', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652825784320', '15');
INSERT INTO `sr_modulecfg` VALUES ('景点名称', 'varchar(200)', 'target_name', '1567026654146990082', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652389576704', '15');
INSERT INTO `sr_modulecfg` VALUES ('修改时间', 'datetime', 'modify_time', '1567026654146990083', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651789791232', '15');
INSERT INTO `sr_modulecfg` VALUES ('舆情声量', 'int(11)', 'volume', '1567026654146990084', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652586708992', '15');
INSERT INTO `sr_modulecfg` VALUES ('修改时间', 'datetime', 'MODIFY_TIME', '1567026654146990085', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652720926720', '15');
INSERT INTO `sr_modulecfg` VALUES ('累计数量', 'int(11)', 'data_count', '1567026654151184384', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652150501376', '15');
INSERT INTO `sr_modulecfg` VALUES ('修改时间', 'datetime', 'modify_time', '1567026654151184385', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652007895040', '15');
INSERT INTO `sr_modulecfg` VALUES ('修改时间', 'datetime', 'modify_time', '1567026654151184386', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652939030528', '15');
INSERT INTO `sr_modulecfg` VALUES ('景区代码', 'varchar(64)', 'scenic_code', '1567026654155378688', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651705905152', '15');
INSERT INTO `sr_modulecfg` VALUES ('修改时间', 'datetime', 'modify_time', '1567026654155378689', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652066615296', '15');
INSERT INTO `sr_modulecfg` VALUES ('景区代码', 'varchar(64)', 'scenic_code', '1567026654159572992', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651634601984', '15');
INSERT INTO `sr_modulecfg` VALUES ('关键词', 'longtext', 'key_words', '1567026654163767296', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651563298816', '15');
INSERT INTO `sr_modulecfg` VALUES ('关键词', 'longtext', 'key_words', '1567026654197321728', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651378749440', '15');
INSERT INTO `sr_modulecfg` VALUES ('识别关键词', 'longtext', 'key_words', '1567026654201516032', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651861094400', '15');
INSERT INTO `sr_modulecfg` VALUES ('媒体类型代码', 'varchar(64)', 'media_type', '1567026654201516033', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651500384256', '15');
INSERT INTO `sr_modulecfg` VALUES ('汇总日期', 'date', 'collect_date', '1567026654205710336', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652200833024', '15');
INSERT INTO `sr_modulecfg` VALUES ('采集数据量', 'int(11)', 'collect_num', '1567026654205710337', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651944980480', '15');
INSERT INTO `sr_modulecfg` VALUES ('捕捉时间', 'datetime', 'capture_time', '1567026654205710338', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652452491264', '15');
INSERT INTO `sr_modulecfg` VALUES ('媒体类型代码', 'varchar(64)', 'media_type', '1567026654209904640', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651420692480', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'timestamp', 'create_time', '1567026654218293248', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026650967707648', '15');
INSERT INTO `sr_modulecfg` VALUES ('累计数量', 'int(11)', 'data_count', '1567026654222487552', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652238581760', '15');
INSERT INTO `sr_modulecfg` VALUES ('模板主键', 'bigint(20)', 'template_id', '1567026654222487553', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652720926720', '15');
INSERT INTO `sr_modulecfg` VALUES ('汇总日期', 'date', 'collect_date', '1567026654222487554', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652288913408', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'create_time', '1567026654226681856', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651789791232', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'create_time', '1567026654226681857', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652066615296', '15');
INSERT INTO `sr_modulecfg` VALUES ('修改时间', 'datetime', 'modify_time', '1567026654226681858', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652150501376', '15');
INSERT INTO `sr_modulecfg` VALUES ('修改时间', 'datetime', 'modify_time', '1567026654230876160', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651705905152', '15');
INSERT INTO `sr_modulecfg` VALUES ('修改时间', 'datetime', 'modify_time', '1567026654230876161', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652825784320', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'create_time', '1567026654235070464', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651139674112', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'create_time', '1567026654235070465', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652007895040', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'create_time', '1567026654235070466', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652939030528', '15');
INSERT INTO `sr_modulecfg` VALUES ('捕捉时间', 'datetime', 'capture_time', '1567026654235070467', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652389576704', '15');
INSERT INTO `sr_modulecfg` VALUES ('修改时间', 'datetime', 'modify_time', '1567026654239264768', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652586708992', '15');
INSERT INTO `sr_modulecfg` VALUES ('景区代码', 'varchar(64)', 'scenic_code', '1567026654239264769', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651223560192', '15');
INSERT INTO `sr_modulecfg` VALUES ('景区代码', 'varchar(64)', 'scenic_code', '1567026654243459072', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651290669056', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'create_time', '1567026654243459073', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651093536768', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新时间', 'datetime', 'modify_time', '1567026654289596416', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651563298816', '15');
INSERT INTO `sr_modulecfg` VALUES ('修改时间', 'datetime', 'modify_time', '1567026654289596417', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651634601984', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新时间', 'datetime', 'modify_time', '1567026654302179328', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651378749440', '15');
INSERT INTO `sr_modulecfg` VALUES ('数据采集来源', 'varchar(64)', 'source', '1567026654302179329', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651500384256', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'create_time', '1567026654306373632', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652825784320', '15');
INSERT INTO `sr_modulecfg` VALUES ('景区代码', 'varchar(64)', 'scenic_code', '1567026654306373633', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652200833024', '15');
INSERT INTO `sr_modulecfg` VALUES ('统计日期', 'date', 'collect_date', '1567026654310567936', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651789791232', '15');
INSERT INTO `sr_modulecfg` VALUES ('景区代码', 'varchar(64)', 'scenic_code', '1567026654310567937', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652720926720', '15');
INSERT INTO `sr_modulecfg` VALUES ('数据采集来源', 'varchar(64)', 'source', '1567026654310567938', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651420692480', '15');
INSERT INTO `sr_modulecfg` VALUES ('修改时间', 'datetime', 'modify_time', '1567026654310567939', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652238581760', '15');
INSERT INTO `sr_modulecfg` VALUES ('数据渠道', 'varchar(20)', 'data_channel', '1567026654314762240', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651944980480', '15');
INSERT INTO `sr_modulecfg` VALUES ('统计日期', 'date', 'collect_date', '1567026654314762241', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652066615296', '15');
INSERT INTO `sr_modulecfg` VALUES ('景区代码', 'varchar(64)', 'scenic_code', '1567026654314762242', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652288913408', '15');
INSERT INTO `sr_modulecfg` VALUES ('统计日期', 'date', 'collect_date', '1567026654314762243', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651139674112', '15');
INSERT INTO `sr_modulecfg` VALUES ('昵称', 'varchar(200)', 'nick_name', '1567026654318956544', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652452491264', '15');
INSERT INTO `sr_modulecfg` VALUES ('昵称', 'varchar(200)', 'nick_name', '1567026654318956545', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652389576704', '15');
INSERT INTO `sr_modulecfg` VALUES ('修改时间', 'datetime', 'modify_time', '1567026654318956546', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651861094400', '15');
INSERT INTO `sr_modulecfg` VALUES ('汇总日期', 'date', 'collect_date', '1567026654352510976', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652939030528', '15');
INSERT INTO `sr_modulecfg` VALUES ('统计日期', 'date', 'collect_date', '1567026654356705280', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652007895040', '15');
INSERT INTO `sr_modulecfg` VALUES ('修改时间', 'datetime', 'modify_time', '1567026654360899584', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651290669056', '15');
INSERT INTO `sr_modulecfg` VALUES ('统计日期', 'date', 'collect_date', '1567026654360899585', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651093536768', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'create_time', '1567026654360899586', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652150501376', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'create_time', '1567026654360899587', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652586708992', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'create_time', '1567026654360899588', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651705905152', '15');
INSERT INTO `sr_modulecfg` VALUES ('修改时间', 'datetime', 'modify_time', '1567026654365093888', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651223560192', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'create_time', '1567026654390259712', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651634601984', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'create_time', '1567026654407036928', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651378749440', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'create_time', '1567026654411231232', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652238581760', '15');
INSERT INTO `sr_modulecfg` VALUES ('修改时间', 'datetime', 'modify_time', '1567026654415425536', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652200833024', '15');
INSERT INTO `sr_modulecfg` VALUES ('汇总日期', 'date', 'collect_date', '1567026654415425537', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652825784320', '15');
INSERT INTO `sr_modulecfg` VALUES ('修改时间', 'datetime', 'modify_time', '1567026654415425538', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652288913408', '15');
INSERT INTO `sr_modulecfg` VALUES ('修改时间', 'datetime', 'modify_time', '1567026654415425539', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651944980480', '15');
INSERT INTO `sr_modulecfg` VALUES ('监控范围编码', 'varchar(200)', 'target_code', '1567026654419619840', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652452491264', '15');
INSERT INTO `sr_modulecfg` VALUES ('统计日期', 'date', 'collect_date', '1567026654419619841', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651634601984', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'create_time', '1567026654419619842', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651290669056', '15');
INSERT INTO `sr_modulecfg` VALUES ('统计日期', 'date', 'collect_date', '1567026654423814144', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651705905152', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'create_time', '1567026654423814145', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651223560192', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'create_time', '1567026654423814146', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651563298816', '15');
INSERT INTO `sr_modulecfg` VALUES ('来源类型', 'varchar(20)', 'source_type', '1567026654428008448', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652939030528', '15');
INSERT INTO `sr_modulecfg` VALUES ('统计日期', 'date', 'collect_date', '1567026654428008449', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652150501376', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'create_time', '1567026654428008450', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651861094400', '15');
INSERT INTO `sr_modulecfg` VALUES ('标题', 'longtext', 'title', '1567026654432202752', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651500384256', '15');
INSERT INTO `sr_modulecfg` VALUES ('标题', 'longtext', 'title', '1567026654436397056', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651420692480', '15');
INSERT INTO `sr_modulecfg` VALUES ('监控范围编码', 'varchar(200)', 'target_code', '1567026654436397057', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652389576704', '15');
INSERT INTO `sr_modulecfg` VALUES ('统计日期', 'date', 'collect_date', '1567026654453174272', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652238581760', '15');
INSERT INTO `sr_modulecfg` VALUES ('来源网站', 'varchar(200)', 'source', '1567026654453174273', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652452491264', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'create_time', '1567026654457368576', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652200833024', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'create_time', '1567026654457368577', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651944980480', '15');
INSERT INTO `sr_modulecfg` VALUES ('数据分类类型', 'smallint(6)', 'data_type', '1567026654457368578', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652939030528', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'create_time', '1567026654461562880', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652288913408', '15');
INSERT INTO `sr_modulecfg` VALUES ('来源类型', 'varchar(20)', 'source_type', '1567026654461562881', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652825784320', '15');
INSERT INTO `sr_modulecfg` VALUES ('正面趋向分值', 'int(11)', 'positive_prob', '1567026654465757184', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651500384256', '15');
INSERT INTO `sr_modulecfg` VALUES ('分组编号', 'varchar(64)', 'group_id', '1567026654469951488', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651861094400', '15');
INSERT INTO `sr_modulecfg` VALUES ('来源网站', 'varchar(200)', 'source', '1567026654474145792', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652389576704', '15');
INSERT INTO `sr_modulecfg` VALUES ('正面趋向分值', 'int(11)', 'positive_prob', '1567026654478340096', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651420692480', '15');
INSERT INTO `sr_modulecfg` VALUES ('产品名称', 'varchar(200)', 'product_name', '1567026654486728704', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652452491264', '15');
INSERT INTO `sr_modulecfg` VALUES ('数据分类类型', 'smallint(6)', 'data_type', '1567026654516088832', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652825784320', '15');
INSERT INTO `sr_modulecfg` VALUES ('点击数', 'longtext', 'views', '1567026654516088833', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651500384256', '15');
INSERT INTO `sr_modulecfg` VALUES ('评论分数', 'decimal(4,1)', 'score', '1567026654516088834', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652452491264', '15');
INSERT INTO `sr_modulecfg` VALUES ('产品名称', 'varchar(200)', 'product_name', '1567026654516088835', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652389576704', '15');
INSERT INTO `sr_modulecfg` VALUES ('评价类型', 'smallint(6)', 'evaluation_type', '1567026654524477440', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651861094400', '15');
INSERT INTO `sr_modulecfg` VALUES ('点击数', 'longtext', 'views', '1567026654524477441', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651420692480', '15');
INSERT INTO `sr_modulecfg` VALUES ('评论分数', 'decimal(4,1)', 'score', '1567026654562226176', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652389576704', '15');
INSERT INTO `sr_modulecfg` VALUES ('关键词', 'longtext', 'key_words', '1567026654566420480', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651500384256', '15');
INSERT INTO `sr_modulecfg` VALUES ('关键词', 'longtext', 'key_words', '1567026654566420481', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651420692480', '15');
INSERT INTO `sr_modulecfg` VALUES ('景区代码', 'varchar(64)', 'scenic_code', '1567026654570614784', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651861094400', '15');
INSERT INTO `sr_modulecfg` VALUES ('产品类型', 'decimal(65,30)', 'ota_type', '1567026654570614785', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652452491264', '15');
INSERT INTO `sr_modulecfg` VALUES ('产品类型', 'decimal(65,30)', 'ota_type', '1567026654583197696', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652389576704', '15');
INSERT INTO `sr_modulecfg` VALUES ('发布时间', 'datetime', 'publish_time', '1567026654595780608', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651420692480', '15');
INSERT INTO `sr_modulecfg` VALUES ('发布时间', 'datetime', 'publish_time', '1567026654612557824', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651500384256', '15');
INSERT INTO `sr_modulecfg` VALUES ('舆情观点', 'int(11)', 'sentiment', '1567026654612557825', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652452491264', '15');
INSERT INTO `sr_modulecfg` VALUES ('舆情观点', 'int(11)', 'sentiment', '1567026654625140736', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652389576704', '15');
INSERT INTO `sr_modulecfg` VALUES ('作者', 'varchar(64)', 'author', '1567026654633529344', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651420692480', '15');
INSERT INTO `sr_modulecfg` VALUES ('原链接', 'longtext', 'parent_url', '1567026654641917952', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652452491264', '15');
INSERT INTO `sr_modulecfg` VALUES ('作者', 'varchar(64)', 'author', '1567026654646112256', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651500384256', '15');
INSERT INTO `sr_modulecfg` VALUES ('原链接', 'longtext', 'parent_url', '1567026654646112257', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652389576704', '15');
INSERT INTO `sr_modulecfg` VALUES ('情感值', 'int(11)', 'emotion', '1567026654662889472', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651420692480', '15');
INSERT INTO `sr_modulecfg` VALUES ('处理状态', 'int(11)', 'state', '1567026654671278080', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652452491264', '15');
INSERT INTO `sr_modulecfg` VALUES ('处理状态', 'int(11)', 'state', '1567026654675472384', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652389576704', '15');
INSERT INTO `sr_modulecfg` VALUES ('情感值', 'int(11)', 'emotion', '1567026654675472385', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651500384256', '15');
INSERT INTO `sr_modulecfg` VALUES ('修改时间', 'datetime', 'modify_time', '1567026654692249600', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651420692480', '15');
INSERT INTO `sr_modulecfg` VALUES ('关键词', 'longtext', 'key_words', '1567026654742581248', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652452491264', '15');
INSERT INTO `sr_modulecfg` VALUES ('关键词', 'longtext', 'key_words', '1567026654780329984', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652389576704', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'create_time', '1567026654784524288', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651420692480', '15');
INSERT INTO `sr_modulecfg` VALUES ('修改时间', 'datetime', 'modify_time', '1567026654788718592', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651500384256', '15');
INSERT INTO `sr_modulecfg` VALUES ('采集渠道数据id', 'varchar(64)', 'sid', '1567026654792912896', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652452491264', '15');
INSERT INTO `sr_modulecfg` VALUES ('采集渠道数据id', 'varchar(64)', 'sid', '1567026654818078720', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652389576704', '15');
INSERT INTO `sr_modulecfg` VALUES ('负面趋向分值', 'decimal(65,30)', 'negative_prob', '1567026654826467328', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651420692480', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'create_time', '1567026654826467329', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651500384256', '15');
INSERT INTO `sr_modulecfg` VALUES ('修改时间', 'datetime', 'modify_time', '1567026654826467330', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652452491264', '15');
INSERT INTO `sr_modulecfg` VALUES ('修改时间', 'datetime', 'modify_time', '1567026654855827456', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652389576704', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'create_time', '1567026654860021760', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652452491264', '15');
INSERT INTO `sr_modulecfg` VALUES ('手动标记情绪', 'int(11)', 'old_emotion', '1567026654864216064', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651420692480', '15');
INSERT INTO `sr_modulecfg` VALUES ('负面趋向分值', 'decimal(65,30)', 'negative_prob', '1567026654868410368', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651500384256', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'create_time', '1567026654889381888', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652389576704', '15');
INSERT INTO `sr_modulecfg` VALUES ('手动标记情绪', 'int(11)', 'old_emotion', '1567026654906159104', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651500384256', '15');
INSERT INTO `sr_modulecfg` VALUES ('评论内容', 'longtext', 'content', '1567026654906159105', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652452491264', '15');
INSERT INTO `sr_modulecfg` VALUES ('情绪字段', 'varchar(64)', 'custom_flag', '1567026654910353408', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651420692480', '15');
INSERT INTO `sr_modulecfg` VALUES ('评论内容', 'longtext', 'content', '1567026654914547712', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652389576704', '15');
INSERT INTO `sr_modulecfg` VALUES ('情绪字段', 'varchar(64)', 'custom_flag', '1567026654927130624', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651500384256', '15');
INSERT INTO `sr_modulecfg` VALUES ('区域（省）', 'varchar(64)', 'region', '1567026654952296448', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651500384256', '15');
INSERT INTO `sr_modulecfg` VALUES ('原舆情观点', 'int(11)', 'old_sentiment', '1567026654956490752', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652452491264', '15');
INSERT INTO `sr_modulecfg` VALUES ('区域（省）', 'varchar(64)', 'region', '1567026654956490753', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651420692480', '15');
INSERT INTO `sr_modulecfg` VALUES ('原舆情观点', 'int(11)', 'old_sentiment', '1567026654956490754', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026652389576704', '15');
INSERT INTO `sr_modulecfg` VALUES ('热度词', 'varchar(200)', 'hot_words', '1567026654981656576', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651500384256', '15');
INSERT INTO `sr_modulecfg` VALUES ('热度词', 'varchar(200)', 'hot_words', '1567026654985850880', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651420692480', '15');
INSERT INTO `sr_modulecfg` VALUES ('相似数', 'int(11)', 'similar_count', '1567026655015211008', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651500384256', '15');
INSERT INTO `sr_modulecfg` VALUES ('相似数', 'int(11)', 'similar_count', '1567026655031988224', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651420692480', '15');
INSERT INTO `sr_modulecfg` VALUES ('是否标识为事件', 'decimal(65,30)', 'is_event', '1567026655048765440', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651500384256', '15');
INSERT INTO `sr_modulecfg` VALUES ('是否标识为事件', 'decimal(65,30)', 'is_event', '1567026655057154048', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651420692480', '15');
INSERT INTO `sr_modulecfg` VALUES ('原链接', 'text', 'url', '1567026655073931264', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651500384256', '15');
INSERT INTO `sr_modulecfg` VALUES ('原链接', 'text', 'url', '1567026655082319872', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651420692480', '15');
INSERT INTO `sr_modulecfg` VALUES ('摘要', 'longtext', 'summary', '1567026655094902784', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651500384256', '15');
INSERT INTO `sr_modulecfg` VALUES ('处理状态', 'int(11)', 'state', '1567026655120068608', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651500384256', '15');
INSERT INTO `sr_modulecfg` VALUES ('摘要', 'longtext', 'summary', '1567026655120068609', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651420692480', '15');
INSERT INTO `sr_modulecfg` VALUES ('内容', 'longtext', 'content', '1567026655153623040', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651500384256', '15');
INSERT INTO `sr_modulecfg` VALUES ('处理状态', 'int(11)', 'state', '1567026655157817344', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651420692480', '15');
INSERT INTO `sr_modulecfg` VALUES ('文章编号', 'varchar(64)', 'sid', '1567026655187177472', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651500384256', '15');
INSERT INTO `sr_modulecfg` VALUES ('内容', 'longtext', 'content', '1567026655195566080', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651420692480', '15');
INSERT INTO `sr_modulecfg` VALUES ('是否事件上传', 'smallint(6)', 'is_reported', '1567026655254286336', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651500384256', '15');
INSERT INTO `sr_modulecfg` VALUES ('文章编号', 'varchar(64)', 'sid', '1567026655266869248', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651420692480', '15');
INSERT INTO `sr_modulecfg` VALUES ('是否推送大屏', 'smallint(6)', 'is_push', '1567026655321395200', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651500384256', '15');
INSERT INTO `sr_modulecfg` VALUES ('是否事件上传', 'smallint(6)', 'is_reported', '1567026655338172416', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651420692480', '15');
INSERT INTO `sr_modulecfg` VALUES ('同步状态', 'smallint(6)', 'sync_status', '1567026655342366720', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651500384256', '15');
INSERT INTO `sr_modulecfg` VALUES ('是否推送大屏', 'smallint(6)', 'is_push', '1567026655363338240', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651420692480', '15');
INSERT INTO `sr_modulecfg` VALUES ('相似数id', 'longtext', 'similar_ids', '1567026655367532544', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651500384256', '15');
INSERT INTO `sr_modulecfg` VALUES ('相似数id', 'longtext', 'similar_ids', '1567026655388504064', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651420692480', '15');
INSERT INTO `sr_modulecfg` VALUES ('事件上报id', 'varchar(64)', 'reported_id', '1567026655392698368', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651500384256', '15');
INSERT INTO `sr_modulecfg` VALUES ('事件上报id', 'varchar(64)', 'reported_id', '1567026655413669888', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651420692480', '15');
INSERT INTO `sr_modulecfg` VALUES ('同步状态', 'smallint(6)', 'sync_status', '1567026655451418624', '', '0', '0', '1539071400248086528', '', '1', '1', '1', '1567026651420692480', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'ID', '1597761803570384896', '', '1', '1', '1590505182045671424', '', '1', '1', '1', '1597761802576334848', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'ID', '1597761803595550720', '', '1', '1', '1590505182045671424', '', '1', '1', '1', '1597761802538586112', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'ID', '1597761803599745024', '', '1', '1', '1590505182045671424', '', '1', '1', '1', '1597761802827993088', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'ID', '1597761803599745025', '', '1', '1', '1590505182045671424', '', '1', '1', '1', '1597761802647638016', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'ID', '1597761803603939328', '', '1', '1', '1590505182045671424', '', '1', '1', '1', '1597761803314532352', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'ID', '1597761803603939329', '', '1', '1', '1590505182045671424', '', '1', '1', '1', '1597761802999959552', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'ID', '1597761803612327936', '', '1', '1', '1590505182045671424', '', '1', '1', '1', '1597761803213869056', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'ID', '1597761803616522240', '', '1', '1', '1590505182045671424', '', '1', '1', '1', '1597761803239034880', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'ID', '1597761803620716544', '', '1', '1', '1590505182045671424', '', '1', '1', '1', '1597761802676998144', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'ID', '1597761803624910848', '', '1', '1', '1590505182045671424', '', '1', '1', '1', '1597761802798632960', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'ID', '1597761803633299456', '', '1', '1', '1590505182045671424', '', '1', '1', '1', '1597761803025125376', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'ID', '1597761803633299457', '', '1', '1', '1590505182045671424', '', '1', '1', '1', '1597761802773467136', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'ID', '1597761803637493760', '', '1', '1', '1590505182045671424', '', '1', '1', '1', '1597761803289366528', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'ID', '1597761803641688064', '', '1', '1', '1590505182045671424', '', '1', '1', '1', '1597761803188703232', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'ID', '1597761803641688065', '', '1', '1', '1590505182045671424', '', '1', '1', '1', '1597761802748301312', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'ID', '1597761803645882368', '', '1', '1', '1590505182045671424', '', '1', '1', '1', '1597761802970599424', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'ID', '1597761803645882369', '', '1', '1', '1590505182045671424', '', '1', '1', '1', '1597761803163537408', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'ID', '1597761803654270976', '', '1', '1', '1590505182045671424', '', '1', '1', '1', '1597761803339698176', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'CREATE_TIME', '1597761803658465280', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802576334848', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'CREATE_TIME', '1597761803679436800', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802676998144', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'CREATE_TIME', '1597761803679436801', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802647638016', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'ID', '1597761803679436802', '', '1', '1', '1590505182045671424', '', '1', '1', '1', '1597761802723135488', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'ID', '1597761803683631104', '', '1', '1', '1590505182045671424', '', '1', '1', '1', '1597761802920267776', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'ID', '1597761803683631105', '', '1', '1', '1590505182045671424', '', '1', '1', '1', '1597761802697969664', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'ID', '1597761803683631106', '', '1', '1', '1590505182045671424', '', '1', '1', '1', '1597761802848964608', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'CREATE_TIME', '1597761803683631107', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802999959552', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'ID', '1597761803683631108', '', '1', '1', '1590505182045671424', '', '1', '1', '1', '1597761802886713344', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'CREATE_TIME', '1597761803704602624', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802538586112', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'ID', '1597761803704602625', '', '1', '1', '1590505182045671424', '', '1', '1', '1', '1597761803075457024', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'ID', '1597761803704602626', '', '1', '1', '1590505182045671424', '', '1', '1', '1', '1597761803134177280', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'ID', '1597761803708796928', '', '1', '1', '1590505182045671424', '', '1', '1', '1', '1597761803050291200', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键', 'bigint(20)', 'ID', '1597761803708796929', '', '1', '1', '1590505182045671424', '', '1', '1', '1', '1597761803264200704', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'CREATE_TIME', '1597761803733962752', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802827993088', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'CREATE_TIME', '1597761803733962753', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802773467136', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'CREATE_TIME', '1597761803738157056', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803213869056', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'CREATE_TIME', '1597761803738157057', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802697969664', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新时间', 'datetime', 'MODIFY_TIME', '1597761803738157058', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802676998144', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'CREATE_TIME', '1597761803738157059', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802723135488', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'CREATE_TIME', '1597761803759128576', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803314532352', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'CREATE_TIME', '1597761803759128577', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803289366528', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'CREATE_TIME', '1597761803759128578', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802970599424', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'CREATE_TIME', '1597761803759128579', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802748301312', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'CREATE_TIME', '1597761803759128580', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803163537408', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'CREATE_TIME', '1597761803763322880', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803188703232', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新时间', 'datetime', 'MODIFY_TIME', '1597761803763322881', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802647638016', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'CREATE_TIME', '1597761803771711488', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803239034880', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'CREATE_TIME', '1597761803771711489', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803025125376', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'CREATE_TIME', '1597761803775905792', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803339698176', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新时间', 'datetime', 'MODIFY_TIME', '1597761803792683008', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802576334848', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'CREATE_TIME', '1597761803801071616', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802920267776', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'CREATE_TIME', '1597761803801071617', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802798632960', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'CREATE_TIME', '1597761803838820352', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802848964608', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新时间', 'datetime', 'MODIFY_TIME', '1597761803843014656', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802827993088', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'CREATE_TIME', '1597761803843014657', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803050291200', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新时间', 'datetime', 'MODIFY_TIME', '1597761803843014658', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802538586112', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新时间', 'datetime', 'MODIFY_TIME', '1597761803851403264', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802773467136', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'CREATE_TIME', '1597761803859791872', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803075457024', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新时间', 'datetime', 'MODIFY_TIME', '1597761803859791873', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803213869056', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新时间', 'datetime', 'MODIFY_TIME', '1597761803914317824', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803188703232', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新时间', 'datetime', 'MODIFY_TIME', '1597761803931095040', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803239034880', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新时间', 'datetime', 'MODIFY_TIME', '1597761803931095041', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802999959552', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新时间', 'datetime', 'MODIFY_TIME', '1597761803935289344', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803025125376', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新时间', 'datetime', 'MODIFY_TIME', '1597761803939483648', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802723135488', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新时间', 'datetime', 'MODIFY_TIME', '1597761803947872256', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803163537408', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新时间', 'datetime', 'MODIFY_TIME', '1597761803952066560', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803339698176', '15');
INSERT INTO `sr_modulecfg` VALUES ('分组编号', 'varchar(64)', 'GROUP_ID', '1597761803952066561', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803264200704', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新时间', 'datetime', 'MODIFY_TIME', '1597761803952066562', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803050291200', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新时间', 'datetime', 'MODIFY_TIME', '1597761803952066563', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802697969664', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新时间', 'datetime', 'MODIFY_TIME', '1597761803956260864', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802970599424', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新时间', 'datetime', 'MODIFY_TIME', '1597761803956260865', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802748301312', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新时间', 'datetime', 'MODIFY_TIME', '1597761803960455168', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803289366528', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建用户', 'varchar(100)', 'CREATE_BY', '1597761803960455169', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802676998144', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建用户', 'varchar(100)', 'CREATE_BY', '1597761803964649472', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802647638016', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'CREATE_TIME', '1597761803968843776', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802886713344', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'CREATE_TIME', '1597761803968843777', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803134177280', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新时间', 'datetime', 'MODIFY_TIME', '1597761803968843778', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803314532352', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新时间', 'datetime', 'MODIFY_TIME', '1597761803973038080', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802798632960', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新时间', 'datetime', 'MODIFY_TIME', '1597761803977232384', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802920267776', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建用户', 'varchar(100)', 'CREATE_BY', '1597761803981426688', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802576334848', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建用户', 'varchar(100)', 'CREATE_BY', '1597761804023369728', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802827993088', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建用户', 'varchar(100)', 'CREATE_BY', '1597761804073701376', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803213869056', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建用户', 'varchar(100)', 'CREATE_BY', '1597761804082089984', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802999959552', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建用户', 'varchar(100)', 'CREATE_BY', '1597761804086284288', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803239034880', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建用户', 'varchar(100)', 'CREATE_BY', '1597761804090478592', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802773467136', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建用户', 'varchar(100)', 'CREATE_BY', '1597761804090478593', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802798632960', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新用户', 'varchar(100)', 'MODIFY_BY', '1597761804094672896', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802576334848', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建用户', 'varchar(100)', 'CREATE_BY', '1597761804103061504', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802697969664', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建用户', 'varchar(100)', 'CREATE_BY', '1597761804103061505', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803188703232', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新时间', 'datetime', 'MODIFY_TIME', '1597761804103061506', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803134177280', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建用户', 'varchar(100)', 'CREATE_BY', '1597761804111450112', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803050291200', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新用户', 'varchar(100)', 'MODIFY_BY', '1597761804111450113', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802647638016', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建用户', 'varchar(100)', 'CREATE_BY', '1597761804115644416', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802970599424', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建用户', 'varchar(100)', 'CREATE_BY', '1597761804115644417', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803163537408', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建用户', 'varchar(100)', 'CREATE_BY', '1597761804115644418', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803339698176', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新用户', 'varchar(100)', 'MODIFY_BY', '1597761804119838720', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802827993088', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建用户', 'varchar(100)', 'CREATE_BY', '1597761804124033024', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803025125376', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新时间', 'datetime', 'MODIFY_TIME', '1597761804124033025', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802848964608', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建用户', 'varchar(100)', 'CREATE_BY', '1597761804128227328', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803314532352', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建用户', 'varchar(100)', 'CREATE_BY', '1597761804136615936', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802748301312', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新时间', 'datetime', 'MODIFY_TIME', '1597761804136615937', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802886713344', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建用户', 'varchar(100)', 'CREATE_BY', '1597761804140810240', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802538586112', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新用户', 'varchar(100)', 'MODIFY_BY', '1597761804145004544', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802676998144', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新时间', 'datetime', 'MODIFY_TIME', '1597761804145004545', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803075457024', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建用户', 'varchar(100)', 'CREATE_BY', '1597761804157587456', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802723135488', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建用户', 'varchar(100)', 'CREATE_BY', '1597761804165976064', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803289366528', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新用户', 'varchar(100)', 'MODIFY_BY', '1597761804165976065', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803239034880', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建用户', 'varchar(100)', 'CREATE_BY', '1597761804165976066', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802920267776', '15');
INSERT INTO `sr_modulecfg` VALUES ('分组标题', 'varchar(64)', 'GROUP_TITLE', '1597761804165976067', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803264200704', '15');
INSERT INTO `sr_modulecfg` VALUES ('所属企业', 'varchar(100)', 'COMPANY_NO', '1597761804224696320', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802827993088', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新用户', 'varchar(100)', 'MODIFY_BY', '1597761804228890624', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802999959552', '15');
INSERT INTO `sr_modulecfg` VALUES ('所属企业', 'varchar(100)', 'COMPANY_NO', '1597761804233084928', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802647638016', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新用户', 'varchar(100)', 'MODIFY_BY', '1597761804233084929', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803050291200', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新用户', 'varchar(100)', 'MODIFY_BY', '1597761804241473536', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802697969664', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新用户', 'varchar(100)', 'MODIFY_BY', '1597761804241473537', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802773467136', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新用户', 'varchar(100)', 'MODIFY_BY', '1597761804241473538', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803025125376', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新用户', 'varchar(100)', 'MODIFY_BY', '1597761804245667840', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802798632960', '15');
INSERT INTO `sr_modulecfg` VALUES ('所属企业', 'varchar(100)', 'COMPANY_NO', '1597761804249862144', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802576334848', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新用户', 'varchar(100)', 'MODIFY_BY', '1597761804258250752', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802748301312', '15');
INSERT INTO `sr_modulecfg` VALUES ('字典KEY', 'varchar(64)', 'DICT_KEY', '1597761804262445056', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803264200704', '15');
INSERT INTO `sr_modulecfg` VALUES ('操作用户', 'varchar(100)', 'USER_NAME', '1597761804266639360', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803239034880', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新用户', 'varchar(100)', 'MODIFY_BY', '1597761804270833664', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803314532352', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新用户', 'varchar(100)', 'MODIFY_BY', '1597761804275027968', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803213869056', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建用户', 'varchar(100)', 'CREATE_BY', '1597761804283416576', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803075457024', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新用户', 'varchar(100)', 'MODIFY_BY', '1597761804283416577', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803163537408', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新用户', 'varchar(100)', 'MODIFY_BY', '1597761804283416578', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803289366528', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建用户', 'varchar(100)', 'CREATE_BY', '1597761804283416579', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803134177280', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建用户', 'varchar(100)', 'CREATE_BY', '1597761804287610880', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802886713344', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新用户', 'varchar(100)', 'MODIFY_BY', '1597761804287610881', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803188703232', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新用户', 'varchar(100)', 'MODIFY_BY', '1597761804291805184', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802538586112', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建用户', 'varchar(100)', 'CREATE_BY', '1597761804291805185', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802848964608', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新用户', 'varchar(100)', 'MODIFY_BY', '1597761804300193792', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802920267776', '15');
INSERT INTO `sr_modulecfg` VALUES ('所属企业', 'varchar(100)', 'COMPANY_NO', '1597761804304388096', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802676998144', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新用户', 'varchar(100)', 'MODIFY_BY', '1597761804308582400', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803339698176', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新用户', 'varchar(100)', 'MODIFY_BY', '1597761804312776704', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802970599424', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新用户', 'varchar(100)', 'MODIFY_BY', '1597761804312776705', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802723135488', '15');
INSERT INTO `sr_modulecfg` VALUES ('所属企业', 'varchar(100)', 'COMPANY_NO', '1597761804346331136', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802697969664', '15');
INSERT INTO `sr_modulecfg` VALUES ('通知对象', 'varchar(100)', 'NOTIFY_TARGET', '1597761804350525440', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803314532352', '15');
INSERT INTO `sr_modulecfg` VALUES ('开户银行名称', 'varchar(200)', 'BANK_NM', '1597761804350525441', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802647638016', '15');
INSERT INTO `sr_modulecfg` VALUES ('所属企业', 'varchar(100)', 'COMPANY_NO', '1597761804354719744', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802999959552', '15');
INSERT INTO `sr_modulecfg` VALUES ('批次编号', 'varchar(64)', 'BATCH_ID', '1597761804354719745', '', '1', '0', '1590505182045671424', '', '1', '1', '1', '1597761802827993088', '15');
INSERT INTO `sr_modulecfg` VALUES ('填充编码', 'varchar(100)', 'FILL_CODE', '1597761804354719746', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803050291200', '15');
INSERT INTO `sr_modulecfg` VALUES ('字典标题', 'varchar(64)', 'DICT_TITLE', '1597761804354719747', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803264200704', '15');
INSERT INTO `sr_modulecfg` VALUES ('模板类型', 'varchar(50)', 'DOC_TYPE', '1597761804363108352', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803025125376', '15');
INSERT INTO `sr_modulecfg` VALUES ('所属企业', 'varchar(100)', 'COMPANY_NO', '1597761804363108353', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802748301312', '15');
INSERT INTO `sr_modulecfg` VALUES ('企业编号', 'varchar(100)', 'COMPANY_NO', '1597761804363108354', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802773467136', '15');
INSERT INTO `sr_modulecfg` VALUES ('所属企业', 'varchar(100)', 'COMPANY_NO', '1597761804371496960', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803213869056', '15');
INSERT INTO `sr_modulecfg` VALUES ('模板ID', 'bigint(20)', 'TEMPLATE_ID', '1597761804375691264', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802576334848', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新用户', 'varchar(100)', 'MODIFY_BY', '1597761804375691265', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802848964608', '15');
INSERT INTO `sr_modulecfg` VALUES ('所属企业', 'varchar(100)', 'COMPANY_NO', '1597761804388274176', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802920267776', '15');
INSERT INTO `sr_modulecfg` VALUES ('所属企业', 'varchar(100)', 'COMPANY_NO', '1597761804392468480', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803163537408', '15');
INSERT INTO `sr_modulecfg` VALUES ('所属企业', 'varchar(100)', 'COMPANY_NO', '1597761804392468481', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802798632960', '15');
INSERT INTO `sr_modulecfg` VALUES ('所属产品', 'varchar(64)', 'PRO_CODE', '1597761804413440000', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802676998144', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新用户', 'varchar(100)', 'MODIFY_BY', '1597761804417634304', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802886713344', '15');
INSERT INTO `sr_modulecfg` VALUES ('所属企业', 'varchar(100)', 'COMPANY_NO', '1597761804417634305', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802970599424', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新用户', 'varchar(100)', 'MODIFY_BY', '1597761804417634306', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803075457024', '15');
INSERT INTO `sr_modulecfg` VALUES ('操作用户', 'varchar(100)', 'USER_NAME', '1597761804421828608', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803289366528', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新用户', 'varchar(100)', 'MODIFY_BY', '1597761804426022912', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803134177280', '15');
INSERT INTO `sr_modulecfg` VALUES ('开户银行名称', 'varchar(200)', 'BANK_NM', '1597761804430217216', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802697969664', '15');
INSERT INTO `sr_modulecfg` VALUES ('业务编号', 'varchar(64)', 'BUS_NO', '1597761804430217217', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802538586112', '15');
INSERT INTO `sr_modulecfg` VALUES ('企业状态', 'int(11)', 'STATE', '1597761804430217218', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802773467136', '15');
INSERT INTO `sr_modulecfg` VALUES ('填充字段名称', 'varchar(100)', 'FILL_NAME', '1597761804438605824', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803050291200', '15');
INSERT INTO `sr_modulecfg` VALUES ('通知状态', 'int(11)', 'STATE', '1597761804438605825', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803314532352', '15');
INSERT INTO `sr_modulecfg` VALUES ('所属企业', 'varchar(100)', 'COMPANY_NO', '1597761804446994432', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802723135488', '15');
INSERT INTO `sr_modulecfg` VALUES ('模板类型', 'int(11)', 'TEMPLATE_TYPE', '1597761804451188736', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803339698176', '15');
INSERT INTO `sr_modulecfg` VALUES ('产品标识', 'varchar(64)', 'PRO_CODE', '1597761804459577344', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803188703232', '15');
INSERT INTO `sr_modulecfg` VALUES ('模板编号', 'varchar(100)', 'TEMPLATE_CODE', '1597761804463771648', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803025125376', '15');
INSERT INTO `sr_modulecfg` VALUES ('所属产品', 'varchar(64)', 'PRO_CODE', '1597761804463771649', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803213869056', '15');
INSERT INTO `sr_modulecfg` VALUES ('申请流水号', 'varchar(100)', 'SERIAL_NO', '1597761804467965952', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802999959552', '15');
INSERT INTO `sr_modulecfg` VALUES ('所属产品', 'varchar(64)', 'PRO_CODE', '1597761804467965953', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803163537408', '15');
INSERT INTO `sr_modulecfg` VALUES ('文档标题', 'varchar(200)', 'DOC_TITLE', '1597761804472160256', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802576334848', '15');
INSERT INTO `sr_modulecfg` VALUES ('账户账号', 'varchar(30)', 'ACCT_NO', '1597761804476354560', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802647638016', '15');
INSERT INTO `sr_modulecfg` VALUES ('业务代码', 'varchar(10)', 'TX_CODE', '1597761804476354561', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802676998144', '15');
INSERT INTO `sr_modulecfg` VALUES ('字典值', 'varchar(200)', 'DICT_VALUE', '1597761804480548864', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803264200704', '15');
INSERT INTO `sr_modulecfg` VALUES ('所属企业', 'varchar(100)', 'COMPANY_NO', '1597761804484743168', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802886713344', '15');
INSERT INTO `sr_modulecfg` VALUES ('英文名称', 'varchar(200)', 'COLUMN_EN_NAME', '1597761804488937472', '', '1', '0', '1590505182045671424', '', '1', '1', '1', '1597761802827993088', '15');
INSERT INTO `sr_modulecfg` VALUES ('申请流水号', 'varchar(100)', 'SERIAL_NO', '1597761804568629248', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802970599424', '15');
INSERT INTO `sr_modulecfg` VALUES ('业务流水号', 'varchar(64)', 'BUS_SERIAL_NO', '1597761804577017856', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802538586112', '15');
INSERT INTO `sr_modulecfg` VALUES ('财报类型', 'int(11)', 'REPORT_TYPE', '1597761804581212160', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802748301312', '15');
INSERT INTO `sr_modulecfg` VALUES ('用户账号', 'varchar(100)', 'USER_ID', '1597761804581212161', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803289366528', '15');
INSERT INTO `sr_modulecfg` VALUES ('发票类型', 'int(11)', 'INVOICE_TYPE', '1597761804581212162', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802798632960', '15');
INSERT INTO `sr_modulecfg` VALUES ('所属企业', 'varchar(100)', 'COMPANY_NO', '1597761804585406464', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802848964608', '15');
INSERT INTO `sr_modulecfg` VALUES ('分组编号', 'varchar(50)', 'DOC_GROUP_ID', '1597761804589600768', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803075457024', '15');
INSERT INTO `sr_modulecfg` VALUES ('绑定用户', 'varchar(100)', 'BIND_USER', '1597761804589600769', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802920267776', '15');
INSERT INTO `sr_modulecfg` VALUES ('通知标题', 'varchar(300)', 'NOTIFY_TITLE', '1597761804602183680', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803314532352', '15');
INSERT INTO `sr_modulecfg` VALUES ('业务模块名称', 'varchar(200)', 'MODULE_NAME', '1597761804602183681', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802576334848', '15');
INSERT INTO `sr_modulecfg` VALUES ('开户行名称', 'varchar(120)', 'BANK_NAME', '1597761804606377984', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802697969664', '15');
INSERT INTO `sr_modulecfg` VALUES ('账户户名', 'varchar(50)', 'ACCT_NAME', '1597761804610572288', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802647638016', '15');
INSERT INTO `sr_modulecfg` VALUES ('动账账户', 'varchar(64)', 'ACCT_NO', '1597761804610572289', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802676998144', '15');
INSERT INTO `sr_modulecfg` VALUES ('模板标题', 'varchar(200)', 'DOC_TITLE', '1597761804614766592', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803025125376', '15');
INSERT INTO `sr_modulecfg` VALUES ('外部流水号', 'varchar(100)', 'EXT_SERIAL_NO', '1597761804618960896', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802999959552', '15');
INSERT INTO `sr_modulecfg` VALUES ('操作用户', 'varchar(100)', 'USER_NAME', '1597761804627349504', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803134177280', '15');
INSERT INTO `sr_modulecfg` VALUES ('业务批次号', 'varchar(64)', 'BUS_BATCH_NO', '1597761804627349505', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803213869056', '15');
INSERT INTO `sr_modulecfg` VALUES ('认证时间', 'datetime', 'CERT_TIME', '1597761804627349506', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802773467136', '15');
INSERT INTO `sr_modulecfg` VALUES ('填充类型', 'int(11)', 'FILL_TYPE', '1597761804631543808', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803050291200', '15');
INSERT INTO `sr_modulecfg` VALUES ('分组名称', 'varchar(100)', 'DOC_GROUP_NAME', '1597761804635738112', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803075457024', '15');
INSERT INTO `sr_modulecfg` VALUES ('总额度', 'decimal(20,2)', 'TOTAIL_AMT', '1597761804635738113', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803163537408', '15');
INSERT INTO `sr_modulecfg` VALUES ('模板名称', 'varchar(64)', 'TEMPLATE_NAME', '1597761804639932416', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803339698176', '15');
INSERT INTO `sr_modulecfg` VALUES ('产品名称', 'varchar(100)', 'PRO_NAME', '1597761804639932417', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803188703232', '15');
INSERT INTO `sr_modulecfg` VALUES ('状态', 'int(11)', 'STATE', '1597761804644126720', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802886713344', '15');
INSERT INTO `sr_modulecfg` VALUES ('关联企业编号', 'varchar(100)', 'CHAIN_COMPANY_NO', '1597761804656709632', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802723135488', '15');
INSERT INTO `sr_modulecfg` VALUES ('预留1', 'varchar(64)', 'RESERVE1', '1597761804656709633', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803264200704', '15');
INSERT INTO `sr_modulecfg` VALUES ('中文说明', 'varchar(200)', 'COLUMN_CN_NAME', '1597761804656709634', '', '1', '0', '1590505182045671424', '', '1', '1', '1', '1597761802827993088', '15');
INSERT INTO `sr_modulecfg` VALUES ('审核结果', 'varchar(100)', 'AUDIT_FINISH', '1597761804660903936', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802538586112', '15');
INSERT INTO `sr_modulecfg` VALUES ('开户行名称', 'varchar(120)', 'BANK_NAME', '1597761804677681152', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802647638016', '15');
INSERT INTO `sr_modulecfg` VALUES ('申请时间', 'datetime', 'APPLY_TIME', '1597761804681875456', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802999959552', '15');
INSERT INTO `sr_modulecfg` VALUES ('操作模块', 'varchar(300)', 'MODULE_NAME', '1597761804690264064', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803289366528', '15');
INSERT INTO `sr_modulecfg` VALUES ('状态', 'int(11)', 'STATE', '1597761804694458368', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802920267776', '15');
INSERT INTO `sr_modulecfg` VALUES ('绑定产品', 'varchar(64)', 'PRO_CODE', '1597761804702846976', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802848964608', '15');
INSERT INTO `sr_modulecfg` VALUES ('发票抬头', 'varchar(200)', 'INVOICE_HEAD', '1597761804702846977', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802798632960', '15');
INSERT INTO `sr_modulecfg` VALUES ('模板内容', 'longtext', 'CONTENT', '1597761804715429888', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803025125376', '15');
INSERT INTO `sr_modulecfg` VALUES ('外部流水号', 'varchar(100)', 'EXT_SERIAL_NO', '1597761804719624192', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802970599424', '15');
INSERT INTO `sr_modulecfg` VALUES ('业务标题', 'varchar(100)', 'BUS_TITLE', '1597761804719624193', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803339698176', '15');
INSERT INTO `sr_modulecfg` VALUES ('变更前值', 'text', 'BEFORE_VALUE', '1597761804719624194', '', '1', '0', '1590505182045671424', '', '1', '1', '1', '1597761802827993088', '15');
INSERT INTO `sr_modulecfg` VALUES ('可用额度', 'decimal(20,2)', 'AMT', '1597761804723818496', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803163537408', '15');
INSERT INTO `sr_modulecfg` VALUES ('选择列表URL', 'varchar(400)', 'SELECT_LIST_URL', '1597761804736401408', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803050291200', '15');
INSERT INTO `sr_modulecfg` VALUES ('类型状态', 'int(11)', 'STATE', '1597761804736401409', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803075457024', '15');
INSERT INTO `sr_modulecfg` VALUES ('开户行行号', 'varchar(60)', 'BANK_NO', '1597761804740595712', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802647638016', '15');
INSERT INTO `sr_modulecfg` VALUES ('业务流水号', 'varchar(50)', 'BUS_SERIAL_NO', '1597761804740595713', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803213869056', '15');
INSERT INTO `sr_modulecfg` VALUES ('业务流水号', 'varchar(100)', 'BUS_SERIAL_NO', '1597761804740595714', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802576334848', '15');
INSERT INTO `sr_modulecfg` VALUES ('通知内容', 'varchar(1024)', 'CONTENT', '1597761804740595715', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803314532352', '15');
INSERT INTO `sr_modulecfg` VALUES ('开户行行号', 'varchar(60)', 'BANK_NO', '1597761804740595716', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802697969664', '15');
INSERT INTO `sr_modulecfg` VALUES ('审核描述', 'varchar(300)', 'AUDIT_REMARK', '1597761804744790016', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802538586112', '15');
INSERT INTO `sr_modulecfg` VALUES ('收件人', 'varchar(100)', 'NAME', '1597761804748984320', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802886713344', '15');
INSERT INTO `sr_modulecfg` VALUES ('产品描述', 'varchar(300)', 'REMARK', '1597761804748984321', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803188703232', '15');
INSERT INTO `sr_modulecfg` VALUES ('所属企业', 'varchar(100)', 'COMPANY_NO', '1597761804753178624', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803134177280', '15');
INSERT INTO `sr_modulecfg` VALUES ('企业类型', 'varchar(20)', 'COMPANY_TYPE', '1597761804757372928', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802773467136', '15');
INSERT INTO `sr_modulecfg` VALUES ('财报年份', 'date', 'REPORT_YEAR', '1597761804757372929', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802748301312', '15');
INSERT INTO `sr_modulecfg` VALUES ('业务流水号', 'varchar(50)', 'BUS_SERIAL_NO', '1597761804765761536', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802676998144', '15');
INSERT INTO `sr_modulecfg` VALUES ('预留2', 'varchar(64)', 'RESERVE2', '1597761804778344448', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803264200704', '15');
INSERT INTO `sr_modulecfg` VALUES ('纳税人识别号', 'varchar(50)', 'TAXPAYER_CODE', '1597761804786733056', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802798632960', '15');
INSERT INTO `sr_modulecfg` VALUES ('绑定状态', 'int(11)', 'STATE', '1597761804803510272', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802848964608', '15');
INSERT INTO `sr_modulecfg` VALUES ('账户状态', 'int(11)', 'ACCT_STATE', '1597761804807704576', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802647638016', '15');
INSERT INTO `sr_modulecfg` VALUES ('额度状态', 'int(11)', 'QUOTA_STATE', '1597761804811898880', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803163537408', '15');
INSERT INTO `sr_modulecfg` VALUES ('上下游标志', 'int(11)', 'CHAIN_DIRECTION', '1597761804811898881', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802723135488', '15');
INSERT INTO `sr_modulecfg` VALUES ('申请状态', 'int(11)', 'APPLY_STATE', '1597761804811898882', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802999959552', '15');
INSERT INTO `sr_modulecfg` VALUES ('模板状态', 'int(11)', 'STATE', '1597761804816093184', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803025125376', '15');
INSERT INTO `sr_modulecfg` VALUES ('变更后值', 'text', 'AFTER_VALUE', '1597761804816093185', '', '1', '0', '1590505182045671424', '', '1', '1', '1', '1597761802827993088', '15');
INSERT INTO `sr_modulecfg` VALUES ('使用前金额', 'decimal(20,2)', 'BEFORE_AMT', '1597761804824481792', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803213869056', '15');
INSERT INTO `sr_modulecfg` VALUES ('文档模板ID', 'bigint(20)', 'TEMPLATE_ID', '1597761804828676096', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803050291200', '15');
INSERT INTO `sr_modulecfg` VALUES ('申请时间', 'datetime', 'APPLY_TIME', '1597761804832870400', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802970599424', '15');
INSERT INTO `sr_modulecfg` VALUES ('类型编码', 'varchar(100)', 'EXT_CODE', '1597761804837064704', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803134177280', '15');
INSERT INTO `sr_modulecfg` VALUES ('上级企业', 'varchar(100)', 'UP_COMPANY_NO', '1597761804841259008', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802773467136', '15');
INSERT INTO `sr_modulecfg` VALUES ('设备ID', 'varchar(40)', 'UKEY_ID', '1597761804841259009', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802920267776', '15');
INSERT INTO `sr_modulecfg` VALUES ('存储位置', 'varchar(500)', 'STORE_PATH', '1597761804841259010', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802576334848', '15');
INSERT INTO `sr_modulecfg` VALUES ('模板内容', 'text', 'BUS_CONTENT', '1597761804849647616', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803339698176', '15');
INSERT INTO `sr_modulecfg` VALUES ('操作类型', 'varchar(200)', 'OPERATION_TYPE', '1597761804849647617', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803289366528', '15');
INSERT INTO `sr_modulecfg` VALUES ('保证金账号', 'varchar(30)', 'ACCT_NO', '1597761804858036224', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802697969664', '15');
INSERT INTO `sr_modulecfg` VALUES ('产品状态', 'int(11)', 'STATE', '1597761804862230528', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803188703232', '15');
INSERT INTO `sr_modulecfg` VALUES ('电子邮箱', 'varchar(100)', 'EMAIL', '1597761804870619136', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802886713344', '15');
INSERT INTO `sr_modulecfg` VALUES ('财报月份', 'date', 'REPORT_MONTH', '1597761804874813440', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802748301312', '15');
INSERT INTO `sr_modulecfg` VALUES ('银行流水号', 'varchar(64)', 'BANK_SERIAL_NO', '1597761804908367872', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802676998144', '15');
INSERT INTO `sr_modulecfg` VALUES ('值转换源', 'varchar(200)', 'CONVERT_CODE', '1597761804908367873', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802827993088', '15');
INSERT INTO `sr_modulecfg` VALUES ('模板格式', 'varchar(10)', 'DOC_SUFFIX', '1597761804908367874', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803025125376', '15');
INSERT INTO `sr_modulecfg` VALUES ('开户银行', 'varchar(120)', 'BANK_NAME', '1597761804912562176', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802798632960', '15');
INSERT INTO `sr_modulecfg` VALUES ('文档版本号', 'int(11)', 'DOC_VERSION', '1597761804916756480', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802576334848', '15');
INSERT INTO `sr_modulecfg` VALUES ('预留3', 'varchar(64)', 'RESERVE3', '1597761804916756481', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803264200704', '15');
INSERT INTO `sr_modulecfg` VALUES ('操作内容', 'varchar(400)', 'OPERATION_CONTENT', '1597761804916756482', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803289366528', '15');
INSERT INTO `sr_modulecfg` VALUES ('外部编号', 'varchar(64)', 'EXT_CODE', '1597761804925145088', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802773467136', '15');
INSERT INTO `sr_modulecfg` VALUES ('执行代码', 'varchar(200)', 'BEAN_NAME', '1597761804933533696', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803134177280', '15');
INSERT INTO `sr_modulecfg` VALUES ('申请状态', 'int(11)', 'APPLY_STATE', '1597761804937728000', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802970599424', '15');
INSERT INTO `sr_modulecfg` VALUES ('所属产品', 'varchar(64)', 'PRO_CODE', '1597761804941922304', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802999959552', '15');
INSERT INTO `sr_modulecfg` VALUES ('设备DN码', 'varchar(512)', 'UKEY_DN', '1597761804946116608', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802920267776', '15');
INSERT INTO `sr_modulecfg` VALUES ('默认账户', 'int(11)', 'IS_DEFAULT', '1597761804946116609', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802647638016', '15');
INSERT INTO `sr_modulecfg` VALUES ('状态', 'int(11)', 'STATE', '1597761804950310912', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802723135488', '15');
INSERT INTO `sr_modulecfg` VALUES ('营业总收入(万)', 'decimal(10,2)', 'INCOME_TOTAL_AMT', '1597761804958699520', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802748301312', '15');
INSERT INTO `sr_modulecfg` VALUES ('使用金额', 'decimal(20,2)', 'CUR_AMT', '1597761804962893824', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803213869056', '15');
INSERT INTO `sr_modulecfg` VALUES ('保证金户名', 'varchar(50)', 'ACCT_NAME', '1597761804962893825', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802697969664', '15');
INSERT INTO `sr_modulecfg` VALUES ('收件人手机号', 'varchar(11)', 'TEL', '1597761804975476736', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802886713344', '15');
INSERT INTO `sr_modulecfg` VALUES ('动账金额', 'decimal(20,2)', 'AMT', '1597761804983865344', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802676998144', '15');
INSERT INTO `sr_modulecfg` VALUES ('模板版本', 'int(11)', 'DOC_VERSION', '1597761805013225472', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803025125376', '15');
INSERT INTO `sr_modulecfg` VALUES ('文档状态', 'int(11)', 'STATE', '1597761805013225473', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802576334848', '15');
INSERT INTO `sr_modulecfg` VALUES ('接口描述', 'varchar(300)', 'EXT_DESC', '1597761805025808384', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803134177280', '15');
INSERT INTO `sr_modulecfg` VALUES ('预留4', 'varchar(64)', 'RESERVE4', '1597761805025808385', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803264200704', '15');
INSERT INTO `sr_modulecfg` VALUES ('开户行号', 'varchar(60)', 'BANK_NO', '1597761805030002688', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802798632960', '15');
INSERT INTO `sr_modulecfg` VALUES ('客户经理', 'varchar(64)', 'CUSTOMER_MANAGER', '1597761805034196992', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802773467136', '15');
INSERT INTO `sr_modulecfg` VALUES ('开户证明附件', 'varchar(512)', 'OPEN_ACCT_CERT_FILE', '1597761805084528640', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802647638016', '15');
INSERT INTO `sr_modulecfg` VALUES ('关联级别', 'int(11)', 'CHAIN_LEVEL', '1597761805088722944', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802723135488', '15');
INSERT INTO `sr_modulecfg` VALUES ('所属产品', 'varchar(64)', 'PRO_CODE', '1597761805092917248', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802970599424', '15');
INSERT INTO `sr_modulecfg` VALUES ('使用后金额', 'decimal(20,2)', 'AFTER_AMT', '1597761805092917249', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803213869056', '15');
INSERT INTO `sr_modulecfg` VALUES ('产品标识', 'varchar(64)', 'PRO_CODE', '1597761805092917250', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802697969664', '15');
INSERT INTO `sr_modulecfg` VALUES ('主营收入(万)', 'decimal(10,2)', 'CORE_INCOME_TOTAL_AMT', '1597761805097111552', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802748301312', '15');
INSERT INTO `sr_modulecfg` VALUES ('客户端类型', 'int(11)', 'CLIENT_TYPE', '1597761805097111553', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803289366528', '15');
INSERT INTO `sr_modulecfg` VALUES ('固定电话', 'varchar(20)', 'PHONE', '1597761805109694464', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802886713344', '15');
INSERT INTO `sr_modulecfg` VALUES ('动账状态', 'int(11)', 'ACTIVE_STATE', '1597761805113888768', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802676998144', '15');
INSERT INTO `sr_modulecfg` VALUES ('协议类型', 'varchar(20)', 'PROTOCOL_TYPE', '1597761805118083072', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803134177280', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建时间', 'datetime', 'CREATE_TIME', '1597761805126471680', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803264200704', '15');
INSERT INTO `sr_modulecfg` VALUES ('开户账号', 'varchar(30)', 'CARD_NO', '1597761805126471681', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802798632960', '15');
INSERT INTO `sr_modulecfg` VALUES ('备注', 'varchar(300)', 'REMARK', '1597761805130665984', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802576334848', '15');
INSERT INTO `sr_modulecfg` VALUES ('企业性质', 'varchar(64)', 'ETPS_ATTR', '1597761805139054592', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802773467136', '15');
INSERT INTO `sr_modulecfg` VALUES ('记录状态', 'int(11)', 'USAGE_STATE', '1597761805407490048', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803213869056', '15');
INSERT INTO `sr_modulecfg` VALUES ('毛利润(万)', 'decimal(10,2)', 'GROSS_MARGIN_AMT', '1597761805407490049', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802748301312', '15');
INSERT INTO `sr_modulecfg` VALUES ('开户证明编号', 'varchar(100)', 'OPEN_ACCT_CERT_NO', '1597761805411684352', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802647638016', '15');
INSERT INTO `sr_modulecfg` VALUES ('收件人地址', 'varchar(512)', 'ADDR', '1597761805411684353', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802886713344', '15');
INSERT INTO `sr_modulecfg` VALUES ('缴纳金额', 'decimal(20,2)', 'AMT', '1597761805415878656', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802697969664', '15');
INSERT INTO `sr_modulecfg` VALUES ('动账方向', 'int(11)', 'ACTIVE_DIRECTION', '1597761805420072960', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802676998144', '15');
INSERT INTO `sr_modulecfg` VALUES ('请求地址', 'varchar(300)', 'URL', '1597761805424267264', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803134177280', '15');
INSERT INTO `sr_modulecfg` VALUES ('电话', 'varchar(20)', 'PHONE', '1597761805432655872', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802798632960', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新时间', 'datetime', 'MODIFY_TIME', '1597761805432655873', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803264200704', '15');
INSERT INTO `sr_modulecfg` VALUES ('企业规模', 'varchar(64)', 'OPERATE_SACLE', '1597761805449433088', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802773467136', '15');
INSERT INTO `sr_modulecfg` VALUES ('已用金额', 'decimal(20,2)', 'USE_AMT', '1597761805575262208', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802697969664', '15');
INSERT INTO `sr_modulecfg` VALUES ('请求方式', 'varchar(10)', 'REQ_METHOD', '1597761805575262209', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803134177280', '15');
INSERT INTO `sr_modulecfg` VALUES ('净利润(万)', 'decimal(10,2)', 'PROFIT_AMT', '1597761805583650816', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802748301312', '15');
INSERT INTO `sr_modulecfg` VALUES ('注册地址', 'varchar(512)', 'REG_ADDR', '1597761805583650817', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802798632960', '15');
INSERT INTO `sr_modulecfg` VALUES ('营业执照文件', 'varchar(64)', 'LICENSE_FILE', '1597761805596233728', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802773467136', '15');
INSERT INTO `sr_modulecfg` VALUES ('创建用户', 'varchar(100)', 'CREATE_BY', '1597761805596233729', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803264200704', '15');
INSERT INTO `sr_modulecfg` VALUES ('备注', 'varchar(300)', 'REMARK', '1597761805596233730', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802676998144', '15');
INSERT INTO `sr_modulecfg` VALUES ('总资产(万)', 'decimal(10,2)', 'TOTAL_ASSETS', '1597761805625593856', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802748301312', '15');
INSERT INTO `sr_modulecfg` VALUES ('默认收件人', 'bigint(20)', 'DEF_RECIPIENT_ID', '1597761805629788160', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802798632960', '15');
INSERT INTO `sr_modulecfg` VALUES ('请求格式', 'varchar(50)', 'REQ_CONTENT_TYPE', '1597761805629788161', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803134177280', '15');
INSERT INTO `sr_modulecfg` VALUES ('营业执照编号', 'varchar(64)', 'LICENSE_NO', '1597761805667536896', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802773467136', '15');
INSERT INTO `sr_modulecfg` VALUES ('验证类型', 'int(11)', 'CHECK_TYPE', '1597761805684314112', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803134177280', '15');
INSERT INTO `sr_modulecfg` VALUES ('更新用户', 'varchar(100)', 'MODIFY_BY', '1597761805688508416', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803264200704', '15');
INSERT INTO `sr_modulecfg` VALUES ('保证金状态', 'int(11)', 'STATE', '1597761805688508417', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802697969664', '15');
INSERT INTO `sr_modulecfg` VALUES ('净资产(万)', 'decimal(10,2)', 'NET_ASSET', '1597761805688508418', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802748301312', '15');
INSERT INTO `sr_modulecfg` VALUES ('营业执照有效期', 'varchar(64)', 'LICENCE_DATE', '1597761805726257152', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802773467136', '15');
INSERT INTO `sr_modulecfg` VALUES ('资产负债表', 'varchar(512)', 'ASSET_LIABILITY_FILE', '1597761805743034368', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802748301312', '15');
INSERT INTO `sr_modulecfg` VALUES ('用户名', 'varchar(100)', 'USER_KEY', '1597761805751422976', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803134177280', '15');
INSERT INTO `sr_modulecfg` VALUES ('企业名称', 'varchar(64)', 'COMPANY_NAME', '1597761805789171712', '', '1', '0', '1590505182045671424', '', '1', '1', '1', '1597761802773467136', '15');
INSERT INTO `sr_modulecfg` VALUES ('利润表', 'varchar(512)', 'INCOME_FILE', '1597761805789171713', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802748301312', '15');
INSERT INTO `sr_modulecfg` VALUES ('密码', 'varchar(512)', 'USER_PWD', '1597761805805948928', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803134177280', '15');
INSERT INTO `sr_modulecfg` VALUES ('统一社会信用代码', 'varchar(64)', 'SOCIAL_CREDIT_CODE', '1597761805835309056', '', '1', '0', '1590505182045671424', '', '1', '1', '1', '1597761802773467136', '15');
INSERT INTO `sr_modulecfg` VALUES ('现金流量表', 'varchar(512)', 'CASH_FILE', '1597761805843697664', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802748301312', '15');
INSERT INTO `sr_modulecfg` VALUES ('公钥', 'varchar(512)', 'PUBLIC_KEY', '1597761805856280576', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803134177280', '15');
INSERT INTO `sr_modulecfg` VALUES ('备注', 'varchar(512)', 'REMARK', '1597761805885640704', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802748301312', '15');
INSERT INTO `sr_modulecfg` VALUES ('企业成立日期', 'date', 'COMPANY_REG_DATE', '1597761805906612224', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802773467136', '15');
INSERT INTO `sr_modulecfg` VALUES ('私钥', 'varchar(512)', 'PRIVATE_ID', '1597761805910806528', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803134177280', '15');
INSERT INTO `sr_modulecfg` VALUES ('注册资本', 'decimal(10,2)', 'REG_CAPITAL', '1597761805961138176', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802773467136', '15');
INSERT INTO `sr_modulecfg` VALUES ('固定KEY', 'varchar(512)', 'FIXED_KEY', '1597761805965332480', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803134177280', '15');
INSERT INTO `sr_modulecfg` VALUES ('企业注册地址', 'varchar(512)', 'REG_ADDR', '1597761806011469824', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802773467136', '15');
INSERT INTO `sr_modulecfg` VALUES ('登录认证', 'varchar(300)', 'LOGIN_URL', '1597761806015664128', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761803134177280', '15');
INSERT INTO `sr_modulecfg` VALUES ('企业通讯地址', 'varchar(512)', 'CONTACT_ADDR', '1597761806061801472', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802773467136', '15');
INSERT INTO `sr_modulecfg` VALUES ('电子签章授权委托书文件', 'varchar(512)', 'SIGN_POWER_ATTORNEY_FILE', '1597761806103744512', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802773467136', '15');
INSERT INTO `sr_modulecfg` VALUES ('法人授权委托书文件', 'varchar(512)', 'ARTIF_POWER_ATTORNEY_FILE', '1597761806158270464', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802773467136', '15');
INSERT INTO `sr_modulecfg` VALUES ('法人证件类型', 'varchar(10)', 'ARTIF_CERTIF_TP', '1597761806204407808', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802773467136', '15');
INSERT INTO `sr_modulecfg` VALUES ('法定代表人', 'varchar(100)', 'ARTIF_NAME', '1597761806254739456', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802773467136', '15');
INSERT INTO `sr_modulecfg` VALUES ('法人证件正面', 'varchar(512)', 'ARTIF_CERTIF_FRONT_FILE', '1597761806326042624', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802773467136', '15');
INSERT INTO `sr_modulecfg` VALUES ('法人证件反面', 'varchar(512)', 'ARTIF_CERTIF_REVERSE_FILE', '1597761806376374272', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802773467136', '15');
INSERT INTO `sr_modulecfg` VALUES ('法人证件号', 'varchar(64)', 'ARTIF_CERTIF_NO', '1597761806426705920', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802773467136', '15');
INSERT INTO `sr_modulecfg` VALUES ('法人证件有效日期', 'date', 'ARTIF_CERTIF_DATE', '1597761806472843264', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802773467136', '15');
INSERT INTO `sr_modulecfg` VALUES ('审核状态', 'varchar(10)', 'AUDIT_STATUS', '1597761806527369216', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802773467136', '15');
INSERT INTO `sr_modulecfg` VALUES ('入驻时间', 'date', 'ENTER_DATE', '1597761806573506560', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802773467136', '15');
INSERT INTO `sr_modulecfg` VALUES ('流程节点', 'varchar(64)', 'PROCESS_NODE', '1597761806615449600', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802773467136', '15');
INSERT INTO `sr_modulecfg` VALUES ('备注', 'varchar(1000)', 'REMARK', '1597761806657392640', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802773467136', '15');
INSERT INTO `sr_modulecfg` VALUES ('变更记录ID', 'varchar(64)', 'MODIFY_RECORD_BATCH_ID', '1597761806711918592', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802773467136', '15');
INSERT INTO `sr_modulecfg` VALUES ('附件信息1', 'varchar(512)', 'ATTACHED_FILE1', '1597761806758055936', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802773467136', '15');
INSERT INTO `sr_modulecfg` VALUES ('附件信息2', 'varchar(512)', 'ATTACHED_FILE2', '1597761806799998976', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802773467136', '15');
INSERT INTO `sr_modulecfg` VALUES ('附件信息3', 'varchar(512)', 'ATTACHED_FILE3', '1597761806850330624', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802773467136', '15');
INSERT INTO `sr_modulecfg` VALUES ('附件信息4', 'varchar(512)', 'ATTACHED_FILE4', '1597761806892273664', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802773467136', '15');
INSERT INTO `sr_modulecfg` VALUES ('附件信息5', 'varchar(512)', 'ATTACHED_FILE5', '1597761806934216704', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1597761802773467136', '15');
INSERT INTO `sr_modulecfg` VALUES ('主键id', 'varchar(10)', 'ID', '1610840854874820608', '', '1', '1', '1590505182045671424', '', '1', '1', '1', '1610840854564442112', '15');
INSERT INTO `sr_modulecfg` VALUES ('地区名称', 'varchar(255)', 'REGION', '1610840855050981376', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1610840854564442112', '15');
INSERT INTO `sr_modulecfg` VALUES ('省', 'varchar(255)', 'PROVINCE', '1610840855172616192', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1610840854564442112', '15');
INSERT INTO `sr_modulecfg` VALUES ('市', 'varchar(255)', 'CITY', '1610840855315222528', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1610840854564442112', '15');
INSERT INTO `sr_modulecfg` VALUES ('区/县', 'varchar(255)', 'COUNTY', '1610840855642378240', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1610840854564442112', '15');
INSERT INTO `sr_modulecfg` VALUES ('区域级别 1.省 2.市 3.县', 'int(11)', 'LEVEL', '1610840855894036480', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1610840854564442112', '15');
INSERT INTO `sr_modulecfg` VALUES ('', 'varchar(10)', 'PROVINCE_CODE', '1610840856036642816', '', '0', '0', '1590505182045671424', '', '1', '1', '1', '1610840854564442112', '15');

-- ----------------------------
-- Table structure for sr_project
-- ----------------------------
DROP TABLE IF EXISTS `sr_project`;
CREATE TABLE `sr_project`  (
  `crt_opr` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建用户',
  `crt_ts` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '创建时间',
  `db_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '数据库',
  `group_member` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '创建时间',
  `id` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '主键',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '项目名称',
  `pkg_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'JAVA包名称',
  `ui_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'UI类型',
  `server_type` char(1) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT '' COMMENT '后台服务类型',
  `driver_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '数据库名称',
  `data_source` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '数据库连接地址',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sr_project
-- ----------------------------
INSERT INTO `sr_project` VALUES ('sirui', '20201221155918', 'mysql', '4', '1', '代码生成器', 'openai-go', 'HeyUI', '1', NULL, NULL);
INSERT INTO `sr_project` VALUES ('sirui', '20220419162231', 'mysql', '4', '1516331395016822784', '舆情系统mysql', 'yq.cloud', 'HeyUI', '1', 'mysql', 'root:wisesoft@tcp(172.16.9.19:3306)/zshl_yuqing_4.0?charset=utf8');
INSERT INTO `sr_project` VALUES ('sirui', '20220621102311', 'mysql', '4', '1539071400248086528', '舆情GP数据库', 'yq.cloud', 'HeyUI', '1', 'mysql', 'root:wisesoft@tcp(172.16.9.19:3306)/yq_data?charset=utf8');
INSERT INTO `sr_project` VALUES ('sirui', '20221110084240', 'mysql', '1596031432721960960', '1590505182045671424', '供应链金融', 'scm.finance', 'HeyUI', '2', '', 'root:wisesoft@tcp(172.16.9.19:3306)/scm_finance?charset=utf8');

-- ----------------------------
-- Table structure for sys_apps
-- ----------------------------
DROP TABLE IF EXISTS `sys_apps`;
CREATE TABLE `sys_apps`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `app_name` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '应用名',
  `app_no` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '应用标识',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_id` bigint(20) NOT NULL COMMENT '创建人',
  `update_id` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_apps
-- ----------------------------
INSERT INTO `sys_apps` VALUES (8150413474887958528, 'test', '111', '2021-11-20 22:56:53', '2021-11-20 22:56:53', 122, NULL);
INSERT INTO `sys_apps` VALUES (8150413615449047040, 'test', '111', '2021-11-20 22:57:27', '2021-11-20 22:57:27', 111, NULL);
INSERT INTO `sys_apps` VALUES (8150413728615563264, 'test', '111', '2021-11-20 22:57:54', '2021-11-20 22:57:54', 111, NULL);
INSERT INTO `sys_apps` VALUES (8150413769350643712, 'test', '111', '2021-11-20 22:58:03', '2021-11-20 22:58:03', 111, NULL);
INSERT INTO `sys_apps` VALUES (8150413774593523712, 'test', '111', '2021-11-20 22:58:04', '2021-11-20 22:58:04', 111, NULL);
INSERT INTO `sys_apps` VALUES (8150414834899419136, 'test', '111', '2021-11-20 23:02:17', '2021-11-20 23:02:17', 111, NULL);

-- ----------------------------
-- Table structure for sys_buttons
-- ----------------------------
DROP TABLE IF EXISTS `sys_buttons`;
CREATE TABLE `sys_buttons`  (
  `id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `title` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `click` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `icon` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  `state` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  `order_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_buttons
-- ----------------------------
INSERT INTO `sys_buttons` VALUES ('1', '新增', 'add', 'h-icon-plus', '1', 1);
INSERT INTO `sys_buttons` VALUES ('2', '编辑', 'edit', 'h-icon-edit', '0', 2);
INSERT INTO `sys_buttons` VALUES ('3', '删除', 'del', 'h-icon-trash', '0', 3);
INSERT INTO `sys_buttons` VALUES ('4', '查看', 'see', 'h-icon-task', '0', 4);
INSERT INTO `sys_buttons` VALUES ('6', '编译', 'generator', '', '1', 5);
INSERT INTO `sys_buttons` VALUES ('7', '配置文档', 'download', '', '1', 6);
INSERT INTO `sys_buttons` VALUES ('8', '数据库文档', 'downDoc', '', '1', 1);

-- ----------------------------
-- Table structure for sys_menus
-- ----------------------------
DROP TABLE IF EXISTS `sys_menus`;
CREATE TABLE `sys_menus`  (
  `id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '自增编号',
  `title` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单名称',
  `url` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '访问地址',
  `icon` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '菜单图标',
  `super_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '上级编号',
  `btn_id` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '支持按钮',
  `menu_order` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menus
-- ----------------------------
INSERT INTO `sys_menus` VALUES ('1', '系统管理', '', 'h-icon-home', '', '', '1');
INSERT INTO `sys_menus` VALUES ('10', '项目管理', '', 'h-icon-star', '', '', '2');
INSERT INTO `sys_menus` VALUES ('11', '我的项目', '/srproject', '', '10', '1,2,3,4,6,7,8', '1');
INSERT INTO `sys_menus` VALUES ('12', '我的模块', '/srmodular', '', '10', '1,2,3,4', '2');
INSERT INTO `sys_menus` VALUES ('13', '模块配置', '/srmodulecfg', '', '10', '1,2,3,4', '3');
INSERT INTO `sys_menus` VALUES ('14', '我的团队', '/srgroupmember', '', '10', '1,2,3,4', '0');
INSERT INTO `sys_menus` VALUES ('15', '配置中心', '', 'h-icon-setting', '', '', '3');
INSERT INTO `sys_menus` VALUES ('1553579913691271168', '数据库类型', '/sidatabasetype', '', '15', '1,2,3,4', '2');
INSERT INTO `sys_menus` VALUES ('16', '代码配置', '/sitemplates', '', '15', '1,2,3,4', '0');
INSERT INTO `sys_menus` VALUES ('2', '菜单管理', '/sysmenus', '', '1', '1,2,3,4,5', '2');
INSERT INTO `sys_menus` VALUES ('3', '用户管理', '/sysusers', '', '1', '1,2,3,4,5', '3');
INSERT INTO `sys_menus` VALUES ('4', '字典管理', '/sysparams', '', '1', '1,2,3,4,5', '4');
INSERT INTO `sys_menus` VALUES ('5', '按钮管理', '/sysbuttons', '', '1', '1,2,3,4', '5');
INSERT INTO `sys_menus` VALUES ('6', '角色管理', '/sysroles', '', '1', '1,2,3,4,5', '6');
INSERT INTO `sys_menus` VALUES ('8', '功能管理', '/sysrolemenu', '', '1', '2', '0');

-- ----------------------------
-- Table structure for sys_params
-- ----------------------------
DROP TABLE IF EXISTS `sys_params`;
CREATE TABLE `sys_params`  (
  `id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '自增编号',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '参数名称',
  `key_id` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '参数值',
  `group_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分组名称',
  `group_id` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分组编号',
  `other_value` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '其它值',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_params
-- ----------------------------
INSERT INTO `sys_params` VALUES ('1', '正常', '1', '状态', 'State', '1');
INSERT INTO `sys_params` VALUES ('10', 'text', 'text', 'Mysql常用数据类型', 'MysqlDataType', '');
INSERT INTO `sys_params` VALUES ('11', 'decimal(10,2)', 'decimal(10,2)', 'Mysql常用数据类型', 'MysqlDataType', '');
INSERT INTO `sys_params` VALUES ('12', 'INTEGER', 'INTEGER', 'Oracle常用数据类型', 'OracleDataType', '');
INSERT INTO `sys_params` VALUES ('13', 'VARCHAR2(19)', 'VARCHAR2(19)', 'Oracle常用数据类型', 'OracleDataType', '');
INSERT INTO `sys_params` VALUES ('1381603381189021696', 'varchar(64)', 'varchar(64)', 'Mysql常用数据类型', 'MysqlDataType', '');
INSERT INTO `sys_params` VALUES ('1381603522067304448', 'varchar(128)', 'varchar(128)', 'Mysql常用数据类型', 'MysqlDataType', '');
INSERT INTO `sys_params` VALUES ('1381603617059901440', 'VARCHAR2(200)', 'VARCHAR2(200)', 'Oracle常用数据类型', 'OracleDataType', '');
INSERT INTO `sys_params` VALUES ('1381603650756939776', 'VARCHAR2(100)', 'VARCHAR2(100)', 'Oracle常用数据类型', 'OracleDataType', '');
INSERT INTO `sys_params` VALUES ('1381603696101560320', 'VARCHAR2(50)', 'VARCHAR2(50)', 'Oracle常用数据类型', 'OracleDataType', '');
INSERT INTO `sys_params` VALUES ('14', 'CHAR(1)', 'CHAR(1)', 'Oracle常用数据类型', 'OracleDataType', '');
INSERT INTO `sys_params` VALUES ('15', 'LONG', 'LONG', 'Oracle常用数据类型', 'OracleDataType', '');
INSERT INTO `sys_params` VALUES ('1515637429535510528', 'tinyint(1)', 'tinyint(1)', 'Mysql常用数据类型', 'MysqlDataType', '');
INSERT INTO `sys_params` VALUES ('1515637503690805248', 'int', 'int', 'Mysql常用数据类型', 'MysqlDataType', '');
INSERT INTO `sys_params` VALUES ('1515637749409910784', 'bigint(20)', 'bigint(20)', 'Mysql常用数据类型', 'MysqlDataType', '');
INSERT INTO `sys_params` VALUES ('1515637844406702080', 'datetime', 'datetime', 'Mysql常用数据类型', 'MysqlDataType', '');
INSERT INTO `sys_params` VALUES ('1515637907216404480', 'date', 'date', 'Mysql常用数据类型', 'MysqlDataType', '');
INSERT INTO `sys_params` VALUES ('1515637952678465536', 'time', 'time', 'Mysql常用数据类型', 'MysqlDataType', '');
INSERT INTO `sys_params` VALUES ('1515640241661153280', 'Element', 'Element', '页面类型', 'UiType', '');
INSERT INTO `sys_params` VALUES ('16', 'DECIMAL(10,2)', 'DECIMAL(10,2)', 'Oracle常用数据类型', 'OracleDataType', '');
INSERT INTO `sys_params` VALUES ('1610832915074125824', 'smart-doc项目模板', '2', '后台类型', 'ServerType', '');
INSERT INTO `sys_params` VALUES ('17', '文本', '文本', '组件类型', 'WidgetType', '');
INSERT INTO `sys_params` VALUES ('18', '下拉', '下拉', '组件类型', 'WidgetType', '');
INSERT INTO `sys_params` VALUES ('19', '分页下拉', '分页下拉', '组件类型', 'WidgetType', '');
INSERT INTO `sys_params` VALUES ('2', '男', '1', '性别', 'Sex', '1');
INSERT INTO `sys_params` VALUES ('20', '日期', '日期', '组件类型', 'WidgetType', '');
INSERT INTO `sys_params` VALUES ('21', '上传', '上传', '组件类型', 'WidgetType', '');
INSERT INTO `sys_params` VALUES ('22', 'JAVA', '1', '模板类型', 'TemplateType', '');
INSERT INTO `sys_params` VALUES ('23', 'GO', '2', '模板类型', 'TemplateType', '');
INSERT INTO `sys_params` VALUES ('24', '前端', '3', '模板类型', 'TemplateType', '');
INSERT INTO `sys_params` VALUES ('25', '是', '1', '是否组件', 'IsFormType', '');
INSERT INTO `sys_params` VALUES ('26', '否', '2', '是否组件', 'IsFormType', '');
INSERT INTO `sys_params` VALUES ('27', '默认HeyUI', 'HeyUI', '页面类型', 'UiType', '');
INSERT INTO `sys_params` VALUES ('28', 'swagger项目模板', '1', '后台类型', 'ServerType', '');
INSERT INTO `sys_params` VALUES ('3', '女', '0', '性别', 'Sex', '2');
INSERT INTO `sys_params` VALUES ('4', '禁用', '0', '状态', 'State', '2');
INSERT INTO `sys_params` VALUES ('5', 'mysql', 'mysql', '数据库类型', 'DbType', '');
INSERT INTO `sys_params` VALUES ('6', 'oracle', 'oracle', '数据库类型', 'DbType', '');
INSERT INTO `sys_params` VALUES ('8', 'varchar(20)', 'varchar(20)', 'Mysql常用数据类型', 'MysqlDataType', '');
INSERT INTO `sys_params` VALUES ('9', 'char(1)', 'char(1)', 'Mysql常用数据类型', 'MysqlDataType', '');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色编号',
  `menu_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单编号',
  `button_ids` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '按钮编号'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES ('1', '10', '');
INSERT INTO `sys_role_menu` VALUES ('1', '11', '1,2,3,4,6,7,8');
INSERT INTO `sys_role_menu` VALUES ('1', '12', '1,2,3,4');
INSERT INTO `sys_role_menu` VALUES ('1', '13', '1,2,3,4');
INSERT INTO `sys_role_menu` VALUES ('1', '1', '');
INSERT INTO `sys_role_menu` VALUES ('1', '2', '1,2,3,4,5');
INSERT INTO `sys_role_menu` VALUES ('1', '3', '1,2,3,4,5');
INSERT INTO `sys_role_menu` VALUES ('1', '4', '1,2,3,4,5');
INSERT INTO `sys_role_menu` VALUES ('1', '5', '1,2,3,4');
INSERT INTO `sys_role_menu` VALUES ('1', '6', '1,2,3,4,5');
INSERT INTO `sys_role_menu` VALUES ('1', '8', '2');
INSERT INTO `sys_role_menu` VALUES ('1', '14', '1,2,3,4');
INSERT INTO `sys_role_menu` VALUES ('61', '10', '');
INSERT INTO `sys_role_menu` VALUES ('61', '11', '1,2,3,4,6,7,8');
INSERT INTO `sys_role_menu` VALUES ('61', '12', '1,2,3,4');
INSERT INTO `sys_role_menu` VALUES ('61', '13', '1,2,3,4');
INSERT INTO `sys_role_menu` VALUES ('62', '1', '');
INSERT INTO `sys_role_menu` VALUES ('62', '3', '1,2,3,4,5');
INSERT INTO `sys_role_menu` VALUES ('62', '6', '1,2,3,4,5');
INSERT INTO `sys_role_menu` VALUES ('62', '10', '');
INSERT INTO `sys_role_menu` VALUES ('62', '11', '1,2,3,4,6,7,8');
INSERT INTO `sys_role_menu` VALUES ('62', '12', '1,2,3,4');
INSERT INTO `sys_role_menu` VALUES ('62', '13', '1,2,3,4');
INSERT INTO `sys_role_menu` VALUES ('62', '14', '1,2,3,4');
INSERT INTO `sys_role_menu` VALUES ('1', '15', '');
INSERT INTO `sys_role_menu` VALUES ('1', '16', '1,2,3,4');
INSERT INTO `sys_role_menu` VALUES ('62', '15', '');
INSERT INTO `sys_role_menu` VALUES ('62', '16', '1,2,3,4');
INSERT INTO `sys_role_menu` VALUES ('61', '14', '1,2,3,4');
INSERT INTO `sys_role_menu` VALUES ('1516772635873120256', '1', '');
INSERT INTO `sys_role_menu` VALUES ('1516772635873120256', '2', '1,2,3,4,5');
INSERT INTO `sys_role_menu` VALUES ('1516772635873120256', '3', '1,2,3,4,5');
INSERT INTO `sys_role_menu` VALUES ('1516772635873120256', '4', '1,2,3,4,5');
INSERT INTO `sys_role_menu` VALUES ('1516772635873120256', '5', '1,2,3,4');
INSERT INTO `sys_role_menu` VALUES ('1516772635873120256', '6', '1,2,3,4,5');
INSERT INTO `sys_role_menu` VALUES ('1516772635873120256', '8', '2');
INSERT INTO `sys_role_menu` VALUES ('1516772635873120256', '10', '');
INSERT INTO `sys_role_menu` VALUES ('1516772635873120256', '11', '1,2,3,4,6,7,8');
INSERT INTO `sys_role_menu` VALUES ('1516772635873120256', '12', '1,2,3,4');
INSERT INTO `sys_role_menu` VALUES ('1516772635873120256', '13', '1,2,3,4');
INSERT INTO `sys_role_menu` VALUES ('1516772635873120256', '14', '1,2,3,4');
INSERT INTO `sys_role_menu` VALUES ('1516772635873120256', '15', '');
INSERT INTO `sys_role_menu` VALUES ('1516772635873120256', '16', '1,2,3,4');
INSERT INTO `sys_role_menu` VALUES ('1', '1553579913691271168', '1,2,3,4');
INSERT INTO `sys_role_menu` VALUES ('62', '1553579913691271168', '1,2,3,4');

-- ----------------------------
-- Table structure for sys_roles
-- ----------------------------
DROP TABLE IF EXISTS `sys_roles`;
CREATE TABLE `sys_roles`  (
  `id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_roles
-- ----------------------------
INSERT INTO `sys_roles` VALUES ('1', '管理员');
INSERT INTO `sys_roles` VALUES ('61', '成员权限');
INSERT INTO `sys_roles` VALUES ('62', '团队管理员');

-- ----------------------------
-- Table structure for sys_users
-- ----------------------------
DROP TABLE IF EXISTS `sys_users`;
CREATE TABLE `sys_users`  (
  `account` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '账号',
  `pass` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '姓名',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '手机号',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '邮箱',
  `sex` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '性别',
  `age` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '年龄',
  `role_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色权限',
  PRIMARY KEY (`account`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_users
-- ----------------------------
INSERT INTO `sys_users` VALUES ('admin', 'C7F66BEEE198FB411C8623E53CBBC6EB1E0F078B5D68ED7F10D02FFB0AF46D44', '管理员', '15308066831', 'srandroid@163.com', '1', '28', '1');
INSERT INTO `sys_users` VALUES ('hxx', 'C7F66BEEE198FB411C8623E53CBBC6EB1E0F078B5D68ED7F10D02FFB0AF46D44', '胡晓曦', '111111', '', '1', '33', '1');
INSERT INTO `sys_users` VALUES ('sirui', 'C3700577ECBA8831FEF7B7C988D707C85BD48BEBE5386280AEEE7C40752CE8F2', '司锐', '15308066831', 'srandroid@163.com', '1', '28', '1');
INSERT INTO `sys_users` VALUES ('wisesoft', '07F35964346410D8178FEF21030A41EFB892DFA311EBC92DE8605A84C1293535', '公共账号', '11111111111', '', '1', '22', '61');

SET FOREIGN_KEY_CHECKS = 1;
