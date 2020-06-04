---
layout: post
title:  "Jquery轮播和悬浮效果"
date:   2019-04-08 09:00:00 +0800
categories: code
---
Jquery轮播

```html
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <style type="text/css">
        body, ul {
            margin: 0;
            padding: 0;
            list-style: none;
        }

        .big-screen {
            width: 800px;
            margin: 0 auto;
        }

        .pic-list li {
            float: left;
            cursor: pointer;
        }

        .infoList {
            position: absolute;
            left: 10px;
            bottom: 10px;
            z-index: 30;
        }

        .infoList li {
            display: none;
        }

        .infoList .infoOn {
            color: white;
            display: inline;
        }

        .indexList {
            position: absolute;
            right: 10px;
            bottom: 5px;
            z-index: 30;
        }

        .indexList li {
            float: left;
            margin-right: 5px;
            padding: 2px 4px;
            border: 2px solid black;
            background: grey;
            cursor: pointer;
        }

        .indexList .indexOn {
            background: red;
            font-weight: bold;
            color: white;
        }

        #wrapper {
            width: 800px;
            height: 400px;
            margin: 0 auto;
            overflow: hidden;
            position: relative;
        }
    </style>
</head>
<body>
<div id="wrapper">
    <div id="banner" class="big-screen">
        <ul class="pic-list">
            <li><img/></li>
            <li><img/></li>
            <li><img/></li>
            <li><img/></li>
            <li><img/></li>
        </ul>
        <img id="prev" src="./img/prev.png"/> <img id="next"
                                                   src="./img/next.png"/>

        <div class="bg"></div>
        <!-- 图片底部背景层部分-->
        <ul class="infoList">
            <!-- 图片左下角文字信息部分 -->
            <li class="infoOn">puss in boots1</li>
            <li>puss in boots2</li>
            <li>puss in boots3</li>
            <li>puss in boots4</li>
            <li>puss in boots5</li>
        </ul>
        <ul class="indexList">
            <!-- 图片右下角序号部分 -->
            <li class="indexOn">1</li>
            <li>2</li>
            <li>3</li>
            <li>4</li>
            <li>5</li>
        </ul>
    </div>
</div>

<script src="http://apps.bdimg.com/libs/jquery/1.10.2/jquery.min.js"></script>
<script
        src="http://apps.bdimg.com/libs/jquerymobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<script type="text/javascript">

    function bannerGo(picPath, width, height) {
        bindEvent();

        //---addPicPath start ---
        $(".pic-list li img").each(function (index, element) {
            $(this).attr("src", picPath[index]);
            $(this).css("width", width);
            $(this).css("height", height);
        });
        //---addPicPath end ---


        //---initBanner start ---
        var len = $(".pic-list li").length, index = 0, autoPlay, timer;
        $(".pic-list").append($("li:first").clone());
        var ulWidth = width * (len + 1);
        $(".pic-list").css({
            "width": ulWidth
        });
        //---initBanner end ---

        //---绑定事件 start ---
        function bindEvent() {
            $("#banner").hover(function () {
                clearInterval(autoPlay);
            }, function () {
                autoPlay = setInterval(function () {
                    bannerPlay();
                }, 4000);
            }).trigger("mouseleave");

            $(".indexList li").hover(function () {
                clearInterval(autoPlay);
                index = $(this).index();
                timer = setTimeout(function () {
                    playToX(index);
                }, 200);
            }, function () {
                if (timer)
                    clearTimeout(timer);
                index++;
            });

            //---手机拖动 start---
            $(".pic-list li").on("swiperight", function () {
                indexChange("--");
                playToX(index);
            });
            $(".pic-list li").on("swipeleft", function () {
                indexChange("++");
                playToX(index);
            });
            ////---手机拖动 start---

        }
        //---绑定事件 start ---


        //---轮播图播放 start ---
        function bannerPlay() {
            $(".pic-list").animate({
                "margin-left": -width * index
            }, 1000, function () {
                if (index > len) {
                    index = 1;
                    $(".pic-list").css({
                        "margin-left": "0px"
                    });
                }
                $(".indexList li").removeClass("indexOn");
                $(".indexList li").eq(index - 1).addClass("indexOn");
                $(".infoList li").removeClass("infoOn");
                $(".infoList li").eq(index - 1).addClass("infoOn");
                console.log("图片轮播到第 " + index + " 张");
            });
            index++;
        }
        //---轮播图播放 end ---

        //---播放到index页 start ---
        function playToX(index) {
            $(".pic-list").animate({
                "margin-left": -width * index
            }, 500, function () {
                $(".indexList li").removeClass("indexOn");
                $(".indexList li").eq(index).addClass("indexOn");
                $(".infoList li").removeClass("infoOn");
                $(".infoList li").eq(index).addClass("infoOn");
                console.log("图片轮播到第 " + index + " 张");
            });
        }
        //---播放到index页 end ---

        function indexChange(method) {
            if (method == "++" && index < len) {
                index++;
            } else if (method == "--" && index > 0) {
                index--;
            }
        }
    }


</script>

<script type="text/javascript">
    var picPath = ["./img/bike.jpg", "./img/coffee.jpg", "./img/like.jpg",
        "./img/road.jpg", "./img/tree.jpg"];
    bannerGo(picPath, "800", "400");
</script>

</body>
</html>


```
未完善，待续


---
悬浮效果实现
有两种效果：

- 1 固定在某个地方，直接定位并将模式变成固定（“fixed”）
```html
<html>
<head>
<style type="text/css">
#fudong {
	border: 1px solid #454545;
	position: fixed;
	left: 20px;
	top: 100px;
}
</style>
</head>
<div id="fudong">
	<img alt=""
		src="http://www.yuanlp.com/include/web/v0/images/public/module_cook.png">
</div>

登录 | 注册 pan_junbiao的专栏 目录视图摘要视图订阅 【公告】博客系统优化升级
【知识库发布】国外敏捷转型案例-敏捷软件开发知识体系 博乐招募开始啦 不得不学的编程语言 关闭 JQuery实现悬浮层 标签：
jquerytimerfunctionborder脚本html 2012-10-02 11:36 5615人阅读 评论(1) 收藏 举报 分类：
JQuery（9） 我の原创（113） 版权声明：本文为博主原创文章，未经博主允许不得转载。 JQuery实现悬浮层 1、HTML代码

[html] view plain copy 右侧悬浮层 2、JS脚本 [javascript] view plain copy
$(function() { var timer, scrollTop, sideDiv =
$('#fudong').appendTo('body'); $(window).scroll(function() { timer &&
clearTimeout(timer); scrollTop = $(this).scrollTop(); timer =
setTimeout(function() { sideDiv.animate({ top: scrollTop + 100 + 'px' },
600); }, 200); }); }); 顶 0 踩 0 上一篇JQuery.cookie.js实现最近浏览过的商品
下一篇AjaxUpLoad.js使用实现文件上传 我的同类文章 JQuery（9） 我の原创（113）
•popShow弹出层的使用（二）2014-01-20阅读614 •JQuery实现分页功能2013-02-15阅读8958
•JQuery加载并解析XML2012-04-09阅读12879 •使用jqzoom插件实现图片放大镜效果2012-04-04阅读7221
•jquery获取和设置radio,check,select选项2011-11-26阅读13358
•JQuery函数积累2013-10-13阅读778 •JQuery.cookie.js实现最近浏览过的商品2012-10-02阅读4423
•popShow弹出层的使用（一）2012-04-05阅读2402
•JQuery实现导航效果、新闻滚动、广告效果、横向滚动2012-04-03阅读9566 猜你在找
2016年新课程的第一阶段javascript+jquery课程HTML
5视频教程系列之JavaScript学习篇js+ajax+jquery+easyui从入门到精通（项目实战）jquery焦点图效果PHP基础视频-HTML、CSS、js
jquery实现的固定位置下拉隐藏上拉显示悬浮导航菜单特效jquery实现隔行变色点击换色鼠标悬浮当前行变色效果div+css
细表格样式Jquery实现的悬浮按钮浮现图片使用jQuery实现鼠标悬浮图片轮换效果jQuery实现 返回顶部 和 导航悬浮 查看评论 1楼
niezuo123 2014-11-15 20:27发表 [回复] 这代码不行 您还没有登录,请[登录]或[注册] *
以上用户言论只代表其个人观点，不代表CSDN网站的观点或立场 核心技术类目 全部主题 Hadoop AWS 移动游戏 Java Android
iOS Swift 智能硬件 Docker OpenStack VPN Spark ERP IE10 Eclipse CRM
JavaScript 数据库 Ubuntu NFC WAP jQuery BI HTML5 Spring Apache .NET API
HTML SDK IIS Fedora XML LBS Unity Splashtop UML components Windows
Mobile Rails QEMU KDE Cassandra CloudStack FTC coremail OPhone CouchBase
云计算 iOS6 Rackspace Web App SpringSide Maemo Compuware 大数据 aptech Perl
Tornado Ruby Hibernate ThinkPHP HBase Pure Solr Angular Cloud Foundry
Redis Scala Django Bootstrap 个人资料 访问我的空间 pan_junbiao 2 访问：546302次
积分：5472 等级： 排名：第3291名 原创：114篇转载：32篇译文：0篇评论：54条 文章搜索 搜索 文章分类 WCF(3)
JavaScript(18) SQL Server数据库(10) ASP.NET技术(52) WPF/Silverlight(10)
HTML(4) MVVM(3) HTML DOM(2) JQuery(10) AngularJS(1) Android应用(2)
JAVA技术(7) CSS(7) LINQ(6) XML(4) 正则表达式(6) 文件处理(6) API(6) Excel(6) 面试题(2)
电脑の爱好者(4) 我の应用(12) 我の原创(114) 文章存档 2016年06月(4) 2016年04月(7) 2016年03月(6)
2016年02月(3) 2014年11月(1) 展开 阅读排行 LINQ To SQL 语法及实例大全(59069)
AjaxUpLoad.js使用实现文件上传(40931) NPOI使用手册(33859) 区域下拉框的实现与使用(29432)
腾讯空间、新浪微博、腾讯微博分享接口(18098) CSS强制英文、中文换行与不换行 强制英文换行(17444) C# 反射
通过类名创建类实例(16956) C#使用GET、POST请求获取结果(16866)
jquery获取和设置radio,check,select选项(13369) JQuery加载并解析XML(12892) 评论排行 LINQ
To SQL 语法及实例大全(11) AjaxUpLoad.js使用实现文件上传(5) C#二维码生成(5)
JQuery实现导航效果、新闻滚动、广告效果、横向滚动(4) C# 反射 通过类名创建类实例(3) Marquee.js实现跑马灯效果(3)
ASP.NET母版页和Web用户控件的使用(2) C#文件上传与下载(2) 腾讯空间、新浪微博、腾讯微博登录接口(2)
JavaScript日期控件(2) 推荐文章 * 郭神带你真正理解沉浸式模式 * 优秀代码的格式准则 *
Hadoop的数据仓库实践——OLAP与数据可视化（二） * Android 视图篇——恼人的分割线留白解决之道 *
移动端开发者眼中的前端开发流程变迁与前后端分离 最新评论 NPOI使用手册 a487487487: 非常详细的说明，感谢
DataSet数据集的遍历 栗振娟: 学习啦，加油! LINQ To SQL 语法及实例大全 Xuxz: 抄得不错 C# 反射
通过类名创建类实例 vodchk: 不错，实用 NPOI使用手册 wow蜗牛: 666666，非常有用 ，谢谢 C#二维码生成
镜花水月_csdn: 可以提供下ThoughtWorks.QRCode.dll库文件么？ C#二维码生成 rxing_tangtao:
可以发一个完整的工程吗 AjaxUpLoad.js使用实现文件上传 青涩的小插曲:
是不是如果页面有多个上传图片按钮，你就得初始化多次，能否写成公用呢。楼主是否考虑合并 LINQ To SQL 语法及实例大全 mayfla:
分成个系列博客多好，还可以总结一下自己的想法 构建一个简单的WCF应用 Doc_Fank: 为什么我找不到wcf的核心程序集呀？
求资源..... 。0.0 公司简介|招贤纳士|广告服务|银行汇款帐号|联系方式|版权声明|法律顾问|问题报告|合作伙伴|论坛反馈
网站客服杂志客服微博客服webmaster@csdn.net400-600-2320|北京创新乐知信息技术有限公司
版权所有|江苏乐知网络技术有限公司 提供商务支持 京 ICP 证 09002463 号|Copyright © 1999-2014,
CSDN.NET, All Rights Reserved GongshangLogo


<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.4.1.min.js"></script>
<script>
	//$(document).ready(suspend());
	function suspend() {
		var timer, scrollTop, sideDiv = $('#fudong').appendTo('body');
		$(window).scroll(function() {
			timer && clearTimeout(timer);
			scrollTop = $(this).scrollTop();
			timer = setTimeout(function() {
				sideDiv.animate({
					top : scrollTop + 100 + 'px'
				}, 600);
			}, 50);
		});
	}
</script>
</html>
```
- 2 有个滑动的效果，看起来更酷炫一些。具体做法是写jq滑动语句动态改变方位。
```html
<html>
<head>
<style type="text/css">
#fudong {
	border: 1px solid #454545;
	position: absolute;
	left: 20px;
	top: 100px;
}
</style>
</head>
<div id="fudong">
	<img alt=""
		src="http://www.yuanlp.com/include/web/v0/images/public/module_cook.png">
</div>

登录 | 注册 pan_junbiao的专栏 目录视图摘要视图订阅 【公告】博客系统优化升级
【知识库发布】国外敏捷转型案例-敏捷软件开发知识体系 博乐招募开始啦 不得不学的编程语言 关闭 JQuery实现悬浮层 标签：
jquerytimerfunctionborder脚本html 2012-10-02 11:36 5615人阅读 评论(1) 收藏 举报 分类：
JQuery（9） 我の原创（113） 版权声明：本文为博主原创文章，未经博主允许不得转载。 JQuery实现悬浮层 1、HTML代码

[html] view plain copy 右侧悬浮层 2、JS脚本 [javascript] view plain copy
$(function() { var timer, scrollTop, sideDiv =
$('#fudong').appendTo('body'); $(window).scroll(function() { timer &&
clearTimeout(timer); scrollTop = $(this).scrollTop(); timer =
setTimeout(function() { sideDiv.animate({ top: scrollTop + 100 + 'px' },
600); }, 200); }); }); 顶 0 踩 0 上一篇JQuery.cookie.js实现最近浏览过的商品
下一篇AjaxUpLoad.js使用实现文件上传 我的同类文章 JQuery（9） 我の原创（113）
•popShow弹出层的使用（二）2014-01-20阅读614 •JQuery实现分页功能2013-02-15阅读8958
•JQuery加载并解析XML2012-04-09阅读12879 •使用jqzoom插件实现图片放大镜效果2012-04-04阅读7221
•jquery获取和设置radio,check,select选项2011-11-26阅读13358
•JQuery函数积累2013-10-13阅读778 •JQuery.cookie.js实现最近浏览过的商品2012-10-02阅读4423
•popShow弹出层的使用（一）2012-04-05阅读2402
•JQuery实现导航效果、新闻滚动、广告效果、横向滚动2012-04-03阅读9566 猜你在找
2016年新课程的第一阶段javascript+jquery课程HTML
5视频教程系列之JavaScript学习篇js+ajax+jquery+easyui从入门到精通（项目实战）jquery焦点图效果PHP基础视频-HTML、CSS、js
jquery实现的固定位置下拉隐藏上拉显示悬浮导航菜单特效jquery实现隔行变色点击换色鼠标悬浮当前行变色效果div+css
细表格样式Jquery实现的悬浮按钮浮现图片使用jQuery实现鼠标悬浮图片轮换效果jQuery实现 返回顶部 和 导航悬浮 查看评论 1楼
niezuo123 2014-11-15 20:27发表 [回复] 这代码不行 您还没有登录,请[登录]或[注册] *
以上用户言论只代表其个人观点，不代表CSDN网站的观点或立场 核心技术类目 全部主题 Hadoop AWS 移动游戏 Java Android
iOS Swift 智能硬件 Docker OpenStack VPN Spark ERP IE10 Eclipse CRM
JavaScript 数据库 Ubuntu NFC WAP jQuery BI HTML5 Spring Apache .NET API
HTML SDK IIS Fedora XML LBS Unity Splashtop UML components Windows
Mobile Rails QEMU KDE Cassandra CloudStack FTC coremail OPhone CouchBase
云计算 iOS6 Rackspace Web App SpringSide Maemo Compuware 大数据 aptech Perl
Tornado Ruby Hibernate ThinkPHP HBase Pure Solr Angular Cloud Foundry
Redis Scala Django Bootstrap 个人资料 访问我的空间 pan_junbiao 2 访问：546302次
积分：5472 等级： 排名：第3291名 原创：114篇转载：32篇译文：0篇评论：54条 文章搜索 搜索 文章分类 WCF(3)
JavaScript(18) SQL Server数据库(10) ASP.NET技术(52) WPF/Silverlight(10)
HTML(4) MVVM(3) HTML DOM(2) JQuery(10) AngularJS(1) Android应用(2)
JAVA技术(7) CSS(7) LINQ(6) XML(4) 正则表达式(6) 文件处理(6) API(6) Excel(6) 面试题(2)
电脑の爱好者(4) 我の应用(12) 我の原创(114) 文章存档 2016年06月(4) 2016年04月(7) 2016年03月(6)
2016年02月(3) 2014年11月(1) 展开 阅读排行 LINQ To SQL 语法及实例大全(59069)
AjaxUpLoad.js使用实现文件上传(40931) NPOI使用手册(33859) 区域下拉框的实现与使用(29432)
腾讯空间、新浪微博、腾讯微博分享接口(18098) CSS强制英文、中文换行与不换行 强制英文换行(17444) C# 反射
通过类名创建类实例(16956) C#使用GET、POST请求获取结果(16866)
jquery获取和设置radio,check,select选项(13369) JQuery加载并解析XML(12892) 评论排行 LINQ
To SQL 语法及实例大全(11) AjaxUpLoad.js使用实现文件上传(5) C#二维码生成(5)
JQuery实现导航效果、新闻滚动、广告效果、横向滚动(4) C# 反射 通过类名创建类实例(3) Marquee.js实现跑马灯效果(3)
ASP.NET母版页和Web用户控件的使用(2) C#文件上传与下载(2) 腾讯空间、新浪微博、腾讯微博登录接口(2)
JavaScript日期控件(2) 推荐文章 * 郭神带你真正理解沉浸式模式 * 优秀代码的格式准则 *
Hadoop的数据仓库实践——OLAP与数据可视化（二） * Android 视图篇——恼人的分割线留白解决之道 *
移动端开发者眼中的前端开发流程变迁与前后端分离 最新评论 NPOI使用手册 a487487487: 非常详细的说明，感谢
DataSet数据集的遍历 栗振娟: 学习啦，加油! LINQ To SQL 语法及实例大全 Xuxz: 抄得不错 C# 反射
通过类名创建类实例 vodchk: 不错，实用 NPOI使用手册 wow蜗牛: 666666，非常有用 ，谢谢 C#二维码生成
镜花水月_csdn: 可以提供下ThoughtWorks.QRCode.dll库文件么？ C#二维码生成 rxing_tangtao:
可以发一个完整的工程吗 AjaxUpLoad.js使用实现文件上传 青涩的小插曲:
是不是如果页面有多个上传图片按钮，你就得初始化多次，能否写成公用呢。楼主是否考虑合并 LINQ To SQL 语法及实例大全 mayfla:
分成个系列博客多好，还可以总结一下自己的想法 构建一个简单的WCF应用 Doc_Fank: 为什么我找不到wcf的核心程序集呀？
求资源..... 。0.0 公司简介|招贤纳士|广告服务|银行汇款帐号|联系方式|版权声明|法律顾问|问题报告|合作伙伴|论坛反馈
网站客服杂志客服微博客服webmaster@csdn.net400-600-2320|北京创新乐知信息技术有限公司
版权所有|江苏乐知网络技术有限公司 提供商务支持 京 ICP 证 09002463 号|Copyright © 1999-2014,
CSDN.NET, All Rights Reserved GongshangLogo


<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.4.1.min.js"></script>
<script>
	$(document).ready(suspend());
	function suspend() {
		var timer, scrollTop, sideDiv = $('#fudong').appendTo('body');
		$(window).scroll(function() {
			timer && clearTimeout(timer);
			scrollTop = $(this).scrollTop();
			timer = setTimeout(function() {
				sideDiv.animate({
					top : scrollTop + 100 + 'px'
				}, 600);
			}, 50);
		});
	}
</script>
</html>
```