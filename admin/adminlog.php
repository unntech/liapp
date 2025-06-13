<?php
require '../autoload.php';

use App\framework\LiApp;
use LiPhp\Template;
use App\admin\auth;
use App\admin\XlsWriter;

$Loader = auth::instance()->Loader(7);

$qUserId = isset($_GET['userid']) ? intval($_GET['userid']) : '';
if($qUserId <= 0){ $qUserId = '';}
$today = getdate();
$starTime = isset($_GET['date']) ? strtotime($_GET['date']) : mktime(0,0,0,$today['mon'],$today['mday'],$today['year']);
$endTimes = $starTime;
$endTime = $starTime + 86400;

if(isset($_GET['toolbarSearch']) || isset($_GET['toolbarExport'])){
    $starTime = strtotime($_GET['begdatetime']);
    $endTimes = strtotime($_GET['enddatetime']);
    $endTime = $endTimes + 86400;
}

$where[] = ['addtime'=>['>=', $starTime]];
$where[] = ['addtime'=>['<', $endTime]];
if(!empty($qUserId)){
    $where[] = ['admin_id ' => $qUserId];
}

if(isset($_GET['toolbarExport']) && auth::instance()->authNode(22, true)){ //导出
    $res = LiApp::$db->table('admin_log')->where($where)->order('id desc')->select();
    $list = [];
    while ($r = $res->fetch_assoc()){
        $list[] = [
            (int)$r['id'],
            (int)$r['admin_id'],
            $r['nickname'],
            $r['url'],
            $r['title'],
            $r['content'],
            $r['ip'],
            date('Y-m-d H:i:s', $r['addtime']),
        ];
    }
    $excel = new XlsWriter();
    $excel->fileName('管理员日志')->header(['ID','管理员ID','管理员','操作页面','标题','内容','IP','时间'])->data($list)->export();
    exit(0);
}

$pageTotal = LiApp::$db->table('admin_log')->where($where)->count();
$list = LiApp::$db->table('admin_log')->where($where)->order('id desc')->limit([$Loader['pageStart'], $Loader['pageNum']])->select()->toArray();

include Template::load();