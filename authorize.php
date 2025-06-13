<?php
require 'autoload.php';

use App\framework\Response;
use LiPhp\LiCrypt;

/**
 * 获取 API 接口 access_token
 * 区别 GET 和 POST 不同请求做不同的数据处理
 * 可增加请求 action 参数，做不同的 token 生成规则
 * 简单示例，生产环境根据自己的应该需求编写自己的生成和保存规则
 */

if($_SERVER['REQUEST_METHOD'] =='GET'){
    $appid = $_GET['appid'] ?? '';
    $secret = $_GET['secret'] ?? '';

    // 验证 appid 和 secert 的合法性，做相应处理，并得到内部的 appid值 如 123
    $sub = 123;
}else{
    $req = json_decode(file_get_contents("php://input"), true);

    //更据请求数据 验证身份的合法性，并得到请求者ID 如 123
    $sub = 789;
}

// 生成 access_token 示例， 根据自己的数据格式及加密算法生成
// 以及在服务器保 Redis 保存 access_token 以备请求者验签
$Aes = new LiCrypt(DT_KEY);
$exp = time()+7200;
$jwt = ['sub'=>$sub, 'exp'=>$exp];
$access_token = $Aes->getToken($jwt);
$data = [
    'access_token' => $access_token,
    'expires_in'   => $exp,
    'issue_time'   => date('Y-m-d H:i:s'),
];

// 输出内容根据生产需求，可做加密签验输出，更为安全
Response::signType('SHA256')::success($data);



