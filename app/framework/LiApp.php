<?php
declare (strict_types = 1);

namespace App\framework;

use LiPhp\LiComm;
use LiPhp\Config;
use LiPhp\Env;
use LiPhp\Template;
use App\framework\extend\Db;
use App\framework\extend\Redis;

class LiApp
{
    const VERSION = '2.0.3';
    /**
     * @var extend\MySQLi
     */
    public static $db;
    /**
     * @var \Redis
     */
    public static $redis;
    public static int $DT_TIME;
    public static string $DT_IP;
    public static string $appName;
    public static string $domain;

    public static function initialize(): void
    {
        self::$DT_TIME = time();
        self::$DT_IP = LiComm::ip();
        Env::load(DT_ROOT.'/.env');
        Config::initialize(DT_ROOT . "/config/");
        Config::load(['app', 'db']);
        self::$appName =Config::get('app.name', 'LiteApp');
        self::$domain =Config::get('app.domain', '');
        define('ENVIRONMENT', Config::get('app.ENVIRONMENT', 'DEV'));
        define('DT_DEBUG', Config::get('app.APP_DEBUG', true));
        if (DT_DEBUG) {
            error_reporting(E_ALL);
        } else {
            error_reporting(E_ERROR);
        }
        define('APP_VERSION', Config::get('app.version', self::VERSION));
        define('DT_KEY', Config::get('app.authkey', 'LitePhp'));
        define('DT_SKIN', '/template/' . Config::get('app.template', 'default') . "/skin");
        define("DT_STATIC", '/template/static');
        Template::init(DT_ROOT, Config::get('app.template', 'default'), DT_ROOT . "/runtime/cache");

    }

    /**
     * 连接数据库
     * @param int $i 为配置文件db列表里的第几个配置
     * @return void
     */
    public static function set_db(int $i = 0): void
    {
        self::$db = Db::Create(Config::get('db'), $i);
    }

    /**
     * 连接一个新的数据库
     * @param int $i 为配置文件db列表里的第几个配置
     * @return false|extend\MySQLi|extend\SqlSrv|extend\MongoDB
     */
    public static function new_db(int $i = 0)
    {
        return Db::Create(Config::get('db'), $i, true);
    }

    /**
     * 连接Redis
     * @param bool $reconnect 重连
     * @return void
     */
    public static function set_redis(bool $reconnect = false): void
    {
        if(empty(self::$redis) || $reconnect) {
            if(!Config::exists('redis')) {
                Config::load(['redis']);
            }
            self::$redis = Redis::Create(Config::get('redis'));
        }
    }

    public static function alog(string $type, ?string $log1='', ?string $log2 = '', ?string $log3 = '' )
    {
        return self::$db->table('alog')->insert([
            'type' => $type,
            'log1' => $log1,
            'log2' => $log2,
            'log3' => $log3
        ]);

    }

    /**
     * 设置 Cookie
     * @param string $key
     * @param string|null $value
     * @param int $time
     * @return bool
     */
    public static function setCookie(string $key, ?string $value = null, int $time = 0): bool
    {
        $time = $time > 0 ? self::$DT_TIME + $time : 0;
        if(is_null($value)) $time = self::$DT_TIME - 3600;
        $secure = $_SERVER['REQUEST_SCHEME'] == 'https';
        $var = Config::get('app.cookie_pre', 'Lite_') . $key;
        return setcookie($var, $value, $time, Config::get('app.cookie_path', ''), Config::get('app.cookie_domain', ''), $secure);
    }

    /**
     * 读取 Cookie
     * @param $var
     * @return string
     */
    public static function getCookie($var): string
    {
        $var =  Config::get('app.cookie_pre', 'Lite_') . $var;
        return $_COOKIE[$var] ?? '';
    }

    /**
     * 默认头像图标
     * @return string
     */
    public static function defaultAvatar(): string
    {
        return DT_STATIC.'/default_avatar_bg.png';
    }

    /**
     * 输出分页HTML
     * @param int $count
     * @param int $pageNum
     * @param string $pageKey
     * @return string
     */
    public static function pagination(int $count, int $pageNum = 0, string $pageKey = 'page'): string
    {
        if($pageNum <= 0){
            $pageNum = Config::get('admin.pageNum', 50);
        }
        if($pageNum <= 0) $pageNum = 1;
        if(empty($count)) $count = 0;
        $p = ceil($count / $pageNum);
        //if($p ==1) return '';   //只有一页时，不显示分页条
        $a = '';
        foreach($_GET as $k=>$v){
            if($k != $pageKey ) $a.='&'.$k.'='.$v;
        }
        $curPage = isset($_GET[$pageKey]) ? intval($_GET[$pageKey]) : 1;
        if($curPage < 1) $curPage = 1;
        $ret = '<nav aria-label="Page navigation admin"><ul class="pagination pagination-sm"><li class="page-item';
        if($curPage == 1){
            $ret .= ' disabled';
        }
        $prePage = $curPage - 1;
        $ret .= '"><a class="page-link" href="?'.$pageKey.'='.$prePage.$a.'">Previous</a></li>';
        if($curPage > 10){ $bi = $curPage - 9; $pi = $bi + 30;}
        else{$bi = 1; $pi = 30;}
        if($pi > $p){ $pi = $p;}
        for($i=$bi; $i<=$pi; $i ++){
            if($curPage == $i){
                $ret .='<li class="page-item active" aria-current="page"><span class="page-link">'.$i.'</span></li>';
            }else{
                $ret .= '<li class="page-item"><a class="page-link" href="?'.$pageKey.'='.$i.$a.'">'.$i.'</a></li>';
            }
        }
        $ret .= '<li class="page-item';
        if($curPage == $p){
            $ret .= ' disabled';
        }
        $nextPage = $curPage + 1;
        $ret .= '"><a class="page-link" href="?'.$pageKey.'='.$nextPage.$a.'">Next</a></li><li class="page-item"><span class="page-link">共'.$count.'条记录</span></li></ul></nav>';
        return $ret;
    }
}