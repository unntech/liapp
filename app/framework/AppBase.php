<?php

namespace App\framework;

abstract class AppBase
{

    protected $db;
    protected string $DT_IP, $domain;
    protected int $DT_TIME;

    public function __construct()
    {
        $this->DT_TIME = LiApp::$DT_TIME;
        $this->DT_IP = LiApp::$DT_IP;
        $this->db = LiApp::$db;
        $this->domain = LiApp::$domain;
    }

}