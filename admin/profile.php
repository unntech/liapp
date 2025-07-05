<?php
require '../autoload.php';

use App\framework\LiApp;
use LiPhp\Template;
use App\admin\auth;
use App\framework\Response;
use App\framework\extend\Redis;

$Loader = auth::instance()->Loader(6);

if($Loader['isAjax']){
    $postData = $Loader['postData'];
    switch ($postData['action']){
        case 'SETNAV':
            $profile = auth::instance()->getAdminUser(auth::$curUserId);
            $newParams = $profile['params'];
            $newParams['navigation'] = $postData['navi'];
            $res = LiApp::$db->table('admin')->where(['id'=>auth::$curUserId])->fields(['params'=>json_encode($newParams)])->update();
            if($res){
                Response::success($newParams);
            }else{
                Response::error(1001, '更新用户资料失败！');
            }
            break;
        case 'clearCache':
            if(auth::menuNodeCache){
                LiApp::set_redis();
                Redis::del('adminMenu'. auth::NonceId.'_'.auth::$curUserId);
                Redis::del('adminNode'. auth::NonceId.'_'.auth::$curUserId);
            }
            response::success([]);
            break;
        case 'removePresentation':
            $id = intval($postData['id']);
            $presentation = auth::instance()->removePresentation($id);
            response::success(['id'=>$id, 'presentation'=>$presentation]);
            break;
        default:
            response::error(9, '非法无效请求！');
    }
}

if (isset($_POST['save'])) {
    $res = LiApp::$db->table('admin')->where(['id' => auth::$curUserId])->fields(['nickname' => $_POST['nickname']])->update();
    if ($res) {
        $postSuccess = true;
        auth::instance()->aLog('修改个人资料', $_POST);
    }
}
$profile = auth::instance()->getAdminUser(auth::$curUserId);
$rulesNames = auth::instance()->getAdminAuths($profile['auth_ids']);
$rulesString = implode(',', $rulesNames);

include Template::load('admin/profile');