<?php
require '../autoload.php';

use LiPhp\Template;
use App\admin\auth;

$Loader = auth::instance()->Loader(4);


if(isset($_POST['saveBtn'])){
    //do something
}

include Template::load();