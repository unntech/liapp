<?php
require '../autoload.php';

use LiPhp\Template;
use App\admin\auth;
use App\framework\LiApp;

$Loader = auth::instance()->Loader(0);

$profile = auth::instance()->getAdminUser(auth::$curUserId);
if($profile['authenticator'] != ''){
    $promptMessage = '您已经绑定了谷歌验证码，如需重置谷歌验证码，请联系管理员操作解绑后可以重新绑定！';
    include Template::load('admin/message');
    exit(0);
}
$ga = new LiPhp\GoogleAuthenticator(); //谷歌验证器示例
if(isset($_POST['save'])) {
    $secret = $_POST['secret'];
    $code = $_POST['newcode'];
    $checkResult = $ga->verifyCode($secret, $code); //验证输入谷歌验证器是否正确
    if($checkResult){
        $res = LiApp::$db->table('admin')->where(['id'=>auth::$curUserId])->fields(['authenticator'=>$secret])->update();
        $promptMessage = '动态码绑定成功！';
    }else{
        $promptMessage = '您输入的动态码不正确，请确定是否是刚刚添加的那个动态码？';
    }
    include Template::load('admin/message');
    exit(0);
}
$secret = $ga->createSecret();

$qrCodeUrl = $ga->getQRCodeGoogleUrl($profile['username'], $secret, 'LiteAdmin'); //第一个参数是"标识",第二个参数为"安全密匙SecretKey" 生成二维码信息


include Template::load('admin/authenticator');