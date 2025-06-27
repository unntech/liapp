
LiteApp 2.0
===============

[![Latest Stable Version](https://poser.pugx.org/unntech/liapp/v/stable)](https://packagist.org/packages/unntech/liapp)
[![Total Downloads](https://poser.pugx.org/unntech/liapp/downloads)](https://packagist.org/packages/unntech/liapp)
[![Latest Unstable Version](http://poser.pugx.org/unntech/liapp/v/unstable)](https://packagist.org/packages/unntech/liapp)
[![PHP Version Require](http://poser.pugx.org/unntech/liapp/require/php)](https://packagist.org/packages/unntech/liapp)
[![License](https://poser.pugx.org/unntech/liapp/license)](https://packagist.org/packages/unntech/liapp)

一个PHP的轻量框架

DEMO:

https://liapp.unn.tech


## 主要新特性
* 最为接近原生PHP写法，满足习惯原生开发的人员开发习惯
* 支持`PHP8`强类型（严格模式）
* 支持更多的`PSR`规范
* 原生多应用支持
* 对IDE更加友好
* 统一和精简大量用法


> LiApp 2.0 的运行环境要求PHP8.1+

## 安装

~~~
composer create-project unntech/liapp yourApp
~~~

~~~
将目录config.sample 改名为 config，把.env.example 改名为.env 可以更据需求增加配置文件/项目
读取例子见：tests/sample.config.php
将runtime目录设为可写权限
docs/liteapp.sql 导入至数据库
~~~

如果需要更新框架使用
~~~
composer update unntech/liphp
~~~

目录结构
~~~
yourApp/
├── admin                                   #Admin后台管理模块基本程序
├── app                                     #App命名空间
│   ├── admin                               #Admin模块基础类
│   ├── api                                 #Api接口
│   │   ├── controller                      #接口控制器目录，支持分项多级子目录
│   │   └── ApiBase.php                     #接口基础类
│   ├── controller                          #控制器方法目录，支持分项多级子目录
│   ├── framework                           #框架核心基础文件
│   │   ├── extend                          #继承vendor框架类，供扩展和重写方法
│   │   ├── AppBase.php                     #app基础父类
│   │   ├── Controller.php                  #控制器调用基础类
│   │   ├── LiApp.php                       #LiteApp通用类，入口初始化数据
│   │   ├── ModelBase.php                   #模型基础类
│   │   └── Response.php                    #API 标准输出类
│   ├── model                               #模型类
│   ├── structure                           #自定义的数据结构体
│   ├── traits
│   ├── ...                                 #其它子模块
├── config                                  #配置文件
│   ├── admin.php                           #Admin后台管理模块配置
│   ├── app.php                             #项目基础配置
│   ├── db.php                              #数据库配置文件
│   ├── redis.php                           #redis配置文件
│   ├── session.php                         #Session配置文件
├── docs                                    #文档
│   ├── liteapp.sql.gz                      #Admin模块数据库
├── include                                 #通用函数库
│   ├── common.php                          #全局通用函数
├── runtime                                 #运行临时目录，需可写权限
├── template                                #视图模板文件
│   ├── default                             #默认模板目标
│   │   ├── skin                            #样式css文件目录
│   │   ├── admin                           #Admin模块视图文件
│   │   └── ...                             #对应视图文件目录
│   ├── static                              #静态资源目录
├── tests                                   #测试样例，可删除
├── vendor                                  #composer目录
├── index.php                               #主页
├── api.php                                 #接口API方法主入口程序
├── authorize.php                           #接口API获取access_token示例
├── autoload.php                            #autoload载入主程序
├── CHANGELOG.md                            #版本更新日志
├── qrcode.php                              #二维码生成程序
├── route.php                               #控制器方法主入口路由程序
├── composer.json                           #
└── README.md
~~~

## 文档
~~~
Admin后台入口：http://{domain}/admin/index.php
用户名：admin 密码：123456
~~~
接口Api使用方法
~~~
http://{domain}/api.php/sample/test
采用PATH_INFO规则RESTful，接口控制器名，支持多级目录，最后一项为方法名
~~~
http控制器使用方法
~~~
http://{domain}/route.php/sample/test
采用PATH_INFO规则，控制器名，支持多级目录，最后一项为方法名，
方法名后面也可以加后缀 .php|.html (如：test.html)，不影响路由规则
~~~

## 升级
* 从LiteApp1 升级到 LiApp2参见：[upgrade.md](upgrade.md)

## 命名规范

`LiApp`遵循PSR命名规范和PSR-4自动加载规范。

## 参与开发

直接提交PR或者Issue即可  
> [版本更新记录 CHANGELOG](CHANGELOG.md)

## 版权信息

LiApp遵循MIT开源协议发布，并提供免费使用。

本项目包含的第三方源码和二进制文件之版权信息另行标注。

版权所有Copyright © 2025 by Jason Lin All rights reserved。

