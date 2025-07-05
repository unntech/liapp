<?php
require '../autoload.php';

use App\framework\LiApp;
use LiPhp\Template;
use App\admin\auth;
use App\admin\Tree;
use App\framework\Response;

$Loader = auth::instance()->Loader(8);

if($Loader['isAjax']){  //ajax 提交
    $postData = $Loader['postData'];
    if($postData['node'] == 16 && $postData['action'] == 'QUERY'){
        $qUser = auth::instance()->getAdminNode($postData['rowid']);
        if($qUser){
            Response::success($qUser);
        }else{
            Response::error(1000, '查无记录！');
        }
    }elseif($postData['node'] == 16 && $postData['action'] == 'EDIT') {
        auth::instance()->aLog('编辑节点：'.$postData['rowid'], $postData);
        $data = ['pid'=>$postData['pid'], 'node' => $postData['nodename'], 'title' => $postData['title'], 'status'=>$postData['status'], 'is_menu'=>$postData['is_menu'], 'icon'=>$postData['icon'], 'sort'=>$postData['sort']];
        $res = LiApp::$db->table('admin_node')->where(['id' => $postData['rowid']])->fields($data)->update();
        if ($res) {
            Response::success(['id' => $postData['rowid']]);
        } else {
            Response::error(1001, '更新节点资料失败！');
        }
    }elseif($postData['node'] == 19 && $postData['action'] == 'ADD'){
        auth::instance()->aLog('添加节点', $postData);
        $data = ['pid'=>$postData['pid'], 'node' => $postData['nodename'], 'title' => $postData['title'], 'status'=>$postData['status'], 'is_menu'=>$postData['is_menu'], 'icon'=>$postData['icon'], 'sort'=>$postData['sort']];
        $res = LiApp::$db->table('admin_node')->insert($data);
        if ($res) {
            Response::success(['id' => $res]);
        } else {
            Response::error(1001, '添加节点失败！');
        }
    }elseif($postData['node'] == 19 && $postData['action'] == 'DELETE'){
        auth::instance()->aLog('删除节点：'.$postData['rowid'], $postData);
        $res = LiApp::$db->table('admin_node')->where(['id'=>$postData['rowid']])->fields(['status'=>-1])->update();
        if($res){
            Response::success(['id' => $postData['rowid']]);
        }else{
            Response::error(1001, '删除节点失败！');
        }
    }else{
        Response::error(9, '非法无效请求！');
    }
}

$list = LiApp::$db->table('admin_node')->where(['status'=>['>=', 0]])->order('sort DESC, id ASC')->select()->toArray();
Tree::instance()->init($list);
$ruleList = Tree::instance()->getTreeList(Tree::instance()->getTreeArray(0), 'title');

$menuNode = ['<i class="bi bi-nut"></i>', '<i class="bi bi-list-ul"></i>'];

include Template::load('admin/node');