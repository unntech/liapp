<?php
require '../autoload.php';

use App\admin\auth;
use App\framework\LiApp;
use LiPhp\LiHttp;
use LiPhp\Template;

$title = LiApp::$appName . '后台管理';
$action = $_GET['action'] ?? '';
$ref = $_GET['ref'] ?? 'main.php';

$emsg = '';
$username = '';

if($action == 'logout'){
    set_cookie("LiAdmin".auth::NonceId, '');
    $href = empty($_GET['href']) ? 'index.php' : $_GET['href'];
    LiHttp::redirect($href);
}

if(isset($_POST['login'])) {
    $username = trim($_POST['username']);
    $_username = strtoupper($username);
    $password = $_POST['password'];
    $authic = $_POST['authenticator'];
    $auth = new auth();
    $login = $auth->login($_username, $password, $authic);
    if($login->errcode == 0){ //登入成功
        LiHttp::redirect($ref);
    }else{
        $emsg = $login->msg;
    }

}



include Template::load('admin/index');