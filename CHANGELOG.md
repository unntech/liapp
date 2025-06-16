CHANGELOG
=========

### v2.0.2 `2025-06-14`
* 修复 `App\admin\auth` `hasLogin` 的BUG
* 完善 authorize 获取 access_token 示例，以及 ApiAuthorize 对 access_token 的验证示例

### v2.0.1 `2025-06-08`
* 从`unntech/liteapp`引用版本, 优化PHP8强类型（严格模式），更多使用PHP8的新特性
* 增加环境变量 .env 配置，方便不同环境服务器切换部署
* 统一Response格式，方式数据交互对接，使用 `UNNTech\Encrypt\Response` 输出格式标准
* 把ajax请求的`token`名统一为服务端签发的用户登入`token`（没有为空）；原来的`apiToken`更换为`access_token`；统一变量名规范