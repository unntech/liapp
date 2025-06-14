<?php
require '../autoload.php';

use App\framework\LiApp;
use App\framework\extend\DB;
use UNNTech\Encrypt\Request;

//use LitePhp\Exception;
//
//try {
//    throw new Exception("TEST");
//}catch (Exception $e){
//    $e->errorMessage();
//}

$req = Request::instance(['signType'=>'SHA256'])::headers(['access_token'=>'AsrDoSLQ1gE_H2L3AOq_lnAL2YPyuf4jwCq_FA'])::generate(['abc'=>'9999']);
var_dump($req);
