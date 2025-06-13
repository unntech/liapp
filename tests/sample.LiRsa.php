<?php
require __DIR__.'/../autoload.php';

use UNNTech\Encrypt\RSA;

//生成RSA公私钥
$rsa = new RSA();
$c = $rsa->createKey();
var_dump($c);

$publicKey = $c['public'];
$privateKey = $c['private'];

$rsa = new RSA( $publicKey, $privateKey );
$data = '测试RSA2';
//生成RSA签名
$sign = $rsa->sign( $data );
//验证RSA签名
$y = $rsa->verifySign( $data, $sign );
var_dump( $sign, $y );

$arr = ['order'=>'20200826001','money'=>200];
//生成RSA签名数据数组
$arr = $rsa->signArray($arr);
//验证RSA签名数组
$y = $rsa->verifySignArray($arr);
var_dump($arr,$y);
//RSA加密
$x = $rsa->encrypt( $data );
//RSA解密
$y = $rsa->decrypt( $x );
var_dump( $x, $y );

