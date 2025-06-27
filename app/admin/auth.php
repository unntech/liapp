<?php

namespace App\admin;

use App\framework\AppBase;
use LiPhp\GoogleAuthenticator;
use LiPhp\Models\MySqliResult;
use LiPhp\Template;
use App\framework\LiApp;
use App\framework\extend\Redis;
use LiPhp\LiHttp;
use LiPhp\LiComm;
use App\framework\Response;

class auth extends AppBase
{
    const menuNodeCache = false;  //菜单权限列表是否缓存，生产环境建议开启，需要配置redis参数
    const NonceId = '';           //随机盐值，增加安全性
    const LoginUri = '/admin/index.php';
    const LoginTokenExpire = 86400;
    public bool $loginSuccess = false;
    public static int $curUserId = 0;
    protected array $user = ['id' => 0];
    protected array $menu = [];
    protected array $node = [];
    protected array $nodePathId = [];
    const status = ['正常', '禁用', '锁定'];
    public array $adminTag = ['标准用户', '超级管理员', '自定义'];
    public int $activeMenu = 0;
    protected static $instance;

    use \App\traits\crypt;

    public function __construct()
    {
        parent::__construct();
        static::$instance = $this;
    }

    /**
     * 静状实例化
     * @return auth | null
     */
    public static function instance(): ?auth
    {
        if (!static::$instance) static::$instance = new static();
        return static::$instance;
    }

    /**
     * 是否登入状态
     * @return bool
     */
    public function isLogin(): bool
    {
        return $this->loginSuccess;
    }

    /**
     * 当前登入用户信息
     * @return int[]
     */
    public function curUser(): array
    {
        return $this->user;
    }

    /**
     * 当前登入用户ID
     * @return int
     */
    public function curUserId(): int
    {
        return $this->user['id'];
    }

    /**
     * 获取菜单列表
     * @return array
     */
    public function getMenu(): array
    {
        return $this->menu;
    }

    /**
     * 获取权限节点列表
     * @return array
     */
    public function getNode(): array
    {
        return $this->node;
    }

    /**
     * 验证节权权限
     * @param int|array|string $authId
     * @param bool $tag 为true时，如果验证无权则直接退出
     * @return bool
     */
    public function authNode(int|array|string $authId, bool $tag = false): bool
    {
        if(is_array($authId)){
            if(empty($authId)){
                return true;
            }
            $auth = false;
            foreach($authId as $v){
                if(!is_numeric($v)){
                    $v = $this->nodePathId[$v] ?? -1;
                }
                if(array_key_exists($v, $this->node)){
                    $auth = true;
                    break;
                }
            }
        }else{
            if(!is_numeric($authId)){
                $authId = $this->nodePathId[$authId] ?? -1;
            }
            if ($authId == 0) {
                return true;
            }

            $auth =  array_key_exists($authId, $this->node);
        }
        if($tag && $auth == false){
            $this->message('对不起，您无权限进行此操作！', '错误提示');
        }
        return $auth;
    }

    /**
     * 设置激活菜单项
     * @param $id
     * @return void
     */
    public function activeMenu($id): void
    {
        if (isset($this->node[$id]) && $this->node[$id]['pid'] > 0) {
            $this->menu[$this->node[$id]['pid']]['menuShow'] = true;
        }

    }

    /**
     * 获取节点名
     * @param $id
     * @return string
     */
    public function nodeName($id): string
    {
        if ($id == 0) {
            return config('app.name');
        }
        return $this->node[$id]['title'] ?? '';
    }

    /**
     * 获取节点链接
     * @param int|string $authId
     * @return string
     */
    public function nodeHref(int|string $authId): string
    {
        if(!is_numeric($authId)){
            $authId = $this->nodePathId[$authId] ?? -1;
        }
        return $this->node[$authId]['href'] ?? '';
    }

    /**
     * 判断是否已登入
     * @return array
     */
    public function hasLogin(): array
    {
        $apiToken = $this->getToken(['sub'=>0], 1800);
        $ret = ['login'=>false, 'access_token'=>$apiToken, 'token'=>''];
        $userid = session('admin.id');
        if(empty($userid)){
            return $ret;
        }
        $liAdminToken = get_cookie('LiAdmin'.self::NonceId);
        $verify = $this->verifyToken($liAdminToken,self::NonceId);
        if ($verify === false || $userid != $verify['sub']) {
            return $ret;
        } else {
            $user = $this->db->table('admin')->where(['id' => $verify['sub']])->selectOne();

            return [
                'login'        => true,
                'access_token' => $this->getToken(['sub' => (int)$userid], 7200),
                'id'           => (int)$user['id'],
                'username'     => $user['username'],
                'nickname'     => $user['nickname'],
                'token'        => $liAdminToken,
            ];
        }
    }

    /**
     * 登入鉴权
     * @return bool
     */
    public function auth(): bool
    {
        $userid = session('admin.id');
        if(empty($userid)){
            return false;
        }
        $liAdminToken = get_cookie('LiAdmin'.self::NonceId);
        $verify = $this->verifyToken($liAdminToken, self::NonceId);
        if ($verify === false || $userid != $verify['sub']) {
            return false;
        } else {
            $this->loginSuccess = true;
            $user = $this->db->table('admin')->where(['id' => $verify['sub']])->selectOne();
            self::$curUserId = (int)$user['id'];
            $this->user = [
                'id'        => (int)$user['id'],
                'username'  => $user['username'],
                'nickname'  => $user['nickname'],
                'status'    => (int)$user['status'],
                'login_num' => (int)$user['login_num'],
                'auth_ids'  => empty($user['auth_ids']) ? '0' : $user['auth_ids'],
                'authPrivs' => empty($user['auth_priv']) ? [] : explode(',', $user['auth_priv']),
                'admin'     => (int)$user['admin'],
                'params'    => empty($user['params']) ? [] : json_decode($user['params'], true),
            ];

            $this->updateMenuNode();

            return true;
        }

    }

    /**
     * 登入
     * @param string $username
     * @param string $passwd
     * @param string $authenticator
     * @return object
     */
    public function login(string $username, string $passwd, string $authenticator = ''): object
    {
        $username = $this->db->removeEscape($username);
        $user = $this->db->table('admin')->where(['username' => $username])->selectOne();
        if (!$user) {
            return (object)['errcode' => 1, 'msg' => '用户不存在！'];
        }
        if ($user['status'] != 0) {
            return (object)['errcode' => 2, 'msg' => '账号已被禁用或已删除'];
        }
        if (!$this->password_verify($passwd, $user['psw'])) {
            return (object)['errcode' => 3, 'msg' => '密码输入有误'];
        }
        if (!empty($user['authenticator'])) {
            $ga = new GoogleAuthenticator(); //谷歌验证器示例
            $_check_google = $ga->verifyCode($user['authenticator'], $authenticator);
            if (!$_check_google) {
                return (object)['errcode' => 4, 'msg' => '动态码二次验证失败'];
            }
        }

        $user['id'] = (int)$user['id'];
        $this->loginSuccess = true;
        self::$curUserId = $user['id'];
        $this->user = [
            'id'        => $user['id'],
            'username'  => $user['username'],
            'nickname'  => $user['nickname'],
            'status'    => $user['status'],
            'login_num' => $user['login_num'],
            'auth_ids'  => empty($user['auth_ids']) ? '0' : $user['auth_ids'],
            'authPrivs' => empty($user['auth_priv']) ? [] : explode(',', $user['auth_priv']),
            'admin'     => $user['admin'],
            'params'    => empty($user['params']) ? [] : json_decode($user['params'], true),
        ];

        //登入成功，写入登入日志
        $this->db->table('admin')->where(['id' => $user['id']])->update(['login_num' => ['INC',1]]);
        $content = json_encode(['username' => $username, 'authenticator' => $authenticator]);
        $this->aLog('登入成功', $content);

        $this->updateMenuNode(true);

        $jwt = ['sub' => $user['id']];
        $token = $this->getToken($jwt, self::LoginTokenExpire, self::NonceId);
        set_cookie('LiAdmin'.self::NonceId, $token);
        session('admin', ['id'=>$user['id'], 'username'=>$user['username']]);
        return (object)['errcode' => 0, 'msg' => '登入成功！', 'token'=>$token];
    }

    /**
     * 获取用户的菜单和节点权限，生产环境建议缓存起来，不用每次读库
     * @param bool $tag 为true时强制更新
     * @return void
     */
    protected function updateMenuNode(bool $tag = false): void
    {
        if(self::menuNodeCache){
            LiApp::set_redis();
        }
        $user = $this->user;
        if(!$tag && self::menuNodeCache){  //不强制更新先偿试读缓存
            $_g = true;
            $_c = Redis::get('adminMenu'.self::NonceId.'_'.$user['id']);
            if(!empty($_c)){
                $this->menu = json_decode($_c, true);
            }else{
                $_g = false;
            }
            $_c = Redis::get('adminNode'.self::NonceId.'_'.$user['id']);
            if(!empty($_c)){
                $this->node = json_decode($_c, true);
            }else{
                $_g = false;
            }
            if($_g){
                return;
            }
        }

        $_aIds = $this->db->table('admin_auth')->where("id IN ({$user['auth_ids']})")->fields("GROUP_CONCAT(rules)")->getValue();
        $authIds = empty($_aIds) ? [] : explode(',', $_aIds);
        $authIds = array_merge($authIds, $this->user['authPrivs']);
        //获取菜单权限
        if ($user['admin'] == 1) {
            $res = $this->db->table( 'admin_node')->where(['is_menu' => 1, 'status' => 1])->order('pid, sort desc')->select();
        } else {
            $res = $this->db->table('admin_node')->where(['is_menu' => 1, 'status' => 1, 'id' => ['IN', $authIds]])->order('pid, sort desc')->select();
        }
        $node = [];
        while ($r = $res->fetch_assoc()) {
            if (empty($r['node'])) {
                $href = "javascript:treeviewopen({$r['id']});";
            } else {
                if (str_starts_with($r['node'], '@')){
                    $_url = substr($r['node'], 1);
                    $href = '/route.php/'.$_url;
                } elseif ($_rpos = strrpos($r['node'], '#')) {
                    $action = substr($r['node'], $_rpos + 1);
                    $_url = substr($r['node'], 0, $_rpos);
                    $href = '/' . $_url . '.php?action=' . $action . '&';
                } else {
                    $href = '/' . $r['node'] . '.php';
                }
            }
            //$href = empty($r['node']) ? "javascript:treeviewopen({$r['id']});" : '/'.$r['node'].'.php';
            if ($r['pid'] == 0) {
                $node[$r['id']] = ['id' => $r['id'], 'node' => $r['node'], 'title' => $r['title'], 'sort' => $r['sort'], 'icon' => $r['icon'], 'href' => $href];
            } else {
                $node[$r['pid']]['sub'][$r['id']] = ['id' => $r['id'], 'node' => $r['node'], 'title' => $r['title'], 'sort' => $r['sort'], 'icon' => $r['icon'], 'href' => $href];
            }
        }
        $this->menu = $node;

        //获取权限节点
        if ($user['admin'] == 1) {
            $res = $this->db->table('admin_node')->where(['status' => 1])->order('sort')->select();
        } else {
            $res = $this->db->table('admin_node')->where(['status' => 1, 'id' => ['IN', $authIds]])->order('sort')->select();
        }
        $node = [];
        $nodePathId = [];
        while ($r = $res->fetch_assoc()) {
            if (empty($r['node'])) {
                $href = "javascript:void(0);";
            } else {
                if (strpos($r['node'], '@') === 0){
                    $_url = substr($r['node'], 1);
                    $href = '/route.php/'.$_url;
                } elseif ($_rpos = strrpos($r['node'], '#')) {
                    $action = substr($r['node'], $_rpos + 1);
                    $_url = substr($r['node'], 0, $_rpos);
                    $href = '/' . $_url . '.php?action=' . $action . '&';
                } else {
                    $href = '/' . $r['node'] . '.php';
                }
                $nodePathId[$r['node']] = (int)$r['id'];
            }
            //$href = empty($r['node']) ? "javascript:void(0);" : '/'.$r['node'].'.php';
            $node[$r['id']] = ['id' => $r['id'], 'node' => $r['node'], 'title' => $r['title'], 'sort' => $r['sort'], 'icon' => $r['icon'], 'pid' => $r['pid'], 'href' => $href];
        }
        $this->node = $node;
        $this->nodePathId = $nodePathId;

        if(self::menuNodeCache){
            Redis::set('adminMenu'.self::NonceId.'_'.$user['id'], json_encode($this->menu), 7200);
            Redis::set('adminNode'.self::NonceId.'_'.$user['id'], json_encode($this->node), 7200);
        }
    }

    /**
     * 生成密码哈希
     * @param string $password
     * @return string
     */
    public function password(string $password): string
    {
        //$hash = password_hash($value, PASSWORD_BCRYPT); // 生成哈希
        //$hash = sha1($password);
        return hash("sha256", $password);
    }

    public function password_verify(string $password, string $hash): bool
    {
        //$v = password_verify($password, $hash);
        $hl = strlen($hash);
        if($hl < 60){
            $_hash = sha1($password);
        }else{
            $_hash = hash("sha256", $password);
        }
        return $_hash == $hash;
    }

    /**
     * 写入管理员操作日志
     * @param string $title
     * @param string $content
     * @return false|int|MySqliResult|string
     */
    public function aLog(string $title, string $content = '')
    {
        return $this->adminLog(
            [
                'admin_id' => $this->user['id'],
                'nickname' => $this->user['nickname'],
                'url'      => $_SERVER['REQUEST_URI'],
                'title'    => $title,
                'content'  => $content,
            ]
        );
    }

    public function adminLog(array $data)
    {
        $data['ip'] = $this->DT_IP;
        $data['addtime'] = $this->DT_TIME;
        return $this->db->table('admin_log')->insert($data);
    }

    /**
     * 读取管理员用户表信息
     * @param $id
     * @return array|false
     */
    public function getAdminUser($id): bool|array
    {
        $row = $this->db->table('admin')->where(['id' => $id])->selectOne();
        if(!$row){
            return false;
        }
        $row['id'] = (int)$row['id'];
        $row['auths'] = empty($row['auth_ids']) ? [] : $this->getAdminAuths($row['auth_ids']);
        $row['params'] = empty($row['params']) ? [] : json_decode($row['params'], true);
        $row['authPrivs'] = empty($row['auth_priv']) ? [] : explode(',', $row['auth_priv']);
        return $row;
    }

    /**
     * 读取角色权限信息
     * @param $id
     * @return array|false
     */
    public function getAdminAuth($id)
    {
        return $this->db->table('admin_auth')->where(['id' => $id])->selectOne();
    }

    /**
     * 读取所有角色权限表数据
     * @param $ids
     * @return array
     */
    public function getAdminAuths($ids = null): array
    {
        if (is_null($ids)) {
            $res = $this->db->table( 'admin_auth')->fields(['id', 'title'])->where(['status' => 1])->select();
        } else {
            $res = $this->db->table( 'admin_auth')->fields(['id', 'title'])->where(['id' => ['IN', explode(',', $ids)]])->select();
        }
        $ret = [];
        while ($r = $res->fetch_assoc()) {
            $ret[$r['id']] = $r['title'];
        }
        return $ret;
    }

    /**
     * 读取节点信息
     * @param $id
     * @return array|false
     */
    public function getAdminNode($id)
    {
        return $this->db->table('admin_node')->where(['id'=>$id])->selectOne();
    }

    /**
     * 获取当用活动页列表
     * @param int $activeMenu
     * @return array
     */
    public function presentation(int $activeMenu): array
    {
        $maxPresentation =config('admin.presentation', 10);
        $presentation = json_decode(base64_decode(get_cookie('presentation'.$this->user['id'])), true);
        if(empty($presentation)){
            $presentation = [];
        }
        if($activeMenu > 0 && !isset($_GET['toolbarExport'])){
            $presentation[$activeMenu] = [
                'title'=>$this->nodeName($activeMenu),
                'href'=>$_SERVER['REQUEST_URI'],
                'hit'=> $this->DT_TIME,
            ];
        }
        if(count($presentation) > $maxPresentation){
            foreach ($presentation as $k=>$v){
                $_hit[$k] = $v['hit'];
            }
            asort($_hit);
            $k = array_key_first($_hit);
            unset($presentation[$k]);
        }
        set_cookie('presentation'.$this->user['id'], base64_encode(json_encode($presentation, JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE)));
        return $presentation;
    }

    public function removePresentation(int $id): array
    {
        $presentation = json_decode(get_cookie('presentation'.$this->user['id']), true);
        if(empty($presentation)){
            $presentation = [];
        }
        unset($presentation[$id]);
        set_cookie('presentation'.$this->user['id'], json_encode($presentation));
        return $presentation;
    }

    /**
     * 通过访问的URL自动获取节点ID
     * @return int
     */
    public function activeMenuFormScriptName(): int
    {
        $_nodeCode = substr($_SERVER['SCRIPT_NAME'], 1);
        $_i = strrpos($_nodeCode, '.');
        $_nodeCode = $_i === false ? $_nodeCode : substr($_nodeCode, 0, $_i);
        return $this->nodePathId[$_nodeCode] ?? 1;
    }
    public function activeMenuFormPathInfo(): int
    {
        $_nodeCode = substr($_SERVER['PATH_INFO'], 1);
        $_nodeCode = '@'.$_nodeCode;
        return $this->nodePathId[$_nodeCode] ?? 1;
    }

    /**
     * 输出错误信息提示
     * @param string $promptMessage
     * @param string|null $msgTitle
     * @param array $param
     * @return void
     */
    public function message(string $promptMessage, string $msgTitle = null, array $param = [])
    {
        $activeMenu = $this->activeMenu;
        if(isset($param['activeMenu'])) $activeMenu = $param['activeMenu'];
        $admin_dir = 'admin';
        $DT_TIME = $this->DT_TIME;
        $title = $appName = LiApp::$appName;
        $curUser = $this->curUser();
        $presentation = $this->presentation($activeMenu);

        include Template::load('message_thin', 'admin');
        exit(0);
    }

    public function checkGoogleAuth($uid, $authenticator): bool
    {
        $user = $this->getAdminUser($uid);
        $ga = new GoogleAuthenticator(); //谷歌验证器示例
        return $ga->verifyCode($user['authenticator'], $authenticator);
    }

    /**
     * 载入签权并返架配置参数
     * @param int|null $activeMenu
     * @param int|array $currentAuthNode
     * @return array
     * ```
     * 'activeMenu'         => activeMenu,
     * 'currentAuthNode'    => currentAuthNode,
     * 'curUserNickname'    => user_nickname,
     * 'access_token'       => access_token,
     * 'presentation'       => presentation,
     * 'navigatorSiderFlag' => navigatorSiderFlag,
     * 'isAjax'             => isAjax,
     * 'postData'           => postData,
     * 'title'              => title,
     * 'page'               => page,
     * 'pageNum'            => pageNum,
     * 'pageStart'          => pageStart,
     * 'navigationConfig'   => navigationConfig,
     * ```
     */
    public function Loader(?int $activeMenu = null, int|array $currentAuthNode =0)
    {
        global $access_token, $title;
        $liAdminToken = get_cookie('LiAdmin'.self::NonceId);
        if (empty($liAdminToken)) {
            LiHttp::redirect(self::LoginUri);
        }
        $loginSuc = $this->auth();
        if (!$loginSuc) {
            LiHttp::redirect(self::LoginUri);
        }
        $activeMenu = is_null($activeMenu) ? $this->activeMenuFormScriptName() : $activeMenu;
        $this->activeMenu = $activeMenu;
        $this->activeMenu($activeMenu);

        if (!$this->authNode($activeMenu)) {
            Template::message('无此权限，无法操作！', '错误提示');
        }
        if (!empty($currentAuthNode) && !$this->authNode($currentAuthNode)) {
            Template::message('无此权限，无法操作！', '错误提示');
        }
        require_once DT_ROOT. '/app/admin/common.php';
        $title = LiApp::$appName . '-' . $this->nodeName($activeMenu);
        $pageNum = config('admin.pageNum');
        $navigationConfig = $this->user['params']['navigation'] ?? config('admin.navigation');
        if (LiComm::is_mobile()) {
            $navigationConfig = 'top';
        }
        $page = isset($_GET['page']) ? intval($_GET['page']) : 1;
        if ($page < 1) {
            $page = 1;
        }
        $pageStart = ($page - 1) * $pageNum;
        $jwt = ['sub' => $this->curUserId(), 'node' => $activeMenu];
        $access_token = $this->getToken($jwt, 18000);

        $isAjax = false;
        $postStr = file_get_contents("php://input");
        $postData = json_decode($postStr, true);
        if (!empty($postData)) {
            $this->verifyAjaxToken($postData);
            $isAjax = true;
        }
        if(isset($_POST['access_token'])){
            $this->verifyAjaxToken($_POST);
            $isAjax = true;
        }

        $presentation = $this->presentation($activeMenu);
        $navigatorSiderFlag = $_COOKIE['navigatorSiderFlag'] ?? 0;

        return [
            'activeMenu'         => $activeMenu,
            'currentAuthNode'    => $currentAuthNode,
            'curUserNickname'    => $this->user['nickname'],
            'access_token'       => $access_token,
            'presentation'       => $presentation,
            'navigatorSiderFlag' => $navigatorSiderFlag,
            'isAjax'             => $isAjax,
            'postData'           => $postData,
            'title'              => $title,
            'page'               => $page,
            'pageNum'            => $pageNum,
            'pageStart'          => $pageStart,
            'navigationConfig'   => $navigationConfig,
            'menu'               => $this->menu,
            'appName'            => LiApp::$appName,
            'LoginUri'           => self::LoginUri,
        ];
    }

    /**
     * 验证Post Ajax 数据请求合法 access_token 和 node
     * @param $postData
     * @return bool
     */
    public function verifyAjaxToken($postData): bool
    {
        $_jwt = $this->verifyToken($postData['access_token']??'');
        if ($_jwt === false) {
            Response::error(2, 'TOKEN无效！');
        }
        if ($_jwt['sub'] != $this->user['id']) {
            Response::error(4, '非当前登入用户！');
        }
        if (isset($postData['node'])) {
            if(!is_numeric($postData['node'])){
                Response::error(1, '无效权限，无法操作！', $postData);
            }
            if (!$this->authNode($postData['node'])) {
                Response::error(1, '无此权限，无法操作！');
            }
        }
        return true;
    }
}