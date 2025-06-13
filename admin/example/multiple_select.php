<?php
require '../../autoload.php';

use LiPhp\Template;
use App\admin\auth;

$Loader = auth::instance()->Loader(0);

$list1 = ['一月','二月','三月','四月','五月','六月','七月','八月','九月','十月','十一月','十二月'];

include Template::load('admin/example/multiple_select');