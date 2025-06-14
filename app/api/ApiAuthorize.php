<?php

namespace App\api;

class ApiAuthorize extends ApiBase
{
    protected int|string $appid;

    public function __construct(){
        parent::__construct();
        $this->initialize_authorize();
    }

    public function initialize_authorize(): void
    {
        /*  //如果需要安全验证，要求必须有签名才可以请求，如果ApiBase里init_request_data已经启用，那这里就不要重复验证
        if(!isset($this->postData['signType']) || !in_array($this->postData['signType'], ['MD5', 'SHA256', 'RSA', 'ECDSA'])){
            $this->error(400, '无请求数据或无效 signType！', ['request'=>$this->postData]);
        }
        //*/

        //验证接口权限等初始化过程
        $jwt = $this->verifyToken($this->postData['head']['access_token'] ?? '');
        if($jwt === false){
            $this->error(401, 'Unauthorized');
        }
        //增加安全性可配合签发 access_token 时同步写入 Redis缓存，这里对应读出验证合法

        if(empty($jwt['sub'])){
            $this->error(401, 'Unauthorized appid');
        }
        $this->appid = $jwt['sub'] ?? 0;


        /* --- 等等其它鉴权不成功则退出
        $notAllow = true;
        if($notAllow){
            $this->error(401, 'Unauthorized');
        }
        */
    }

}