<?php

namespace App\controller\member;

use App\framework\Controller;

class user extends Controller
{
    public function __construct(){
        parent::__construct();

    }

    public function info(): void
    {
        $title = 'Sample member user info';
        $list = [
            'name'=>'Lite',
            'addr'=>'ShenZhen',
        ];

        $this->view('sample/test', compact('title', 'list'));
    }
}