---
layout: post
title:  "VMware安装unlocker问题"
date:   2020-01-09 15:55:57 +0800
categories: VM
---

1.VMware15.1以上的版本无法使用unlocker

2.unlocker的脚本对新生成的文件无效（因为新版本的补丁存放位置与之前不同，页面解析错误）

两种情况下请使用下面方法
（其实就是将补丁先下载下来部署到IIS，将unlocker的请求转到本地）

1）安装`VMware-workstation-full-15.1.0-13591040.exe`

2）host文件指定访问本地
```
127.0.0.1	softwareupdate.vmware.com
```

3）IIS绑定本机80端口

在项目目录下复制`cds.zip`文件内容并解压

4）使用`unlocker`

对应文件需要可以留邮件（百度云分享失败）




