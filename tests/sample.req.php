<?php
require __DIR__.'/../autoload.php';

use UNNTech\Encrypt\Request;

$data = [
    'order_id' => 123,
    'money'    => 1001.23,
    'text'     => '中文',
];

$req = Request::instance(['secret'=>DT_KEY, 'signType'=>'SHA256'])::headers(['app'=>'IOS', 'token'=>'hjdp6DnmCZWgQCSzQ43d1Eo7YhES2VZ5I86OOY/L1nY7kqn7gSGdO4SLMg9HIUppdGEEdVz7HyFB1F3eb600A98DqoqcJQrIEis1DmKLLbKQJCtXbi'])::generate($data, 'array');
dv($req);
$request = json_encode($req);
dv($request);

$c = Request::verifySign($req);
if($c){
    echo "Verify Sign Success. <BR>\n";
}else{
    echo "Verify Sign Fail. <BR>\n";
}