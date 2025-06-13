<?php

namespace App\api\controller;

use App\api\ApiBase;

class sample extends ApiBase
{
    public function __construct(){
        parent::__construct();
    }

    //请求处理函数，按需添加编写
    public function test(): void
    {
        $data = [
            'title'=>'This is a testing.',
            'GET'=>$this->GET,
            'postData' => $this->postData,
        ];

        $this->success($data,0, "调用方法：test 成功");
    }
}