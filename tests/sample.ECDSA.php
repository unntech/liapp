<?php
require '../autoload.php';

use UNNTech\Encrypt\ECDSA;

$ecdsa = new ECDSA();
//生成ECDSA公私钥
$c = $ecdsa->createKey();
var_dump($c);

$publicKey = $c['public'];
$privateKey = $c['private'];

$ecdsa = new ECDSA( $publicKey, $privateKey );
$data = '测试ECDSA数据';
//生成ECDSA签名
$sign = $ecdsa->sign( $data );
//验证ECDSA签名
$y = $ecdsa->verifySign( $data, $sign );
var_dump( $sign, $y );

$arr = ['order'=>'20200826001','money'=>200];
//生成ECDSA签名数据数组
$arr = $ecdsa->signArray($arr);
//验证ECDSA签名数组
$y = $ecdsa->verifySignArray($arr);
var_dump($arr,$y);

//ECIES加密
$x = $ecdsa->encrypt( $data );
var_dump( $x );
//ECIES解密
$y = $ecdsa->decrypt( $x['ciphertext'], $x['tempPublicKey'], $x['iv'], $x['mac'], $x['code'] );
var_dump( $y );
