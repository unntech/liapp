<?php
require '../autoload.php';

use App\framework\LiApp;
use App\framework\extend\DB;
use UNNTech\Encrypt\Request;
use LiPhp\LiComm;

//use LitePhp\Exception;
//
//try {
//    throw new Exception("TEST");
//}catch (Exception $e){
//    $e->errorMessage();
//}

$req = Request::instance(['signType'=>'SHA256', 'secret'=>'ykahN5U6JlwdxQHbZoUrMQxp1LHJhkMT'])::headers(['access_token'=>'AsrDoSLQ1hRkEnvjVPb5gk7hu5vBPreW3CHumbUcQw6e6A2-bXpjjOSGC4pumJlKKaw9XfDkqZo6iLbk2hzR'])::generate(['abc'=>'9999']);
//$req = Request::instance(['signType'=>'RSA', 'private_key'=>config('app.rsaKey.private'), 'public_key'=>config('app.rsaKey.third_public')])::generate(['uuid'=>LiComm::uuid()]);
var_dump($req);
