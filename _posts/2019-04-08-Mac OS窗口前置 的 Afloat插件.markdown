---
layout: post
title:  "Mac OS窗口前置 的 Afloat插件"
date:   2019-04-08 09:00:00 +0800
categories: software
comments: true
---
Afloat地址：
https://github.com/millenomi/afloat
https://github.com/rwu823/afloat

Afloat是一款很好用的插件，可以控制mac上打开的窗口一直前置和调整透明度。

![](https://raw.githubusercontent.com/rwu823/aflot/master/screens/window-menu.png)
![](https://raw.githubusercontent.com/rwu823/aflot/master/screens/bind-key.png)

#### 注意事项

    如果Mac OS为10.11以上，那么你安装完成后还不能打开这些功能，那是因为Mac OS X 10.11 启用了SIP，没有权限修改该路径下的文件，因此安装之前要先关闭SIP。安装步骤为：

    1. 关闭SIP：重启系统，开机时按住 Command + R键，直到进入恢复模式/选中Recover盘进入。
	2. 点击实用工具菜单，打开终端，执行 `csrutil disable` 命令，重启即可。

```shell
#可以执行该命令安装
sudo curl https://raw.githubusercontent.com/rwu823/afloat/master/install.sh | sh
```
