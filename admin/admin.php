<?php
require '../autoload.php';

use App\framework\LiApp;
use LiPhp\Template;
use App\admin\auth;
use LiPhp\LiComm;
use App\framework\Response;

$Loader = auth::instance()->Loader(6);

if($Loader['isAjax']){  //ajax 提交
    $postData = $Loader['postData'];
    if($postData['node'] == 11 && $postData['action'] == 'QUERY'){
        $qUser = auth::instance()->getAdminUser($postData['rowid']);
        if($qUser){
            unset($qUser['authenticator']);
            unset($qUser['psw']);
            Response::success($qUser);
        }else{
            Response::error(1000, '查无记录！');
        }
    }elseif($postData['node'] == 11 && $postData['action'] == 'EDIT') {
        auth::instance()->aLog('编辑用户：'.$postData['rowid'], $postData);
        if($postData['useradmin'] == 1){$postData['useradmin'] = 0;}
        $data = ['nickname' => $postData['nickname'], 'status' => $postData['userstatus'], 'admin' => $postData['useradmin']];
        $data['username'] = strtoupper(LiApp::$db->removeEscape($postData['username']));
        if (!empty($postData['password'])) {
            $data['psw'] = auth::instance()->password($postData['password']);
        }
        $data['auth_ids'] = implode(',', json_decode($postData['rules'], true));
        $res = LiApp::$db->table('admin')->where(['id' => $postData['rowid']])->fields($data)->update();
        if ($res) {
            Response::success(['id' => $postData['rowid']]);
        } else {
            Response::error(1001, '更新用户资料失败！');
        }
    }elseif($postData['node'] == 10 && $postData['action'] == 'ADD'){
        auth::instance()->aLog('添加用户', $postData);
        if($postData['useradmin'] == 1){$postData['useradmin'] = 0;}
        $data = ['nickname' => $postData['nickname'], 'status' => $postData['userstatus'], 'admin' => $postData['useradmin']];
        $data['username'] = strtoupper(LiApp::$db->removeEscape($postData['username']));
        if (empty($postData['password'])) {
            $postData['password'] = LiComm::createNonceStr(6);
        }
        $data['psw'] = auth::instance()->password($postData['password']);
        $data['auth_ids'] = implode(',', json_decode($postData['rules'], true));
        $res = LiApp::$db->table('admin')->insert($data);
        if ($res) {
            Response::success(['id' => $res]);
        } else {
            Response::error(1001, '添加用户失败！');
        }
    }elseif($postData['node'] == 10 && $postData['action'] == 'DELETE'){
        auth::instance()->aLog('删除用户：'.$postData['rowid'], $postData);
        if($postData['rowid'] == 1){
            Response::error(1001, 'ID为1的超级管理员用户不可删除！');
        }
        $res = LiApp::$db->table('admin')->where(['id'=>$postData['rowid']])->fields(['status'=>-1])->update();
        if($res){
            Response::success(['id' => $postData['rowid']]);
        }else{
            Response::error(1001, '删除用户失败！');
        }
    }elseif($postData['node'] == 18 && $postData['action'] == 'SECURE'){
        auth::instance()->aLog('解绑动态码：'.$postData['rowid'], $postData);
        $res = LiApp::$db->table('admin')->where(['id'=>$postData['rowid']])->fields(['authenticator'=>''])->update();
        if($res){
            Response::success(['id' => $postData['rowid']]);
        }else{
            Response::error(1001, '解绑动态码失败！');
        }
    }else{
        Response::error(9, '非法无效请求！');
    }
}

$qUsername = $_GET['username'] ?? '';
$qStatus = $_GET['status'] ?? -9;
if($qStatus >=0){
    $where['status'] = $qStatus;
}else{
    $where['status'] = ['>=', 0];
}
if($qUsername != ''){
    $where['username'] = ['LIKE',"%{$qUsername}%"];
}
$pageTotal = LiApp::$db->table('admin')->where($where)->count();
$res = LiApp::$db->table('admin')->where($where)->limit([$Loader['pageStart'], $Loader['pageNum']])->select();
$list = [];
while ($r = $res->fetch_assoc()){
    $r['statusName'] = auth::status[$r['status']];
    $r['adminTag'] = auth::instance()->adminTag[$r['admin']];
    if(empty($r['auth_ids'])){
        $r['authRules'] = '';
    }else{
        $_reu= LiApp::$db->table('admin_auth')->fields(['title'])->where(['id'=>['IN', explode(',', $r['auth_ids'])]])->select();
        $rules = [];
        while($v = $_reu->fetch_assoc()){
            $rules[] = $v['title'];
        }
        $r['authRules'] = implode(',',$rules);
    }

    $list[] = $r;
}

$rulesNames = auth::instance()->getAdminAuths();


include Template::load('admin/admin');