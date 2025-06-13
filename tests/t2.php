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

$req = Request::instance(['signType'=>'SHA256'])::headers(['access_token'=>'AsrDoSLQ1gE_H2L3AOq_lnAL2YPyufgrxyu1FA','token'=>'AsrDoSLQ1gE_H2L3AOq_lnAL2YPyufgrxyu1FA'])::generate(['abc'=>'9999']);
var_dump($req);
