<?php
require '../autoload.php';

use App\framework\LiApp;
use App\framework\extend\DB;
use UNNTech\Encrypt\Request;
use App\framework\Response;
use LiPhp\LiComm;

//use LitePhp\Exception;
//
//try {
//    throw new Exception("TEST");
//}catch (Exception $e){
//    $e->errorMessage();
//}

Response::error(500,'Request Throwable!');

//$req = Request::headers(['uri'=>'/authorize'])::generate(['appid'=>'app313276672646586985', 'secret'=>'481b9e180527e3ce790e85b43369ce64']);
$req = Request::instance(['signType'=>'SHA256', 'secret'=>'cLL6lmyovFibjPIF40kWpiqoPozjGK9M'])::headers(['access_token'=>'AsrDoSLQ1hRhFyuwVKP31RkaqVx0G0g4gZxLUHImwKpcOKHIE0isxmIuo2i3FOKMYJILPJyijHIEkPk9za28','uri'=>'/sampleAuthorize/test'])::generate(['abc'=>'9999']);
//$req = Request::instance(['signType'=>'RSA', 'private_key'=>config('app.rsaKey.private'), 'public_key'=>config('app.rsaKey.third_public')])::headers(['uri'=>'/authorize'])::generate(['uuid'=>LiComm::uuid()]);
dv($req);
