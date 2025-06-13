<?php
require '../autoload.php';

use App\framework\LiApp;
use LiPhp\Template;

$title = "Bootstrap svg 图标库";

$res = LiApp::$db->table('icons')->select();
$icons = [];
while ($r = $res->fetch_assoc()){
    $icons[$r['id']] = ['name'=>$r['name'], 'title'=>substr($r['name'], 6)];
}

include Template::load('admin/icons');