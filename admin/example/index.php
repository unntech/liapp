<?php
require '../../autoload.php';

use LiPhp\Template;
use App\admin\auth;

$Loader = auth::instance()->Loader(0);

//单个分页条处理方式，可直接使用以下变量
$pageTotal = 123;
$Loader['pageStart']; $Loader['pageNum']; $Loader['page'];

//多个分页条处理方式，需自计算计算 pageStart 值
$pageTotal1 = 100;
$page1 = isset($_GET['page1']) ? intval($_GET['page1']) : 1;
if ($page1 < 1) {  $page1 = 1; }
$pageStart1 = ($page1 - 1) * $Loader['pageNum'];

$pageTotal2 = 200;
$page2 = isset($_GET['page2']) ? intval($_GET['page2']) : 1;
if ($page2 < 1) {  $page2 = 1; }
$pageStart2 = ($page2 - 1) * $Loader['pageNum'];

$pageTotal3 = 300;
$page3 = isset($_GET['page3']) ? intval($_GET['page3']) : 1;
if ($page3 < 1) {  $page3 = 1; }
$pageStart3 = ($page3 - 1) * $Loader['pageNum'];


include Template::load('admin/example/index');
