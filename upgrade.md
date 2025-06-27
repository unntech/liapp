从 LiteApp 1 升级到 2
===============

### 命名空间规则修改
* LiteApp 改 App
* LitePhp 改 LiPhp

### 配置文件
* config/app.php  增加 `'version'       => '2.0.1'` 用于定义本身项目版本号
* 调用版本号的变量`$version` 变更用常量 `APP_VERSION`
* 增加 Env 环境变量，参见 config.sample 里的示例使用

### 基础类调整及目录路径调整
* 基础类 app 改：App\framework\AppBase
* App\framework\Controller
* App\framework\ModelBase

### Template模版文件
* `$auth->authNode` 替换：`auth_node_auth`
* `auth_nodeHref` 替换：`auth_node_href`
* 因后端API输出格式统一，所以ajax接收到的内容直接是JSON，无需再JSON.parse
* 数据集结构也统一改变为：https://github.com/unntech/encrypt/blob/main/src/encrypt.md
* `errcode`, `msg`信息放到`head`里，`data`放至`body`里
* 修改所有`adminComm.post`请求结果处理

### 程序语法的调整
* 数据连接语句 `$Lite->db` 替换： `LiApp::$db`   (需先 use App\framework\LiApp)
* 原来的`apiToken`更换为`access_token`；统一变量名规范
* `Response` 统一改用 `App\framework\Response`，其它类弃用
* 移除 `admin/auth.inc.php`，鉴权载入改用： `$Loader = auth::instance()->Loader()`
* 原先的一些变量如 `pageStart`, `isAjax`, `postData` 等全局变量，改放入 `$Loader` 里

### 其它自行编写的文件及代码
* 更据实现情况修改