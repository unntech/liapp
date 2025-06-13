<?php
namespace App\framework;

use LiPhp\Template;
use App\framework\Response;

class Controller extends AppBase
{
    protected $GET, $POST, $postData;
    protected string $title;
    protected string $functionName = '', $className = '';

    public function __construct()
    {
        parent::__construct();
        $this->init_request_data();
        $this->title = config('app.name');
    }

    public function __call($name, $arguments) {
        //方法名$name区分大小写

        //Template::message("调用方法：{$name} 不存在！");
        $this->exception("调用方法：{$name} 不存在！", 405);
    }

    protected function init_request_data()
    {
        $this->GET = $_GET;
        $this->POST = $_POST;
        $postStr = file_get_contents("php://input");
        $this->postData = empty($postStr) ? [] : json_decode($postStr, true);
    }

    /**
     * 控制器方法运行入口
     * @param string $path
     * @return mixed|null
     */
    final public function run(string $path = ''){
        $requestPath = isset($_SERVER['PATH_INFO']) ? explode('/',$_SERVER['PATH_INFO']) : [];
        $pathInfoCount = count($requestPath);
        if($pathInfoCount >= 3){
            $_func = array_pop($requestPath);
            $_i = strpos($_func, '.');
            $func = $_i === false ? $_func : substr($_func, 0, $_i);
            unset($requestPath[0]);
            $action = implode("\\", $requestPath);
            $newClass = "App\\controller\\";
            $_className = '';
            if(!empty($path)){
                $_path = str_replace('/', "\\", $path)  . "\\";
                $_className .= $_path;
                $newClass .= $_path;
            }
            $newClass .= $action;
            $_className .= $action;
            try{
                $filename = DT_ROOT. '/app/controller/';
                if(!empty($path)){
                    $filename .= $path . '/';
                }
                $filename .= str_replace("\\", '/', $action) . '.php';
                if(file_exists($filename)){

                    $http = new $newClass();
                    $http->setCurFuncName($func);
                    $http->setClassName($_className);
                    $http->$func();

                    return $http;

                }else{
                    $this->exception('控制器不存在', 404);
                }

            }catch(\Throwable $e){
                exception_handler($e);
            }
        }else{
            $this->exception('无效请求', 400);
        }

        return null;
    }

    protected function exception(string $message, int $code = 0)
    {
        $msg = $code . ': ' . $message;
        $html = '<html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"><title>HTTP 500</title><style>body{background-color:#444;font-size:16px;}h3{font-size:32px;color:#eee;text-align:center;padding-top:50px;font-weight:normal;}</style></head>';
        $html .= '<body><h3>' . $msg . '</h3></body></html>';
        echo $html;
        exit(0);
    }

    /**
     * 输出视图模版文件
     * @param string $template 模版文件名，支持多级目录，为空时为当前调用的类目录加方法名
     * @param array $vars 视图输出需要的变量组
     * @param array $CSS 视图需要载入的CSS， ['sample','test']
     * @return void
     */
    public function view(string $template = '', array $vars = [], array $CSS = [])
    {
        $DT_TIME = $this->DT_TIME;
        $DT_IP = $this->DT_IP;
        $title = $this->title;
        extract($vars);
        if($template == ''){
            $_filename = $this->functionName;
            $_dir = str_replace("\\", '/', $this->className);
            $template = $_dir.'/'.$_filename;
        }else{
            /*---
            $_separate = strrpos($template, '/');
            if($_separate === false){
                $_filename = $template;
                $_dir = '';
            }else{
                $_filename = substr($template, $_separate + 1 );
                $_dir = substr($template, 0, $_separate);
            }
            ----*/

        }

        include Template::load($template);
    }

    public function message(string $promptMessage, ?string $msgTitle = '')
    {
        Template::message($promptMessage, $msgTitle);
    }


    public function success(array $data, int $errcode = 0, string $msg = 'success')
    {
        Response::success($data, $errcode, $msg);
    }

    public function error(int $errcode = 0, string $msg = 'fail', array $data = [])
    {
        Response::error($errcode, $msg, $data);
    }

    protected function setCurFuncName(string $func): void
    {
        $this->functionName = $func;
    }

    protected function setClassName(string $className): void
    {
        $this->className = $className;
    }
}