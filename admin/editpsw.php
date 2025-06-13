<?php
require '../autoload.php';

use LiPhp\Template;
use App\admin\auth;
use App\framework\LiApp;

$Loader = auth::instance()->Loader(0);

if(isset($_POST['save'])){
    if($_POST['newpassword'] != $_POST['cfmpassword']){
        $promptMessage = '您输入的两次新密码不一致，无法修改，请重设！';
        include Template::load('admin/message');
        exit(0);
    }
    $user = auth::instance()->getAdminUser(auth::$curUserId);
    if(auth::instance()->password($_POST['oldpassword']) != $user['psw']){
        $promptMessage = '您输入的旧密码不正确！';
        include Template::load('admin/message');
        exit(0);
    }
    $newpsw = auth::instance()->password($_POST['newpassword']);
    $res = LiApp::$db->table('admin')->where(['id'=>auth::$curUserId])->fields(['psw'=>$newpsw])->update();
    if($res){
        auth::instance()->aLog('修改个人密码', json_encode($_POST));
        $promptMessage = '修改密码成功！';
        include Template::load('admin/message');
        exit(0);
    }
}

$profile = auth::instance()->curUser();

include Template::load('admin/editpsw');