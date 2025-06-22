<?php

namespace App\api;

use App\framework\AppBase;
use App\framework\extend\Redis;
use App\framework\LiApp;
use App\framework\Response;
use LiPhp\LiComm;
use UNNTech\Encrypt\Request;

class ApiBase extends AppBase
{
    protected $GET;
    protected $postData;
    protected array $response_options = [];

    use \App\traits\crypt;

    public function __construct(){
        parent::__construct();
    }

    public function __call($name, $arguments) {
        //方法名$name区分大小写

        $this->error(400, "调用方法：{$name} 不存在");
    }

    /**
     * Api请求日志记录表，生产环境建议单独记录（如mongodb库）以减少主库压力
     * @return bool|int
     */
    protected function apiLog()
    {
        if (DT_DEBUG){
            $log = [
                'url'      => $_SERVER['PHP_SELF'],
                'params'   => json_encode($_GET, JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE),
                'postData' => file_get_contents("php://input"),
                'ip'       => $this->DT_IP,
                'addtime'  => $this->DT_TIME,
            ];
            return $this->db->table('api_request_log')->insert($log);
        }else{
            return 0;
        }
    }

    /**
     * 解密验签数据
     * @return void
     */
    protected function initialize(): void
    {
        if($this->postData){
            $check = $this->verifySign($this->postData, false);  //如果需要安全验证，要求必须有签名才可以请求，把perforce参数改为true
            if($check === false){
                $this->error(405, '数据验签失败！', ['request'=>$this->postData]);
            }
        }

        /* ---------------
        其它鉴权等
        //--------------*/
    }

    protected function init_request_data(): void
    {
        $this->GET = $_GET;
        $_str = file_get_contents("php://input");
        $_arr = json_decode($_str, true);

        $this->postData = $_arr ?? [];

        //生产环境需自定义通讯密钥，或者根据请求传入的参数分配每个客户端不同的值更新此secret值
        $this->response_options = [
            'secret'      => '',
            'private_key' => '',
            'public_key'  => '',
            'signType'    => $this->postData['signType'] ?? 'NONE',
            'headers'     => [],
            'encrypted'   => $this->postData['encrypted'] ?? false,
            'encryption'  => 'RSA',
            'json_encode_flags'=>JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE,
        ];
    }

    public function response_options(array $options = []): void
    {
        $this->response_options = [...$this->response_options, ...$options];
    }

    /**
     * 设置输出公共 header 参数值
     * @param array $headers
     * @return void
     */
    public function headers(array $headers = []): void
    {
        $this->response_options['headers'] = $headers;
    }

    public function success(array $data = [], int $errcode = 0, string $msg = 'success')
    {
        Response::instance($this->response_options)::success($data, $errcode, $msg);
    }

    public function error(int $errcode = 0, string $msg = 'fail', array $data = ['void'=>null])
    {
        Response::instance($this->response_options)::error($errcode, $msg, $data);
    }

    /**
     * 接口方法运行入口
     * @param string $path
     * @return mixed|null
     */
    final public function run(string $path = '')
    {
        $this->apiLog();
        $requestPath = isset($_SERVER['PATH_INFO']) ? explode('/',$_SERVER['PATH_INFO']) : [];
        $pathInfoCount = count($requestPath);
        if($pathInfoCount >= 3){
            $_func = array_pop($requestPath);
            $_i = strpos($_func, '.');
            $func = $_i === false ? $_func : substr($_func, 0, $_i);
            unset($requestPath[0]);
            $action = implode("\\", $requestPath);
            $newClass = "App\\api\\controller\\";
            if(!empty($path)){
                $newClass .= str_replace('/', "\\", $path)  . "\\" ;
            }
            $newClass .= $action;
            try{
                $filename = DT_ROOT. '/app/api/controller/';
                if(!empty($path)){
                    $filename .= $path . '/';
                }
                $filename .= str_replace("\\", '/', $action) . '.php';
                if(file_exists($filename)){

                    $api = new $newClass();
                    $api->init_request_data();
                    $api->initialize();
                    $api->$func();

                    return $api;

                }else{
                    $this->error(404,'接口不存在！');
                }

            }catch(\Throwable $e){
                $emsg = $e->getMessage();
                if(DT_DEBUG){
                    $data = ['request'=>$this->postData, 'exception'=>$e, 'code'=>$e->getCode(),'message'=>$e->getMessage(), 'trace'=>$e->getTrace()];
                }else{
                    $data = [];
                }
                $this->error(417, $emsg, $data);
            }
        }else{
            $this->error(400, '无效请求');
        }

        return null;
    }

    /**
     * 请求数据生成签名
     * @param array $data
     * @param string $type
     * @return array
     */
    public function request(array $data, string $type = 'array') : array
    {
        return Request::instance($this->response_options)::generate($data, $type);
    }

    /**
     * 验签
     * @param array $data
     * @param bool $perforce
     * @return bool
     */
    public function verifySign(array &$data, bool $perforce = false) : bool
    {

        return Response::instance($this->response_options)::verifySign($data, $perforce);

    }

    public function authorize_access_token(?string $appid, ?string $secret): array
    {
        if(empty($appid)){
            return ['suc'=>false, 'msg'=>'Appid 不能为空'];
        }
        $r = $this->db->table('app_secret')->where(['appid'=>$appid])->selectOne();
        if($r){
            if($r['status'] < 1 || ($r['status'] == 2 && $r['expires'] < $this->DT_TIME) || $r['appsecret'] != $secret){
                return ['suc'=>false, 'msg'=>'Appid 状态不正常或secret不正确'];
            }else{
                $exp = $this->DT_TIME + 7200;
                $jwt = ['sub'=>$appid, 'exp'=>$exp];
                $token = $this->getToken($jwt);
                LiApp::set_redis();
                $_str = serialize(['token'=>$token, 'secret'=>$secret]);
                Redis::set("ACCESS_".$appid, $_str, 7200);
                return [
                    'suc'          => true,
                    'access_token' => $token,
                    'expires_in'   => $exp,
                ];
            }
        }else{
            return ['suc'=>false, 'msg'=>'Appid 不存在'];
        }
    }

    public function access_token_generate(?string $appid): array
    {
        if(empty($appid)){
            return ['suc'=>false, 'msg'=>'Appid 不能为空'];
        }
        if(strlen($appid) < 32){
            return ['suc'=>false, 'msg'=>'请求设备UUID长度不能小于32位'];
        }
        $exp = $this->DT_TIME + 7200;
        $jwt = ['sub'=>$appid, 'exp'=>$exp];
        $token = $this->getToken($jwt);
        $secret = LiComm::createNonceStr(32);
        LiApp::set_redis();
        $_str = serialize(['token'=>$token, 'secret'=>$secret]);
        Redis::set("ACCESS_".$appid, $_str, 7200);
        return [
            'suc'          => true,
            'access_token' => $token,
            'expires_in'   => $exp,
            'secret'       => $secret,
        ];
    }

}