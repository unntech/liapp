<?php
require 'autoload.php';

use App\framework\Response;
use App\api\ApiBase;

/**
 * 获取 API 接口 access_token
 * 区别 GET 和 POST 不同请求做不同的数据处理
 * 可增加请求 action 参数，做不同的 token 生成规则
 * 简单示例，生产环境根据自己的应该需求编写自己的生成和保存规则
 */

$msg = '授权失败';

if($_SERVER['REQUEST_METHOD'] =='GET'){
    $appid = $_GET['appid'] ?? '';      // 'app313276672646586985'
    $secret = $_GET['secret'] ?? '';    // '481b9e180527e3ce790e85b43369ce64'

    // 验证 appid 和 secret 的合法性，做相应处理
    // 本示例使用 app_secret 表里预设的 appid和secret 进行验证
    $accessToken = (new ApiBase())->authorize_access_token($appid, $secret);
    if(!$accessToken['suc']){
        $msg = $accessToken['msg'];
    }
    $signType = 'SHA256';
}else{
    $req = json_decode(file_get_contents("php://input"), true);

    // 本示例流程：客户端发送 设备ID（或UUID）唯一值做为 appid,
    // 示例用到的 RSA 密钥对 见 config/app.php
    $signType = 'RSA';
    if(!isset($req['signType']) || $req['signType'] != 'RSA'){ //要求必须是RSA签名
        $accessToken['suc'] = false;
        $msg = '请求数据必须是RSA签名';
    }else{
        $v = Response::instance(['private_key'=>config('app.rsaKey.private'), 'public_key'=>config('app.rsaKey.third_public')])::verifySign($req, true);
        if($v){
            $appid = $req['body']['uuid'] ?? '';  // 获取请求数据的设备ID（或UUID）唯一值做为 appid
            $appid = strtolower(preg_replace('/[^a-zA-Z0-9_-]/', '', $appid));  //过滤掉非法字符
            $accessToken = (new ApiBase())->access_token_generate($appid);
            //签发成功，把 access_token 和 临时 secret 发给客户端
            if(!$accessToken['suc']){
                $msg = $accessToken['msg'];
            }
            Response::encrypted()::encryption('RSAIES'); //加密输出
        }else{
            $accessToken['suc'] = false;
            $msg = '请求数据验签失败';
        }
    }
}

// 生成 access_token 示例， 根据自己的数据格式及加密算法生成
if($accessToken['suc']){
    $data = [
        'access_token' => $accessToken['access_token'],
        'expires_in'   => $accessToken['expires_in'],
        'issue_time'   => date('Y-m-d H:i:s'),
    ];
    if(isset($accessToken['secret'])){
        $data['secret'] = $accessToken['secret'];
    }

    Response::signType($signType)::success($data);

}else{

    Response::error(401, $msg);

}



