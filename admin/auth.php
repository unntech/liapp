<?php
require '../autoload.php';

use App\framework\LiApp;
use LiPhp\Template;
use App\admin\auth;
use App\framework\Response;

$Loader = auth::instance()->Loader(9);

if($Loader['isAjax']){  //ajax 提交
    $postData = $Loader['postData'];
    if($postData['node'] == 13 && $postData['action'] == 'QUERY'){
        $qUser = auth::instance()->getAdminAuth($postData['rowid']);
        if($qUser){
            Response::success($qUser);
        }else{
            Response::error(1000, '查无记录！');
        }
    }elseif($postData['node'] == 13 && $postData['action'] == 'EDIT') {
        auth::instance()->aLog('编辑角色：'.$postData['rowid'], $postData);
        $data = ['title'=>$postData['username'], 'remark' => $postData['nickname'], 'status' => $postData['userstatus']];
        $res = LiApp::$db->table('admin_auth')->where(['id' => $postData['rowid']])->fields($data)->update();
        if ($res) {
            Response::success(['id' => $postData['rowid']]);
        } else {
            Response::error(1001, '更新角色资料失败！');
        }
    }elseif($postData['node'] == 12 && $postData['action'] == 'ADD'){
        auth::instance()->aLog('添加角色', $postData);
        $data = ['title'=>$postData['username'], 'remark' => $postData['nickname'], 'status' => $postData['userstatus']];
        $res = LiApp::$db->table('admin_auth')->insert($data);
        if ($res) {
            Response::success(['id' => $res]);
        } else {
            Response::error(1001, '添加用户失败！');
        }
    }elseif($postData['node'] == 14 && $postData['action'] == 'DELETE'){
        auth::instance()->aLog('删除角色：'.$postData['rowid'], $postData);
        $res = LiApp::$db->table('admin_auth')->where(['id'=>$postData['rowid']])->fields(['status'=>-1])->update();
        if($res){
            Response::success(['id' => $postData['rowid']]);
        }else{
            Response::error(1001, '删除角色失败！');
        }
    }else{
        Response::error(9, '非法无效请求！');
    }
}

$pageTotal = LiApp::$db->table('admin_auth')->where(['status'=>['>=', 0]])->count();
$list = LiApp::$db->table('admin_auth')->where(['status'=>['>=', 0]])->limit([$Loader['pageStart'], $Loader['pageNum']])->select()->toArray();

include Template::load();