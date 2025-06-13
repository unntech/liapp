<?php

namespace App\controller\admin;

use App\controller\Admin;

class sample extends Admin
{
    public function __construct(){
        parent::__construct();
    }

    public function index(): void
    {
        $list = array('loop 1','loop 2','loop 3');
        $pageTotal = 180;
        $this->activeMenu = 23;
        $this->currentAuthNode = 22;
        $this->author();
        $this->view('', compact('list', 'pageTotal'), ['admin']);
    }

    public function api(): void
    {
        $this->currentAuthNode = 23;
        $this->author();
        $action = $this->postData['action'] ?? '';
        switch ($action){
            case 'TEST':
                $this->success($this->postData);
                break;
            default:
                $this->error(9, '非法无效请求！');
        }

    }
}