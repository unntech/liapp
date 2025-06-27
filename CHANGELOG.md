CHANGELOG
=========

### v2.0.5 `2025-06-25`

### v2.0.4 `2025-06-22`
* 更新变量及文件名规范，要求`unntech/liphp`: `>=2.0.3`

### v2.0.3 `2025-06-17`
* 保存的用户登入密码哈希值由sha1改为SHA256，提高密码保存安全性
* 启动自动载入 Logger 日志记录标准类
* Template init() 第一个参数改传模版文件根路径

### v2.0.2 `2025-06-14`
* 修复 `App\admin\auth` `hasLogin` 的BUG
* 完善 authorize 获取 access_token 示例，以及 ApiAuthorize 对 access_token 的验证示例

### v2.0.1 `2025-06-08`
* 从`unntech/liteapp`引用版本, 优化PHP8强类型（严格模式），更多使用PHP8的新特性
* 增加环境变量 .env 配置，方便不同环境服务器切换部署
* 统一Response格式，方式数据交互对接，使用 `UNNTech\Encrypt\Response` 输出格式标准
* 把ajax请求的`token`名统一为服务端签发的用户登入`token`（没有为空）；原来的`apiToken`更换为`access_token`；统一变量名规范