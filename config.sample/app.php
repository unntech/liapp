<?php
defined('IN_LitePhp') or exit('Access Denied');

use LiPhp\Env;

return [
    'ENVIRONMENT'   => 'DEV',  // 'DEV', 'PRO'
    'APP_DEBUG'     => true,  //生产环境：ENVIRONMENT 设为 PRO, APP_DEBUG 设为 false
    'version'       => '2.0.1',
    'name'          => 'LiteApp',
    'authkey'       => Env::get('app.key', ''),
    'cookie_pre'    => 'Lite_',
    'cookie_path'   => '/',
    'cookie_domain' => '',
    'template'      => 'default',
    'skin'          => 'default',
    'domain'        => Env::get('app.domain', ''),
    'rsaKey'        => [
        'private' => Env::get('rsa.private', ''),

        'public' => Env::get('rsa.public', ''),

        'third_public' => 'MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC0z4L8bC4CMl2TKE7weU2fnlyLsCwtWmyo/yQzIV2BQ2TJk+ortuCjrKUjd6hE8Lo9L3VrWhk9laXzVAWi4axHcJ/U/uH9J4rl+PaTDOQ5my0o/NMdpu5t09SUDY412SA7xme0nmJkRHltW3fPYci5GtulrDb8VLUB65Q+a7TinwIDAQAB',

        'private_key_bits'=>1024
    ],
];