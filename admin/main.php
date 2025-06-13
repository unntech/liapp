<?php
require '../autoload.php';

use LiPhp\Template;
use App\admin\auth;

$Loader = auth::instance()->Loader();


include Template::load();