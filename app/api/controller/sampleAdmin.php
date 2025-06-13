<?php

namespace App\api\controller;

use App\api\ApiAdmin;

class sampleAdmin extends ApiAdmin
{
    public function __construct(){
        parent::__construct();
    }

    //请求处理函数，按需添加编写
    public function test()
    {
        $data = [
            'title'=>'This is a testing.',
            'GET'=>$this->GET,
            'postData' => $this->postData,
            'uid'   => $this->curUserId,
        ];

        $this->success($data,0, "调用Admin方法：test 成功");
    }
}