<?php
declare (strict_types = 1);

defined('IN_LitePhp') or exit('Access Denied');

use App\framework\LiApp;

function set_cookie(string $key, string $value = '', $time = 0): bool
{
    return LiApp::setCookie($key, $value, $time);
}

function get_cookie(string $key): string
{
    return LiApp::getCookie($key);
}

function pagination(int $count, int $pageNum = 0, string $pageKey = 'page'): string
{
    return LiApp::pagination($count, $pageNum, $pageKey);
}

/**
 * 将数字格式化，小数部份变小一号
 * @param $number
 * @param int $decimals
 * @param string|null $thousands_separator
 * @return string
 */
function decimal_small_format($number, int $decimals =2, ?string $thousands_separator = null): string
{
    $num = number_format($number, $decimals, '.', $thousands_separator);
    $p = explode('.', $num);
    $str = (string)$p[0];
    if($p[1]){
        $str .= '.<small>' .$p[1].'</small>';
    }
    return $str;
}