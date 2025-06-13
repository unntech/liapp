<?php
require '../../autoload.php';

use LiPhp\Template;
use App\admin\auth;

$Loader = auth::instance()->Loader(0);

$title = "ECharts";

include Template::load('admin/example/echarts');