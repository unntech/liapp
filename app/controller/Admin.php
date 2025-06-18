<?php

namespace App\controller;

require_once DT_ROOT. '/app/admin/common.php';
use App\framework\Controller;
use LiPhp\LiHttp;
use LiPhp\Template;
use App\admin\auth;
use LiPhp\LiComm;
use App\framework\LiApp;

class Admin extends Controller
{
    /**
     * @var auth
     */
    protected $auth;
    protected string $appName;
    protected array $curUser;
    protected int $curUserId;
    protected int $activeMenu=0;
    protected array|int|string $currentAuthNode =0;
    protected int $pageStart, $pageNum, $page;

    use \App\traits\crypt;

    public function __construct(){
        parent::__construct();

    }

    protected function initialize(): void
    {
        $this->auth();
        $this->pageNum = config('admin.pageNum');
        $_page = isset($_GET['page']) ? intval($_GET['page']) : 1;
        if ($_page < 1) {
            $_page = 1;
        }
        $this->page = $_page;
        $this->pageStart = ($_page - 1) * $this->pageNum;
        parent::initialize();
    }

    public function view(string $template = '', array $vars = [], array $CSS = [])
    {
        if ($this->title == $this->appName){
            $this->title = $this->appName . '-' . $this->auth->nodeName($this->activeMenu);
        }
        $navigationConfig = $this->curUser['params']['navigation'] ?? config('admin.navigation');
        if (LiComm::is_mobile()) {
            $navigationConfig = 'top';
        }
        $vars['page'] = $this->page;
        $vars['pageStart'] = $this->pageStart;
        $vars['pageNum'] = $this->pageNum;
        $jwt = ['sub' => $this->curUserId, 'node' => $this->activeMenu, 'exp' => time() + 18000];
        $vars['access_token'] = $this->getToken($jwt);
        $vars['appName'] = $this->appName;
        $vars['Loader'] = [
            'activeMenu'         => $this->activeMenu,
            'curUserNickname'    => $this->curUser['nickname'],
            'presentation'       => $this->auth->presentation($this->activeMenu),
            'navigatorSiderFlag' => $_COOKIE['navigatorSiderFlag'] ?? 0,
            'navigationConfig'   => $navigationConfig,
            'menu'               => $this->auth->getMenu(),
            'appName'            => LiApp::$appName,
            'LoginUri'           => auth::LoginUri,
        ];
        parent::view($template, $vars, $CSS);
    }

    private function auth()
    {
        $liAdminToken = get_cookie('LiAdmin'. auth::NonceId);
        if (empty($liAdminToken)) {
            LiHttp::redirect(auth::LoginUri);
        }
        $this->auth = new auth();
        $loginSuc = $this->auth->auth();
        if (!$loginSuc) {
            LiHttp::redirect(auth::LoginUri);
        }
        $this->activeMenu = $activeMenu ?? $this->auth->activeMenuFormPathInfo();
        $this->auth->activeMenu($this->activeMenu);
        if (!$this->auth->authNode($this->activeMenu)) {
            Template::message('无此权限，无法操作！', '错误提示');
        }
        $this->appName = LiApp::$appName;
        $this->curUser = $this->auth->curUser();
        $this->curUserId = $this->auth->curUserId();
        if (!empty($this->postData)) {
            $this->verifyAjaxToken($this->postData);
        }
        if(isset($this->POST['access_token'])){
            $this->verifyAjaxToken($this->POST);
        }
    }

    /**
     * 验证Ajax请求的 access_token
     * @param $postData
     * @return void
     */
    private function verifyAjaxToken($postData)
    {
        $_jwt = $this->verifyToken($postData['access_token']??'');
        if ($_jwt === false) {
            $this->error(2, 'TOKEN无效！');
        }
        if ($_jwt['sub'] != $this->curUserId) {
            $this->error(4, '非当前登入用户！');
        }
        if (isset($postData['node'])) {
            if(!is_numeric($postData['node'])){
                $this->error(1, '无效权限，无法操作！', $this->postData);
            }
            if (!$this->auth->authNode($postData['node'])) {
                $this->error(1, '无此权限，无法操作！');
            }
        }
    }

    /**
     * 根据activeMenu和currentAuthNode验证权限
     * @return void
     */
    protected function author()
    {
        $this->auth->activeMenu($this->activeMenu);
        if (!$this->auth->authNode($this->activeMenu)) {
            Template::message('无此权限，无法操作！', '错误提示');
        }
        if (isset($this->currentAuthNode) && !$this->auth->authNode($this->currentAuthNode)) {
            Template::message('无此权限，无法操作！！', '错误提示');
        }
    }

    protected function authorApiNode($node): void
    {
        if(!$this->auth->authNode($node)){
            $this->error(1, '无效权限，无法操作！', $this->postData);
        }
    }

    /**
     * Admin框架的错误信息提示
     * @param string $promptMessage
     * @param string|null $msgTitle
     * @param array $param
     * @return void
     */
    protected function adminMessage(string $promptMessage, string $msgTitle = null, array $param = [])
    {
        if ($this->title == $this->appName){
            $this->title = $this->appName . '-' . $this->auth->nodeName($this->activeMenu);
        }
        $vars['navigationConfig'] = $this->curUser['params']['navigation'] ?? config('admin.navigation');

        if (LiComm::is_mobile()) {
            $vars['navigationConfig'] = 'top';
        }
        $jwt = ['sub' => $this->curUserId, 'node' => $this->activeMenu, 'exp' => time() + 18000];
        $vars['apiToken'] = $this->getToken($jwt);
        $vars['presentation'] = $this->auth->presentation($this->activeMenu);
        $vars['navigatorSiderFlag'] = $_COOKIE['navigatorSiderFlag'] ?? 0;
        $vars['auth'] = $this->auth;
        $vars['activeMenu'] = $this->activeMenu;
        $vars['curUser'] = $this->curUser;
        $vars['appName'] = $this->appName;
        $vars['promptMessage'] = $promptMessage;
        $vars['msgTitle'] = $msgTitle;
        parent::view("admin/message", $vars);
        exit(0);
    }
}