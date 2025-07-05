<?php
require '../autoload.php';

use App\framework\LiApp;
use LiPhp\Template;
use App\admin\auth;
use App\admin\Tree;
use App\framework\Response;

$Loader = auth::instance()->Loader(3);

if($Loader['isAjax']){  //ajax 提交
    $postData = $Loader['postData'];
    if($postData['node'] == 17 && $postData['action'] == 'QUERY'){
        $qUser = auth::instance()->getAdminNode($postData['rowid']);
        if($qUser){
            Response::success($qUser);
        }else{
            Response::error(1000, '查无记录！');
        }
    }elseif($postData['node'] == 17 && $postData['action'] == 'EDIT') {
        auth::instance()->aLog('编辑节点：'.$postData['rowid'], $postData);
        $data = ['pid'=>$postData['pid'], 'node' => $postData['nodename'], 'title' => $postData['title'], 'status'=>$postData['status'], 'icon'=>$postData['icon'], 'sort'=>$postData['sort']];
        $res = LiApp::$db->table('admin_node')->where(['id' => $postData['rowid']])->fields($data)->update();
        if ($res) {
            Response::success(['id' => $postData['rowid']]);
        } else {
            Response::error(1001, '更新节点资料失败！');
        }
    }else{
        Response::error(9, '非法无效请求！');
    }
}

$list = LiApp::$db->table('admin_node')->where(['is_menu'=>1, 'status'=>['>=', 0]])->order('sort DESC, id ASC')->select()->toArray();
Tree::instance()->init($list);
$list = Tree::instance()->getTreeList(Tree::instance()->getTreeArray(0), 'title');

$topMenu = LiApp::$db->table('admin_node')->where(['is_menu'=>1, 'status'=>['>=', 0], 'pid'=>0])->order('sort DESC, id ASC')->select()->toArray();

include Template::load('admin/menu');