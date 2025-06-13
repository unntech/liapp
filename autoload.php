<?php

use App\framework\LiApp;

const IN_LitePhp = true;
define('DT_ROOT', str_replace("\\", '/', __DIR__ ));
define('APP_START_TIME', microtime(true));
require_once DT_ROOT . '/vendor/autoload.php';

LiPhp\Lite::setRootPath(DT_ROOT);
LiApp::initialize();
$DT_TIME = LiApp::$DT_TIME;
$DT_IP = LiApp::$DT_IP;
$title = LiApp::$appName;

require_once DT_ROOT . '/vendor/unntech/liphp/src/helper.php';
require_once DT_ROOT . '/include/common.php';
set_exception_handler('exception_handler');
LiApp::set_db();
LiPhp\Model::setDb(LiApp::$db);
