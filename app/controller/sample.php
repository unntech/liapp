<?php

namespace App\controller;

use App\framework\Controller;

class sample extends Controller
{
    public function __construct(){
        parent::__construct();
    }


    public function test(): void
    {
        $title = 'Sample controller';
        $list = [
            'name'=>'Lite',
            'addr'=>'深南大道',
        ];

        $this->view('', compact('title', 'list'), ['sample']);
    }
}