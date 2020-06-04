---
layout: post
title:  "Ubuntu安装neo4j"
date:   2019-08-02 09:00:00 +0800
categories: blog
---

官网安装教程页面 https://neo4j.com/download-center/#enterprise

使用Debian repository
```
wget -O - https://debian.neo4j.org/neotechnology.gpg.key | sudo apt-key add -
echo 'deb https://debian.neo4j.org/repo stable/' | sudo tee /etc/apt/sources.list.d/neo4j.list
sudo apt-get update
```

安装社区版

```
sudo apt-get install neo4j
```

启动neo4j

```
sudo neo4j start
```

在你的浏览器中地址栏输入：http://<服务器ip地址>:7474/ 即可看到 

第一次登录的控制台的用户名和密码均为neo4j

想要非localhost访问的话需要把`/etc/neo4j/neo4j.conf`文件的这行取消注释

```
dbms.connectors.defalut_listen_address=0.0.0.0
```
