---
layout: post
title:  "Ubuntu安装elasticsearch与spring的联系"
date:   2019-07-30 09:00:00 +0800
categories: config
comments: true
---

公司最近找了一个github上的spring cloud项目给我, 要求我看看能不能部署出来, 其中就包含了elasticsearch.

首先尝试在ubuntu18服务器上安装elasticsearch6.8, 查看[官网安装介绍](https://www.elastic.co/guide/en/elasticsearch/reference/6.8/deb.html#deb)

安装elasticsearch前需有jdk环境

`sudo apt-get install default-jdk`

默认的仓库里没有, 那就按官网的将其加入仓库

`wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -`

`echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-6.x.list`

然后执行apt更新和安装命令就好了

`sudo apt-get update && sudo apt-get install elasticsearch`

安装完成后我们来启动一下

`sudo service elasticsearch start`

我们来试试正常启动了嘛? 这个时候是不能远程访问的

```
ichieh@server:~$ curl 192.168.8.110:9200
curl: (7) Failed to connect to 192.168.8.110 port 9200: Connection refused

ichieh@server:~$ curl 127.0.0.1:9200
{
  "name" : "hv90vdV",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "Y3QCEkGcR2WdbWA7-G7Lfw",
  "version" : {
    "number" : "6.8.2",
    "build_flavor" : "default",
    "build_type" : "deb",
    "build_hash" : "b506955",
    "build_date" : "2019-07-24T15:24:41.545295Z",
    "build_snapshot" : false,
    "lucene_version" : "7.7.0",
    "minimum_wire_compatibility_version" : "5.6.0",
    "minimum_index_compatibility_version" : "5.0.0"
  },
  "tagline" : "You Know, for Search"
}
```

```
#我们去修改一下配置文件, 使得elasticsearch可以被远程访问

ichieh@server:~$ sudo vim /etc/elasticsearch/elasticsearch.yml

network.host: 192.168.8.110
#network.host: 127.0.0.1

ichieh@server:~$ sudo service elasticsearch restart
ichieh@server:~$ curl 192.168.8.110:9200
{
  "name" : "hv90vdV",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "Y3QCEkGcR2WdbWA7-G7Lfw",
  "version" : {
    "number" : "6.8.2",
    "build_flavor" : "default",
    "build_type" : "deb",
    "build_hash" : "b506955",
    "build_date" : "2019-07-24T15:24:41.545295Z",
    "build_snapshot" : false,
    "lucene_version" : "7.7.0",
    "minimum_wire_compatibility_version" : "5.6.0",
    "minimum_index_compatibility_version" : "5.0.0"
  },
  "tagline" : "You Know, for Search"
}
```

此时spring cloud项目去调用elasticsearch的时候发现报下面这个错误.

```log
[2019-07-26T08:49:26,633][WARN ][o.e.t.TcpTransport       ] [vFBemzA] exception caught on transport layer [Netty4TcpChannel{localAddress=/192.168.8.113:9300, remoteAddress=/192.168.8.106:61208}], closing connection
java.lang.IllegalStateException: Received message from unsupported version: [2.0.0] minimal compatible version is: [5.6.0]
        at org.elasticsearch.transport.InboundMessage.ensureVersionCompatibility(InboundMessage.java:137) ~[elasticsearch-6.8.1.jar:6.8.1]
        at org.elasticsearch.transport.InboundMessage.access$000(InboundMessage.java:39) ~[elasticsearch-6.8.1.jar:6.8.1]
        at org.elasticsearch.transport.InboundMessage$Reader.deserialize(InboundMessage.java:76) ~[elasticsearch-6.8.1.jar:6.8.1]
        at org.elasticsearch.transport.TcpTransport.messageReceived(TcpTransport.java:927) ~[elasticsearch-6.8.1.jar:6.8.1]
        at org.elasticsearch.transport.TcpTransport.inboundMessage(TcpTransport.java:763) [elasticsearch-6.8.1.jar:6.8.1]
        at org.elasticsearch.transport.netty4.Netty4MessageChannelHandler.channelRead(Netty4MessageChannelHandler.java:53) [transport-netty4-client-6.8.1.jar:6.8.1]
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:362) [netty-transport-4.1.32.Final.jar:4.1.32.Final]
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:348) [netty-transport-4.1.32.Final.jar:4.1.32.Final]
        at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:340) [netty-transport-4.1.32.Final.jar:4.1.32.Final]
        at io.netty.handler.codec.ByteToMessageDecoder.fireChannelRead(ByteToMessageDecoder.java:323) [netty-codec-4.1.32.Final.jar:4.1.32.Final]
        at io.netty.handler.codec.ByteToMessageDecoder.channelRead(ByteToMessageDecoder.java:297) [netty-codec-4.1.32.Final.jar:4.1.32.Final]
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:362) [netty-transport-4.1.32.Final.jar:4.1.32.Final]
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:348) [netty-transport-4.1.32.Final.jar:4.1.32.Final]
        at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:340) [netty-transport-4.1.32.Final.jar:4.1.32.Final]
        at io.netty.handler.logging.LoggingHandler.channelRead(LoggingHandler.java:241) [netty-handler-4.1.32.Final.jar:4.1.32.Final]
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:362) [netty-transport-4.1.32.Final.jar:4.1.32.Final]
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:348) [netty-transport-4.1.32.Final.jar:4.1.32.Final]
        at io.netty.channel.AbstractChannelHandlerContext.fireChannelRead(AbstractChannelHandlerContext.java:340) [netty-transport-4.1.32.Final.jar:4.1.32.Final]
        at io.netty.channel.DefaultChannelPipeline$HeadContext.channelRead(DefaultChannelPipeline.java:1434) [netty-transport-4.1.32.Final.jar:4.1.32.Final]
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:362) [netty-transport-4.1.32.Final.jar:4.1.32.Final]
        at io.netty.channel.AbstractChannelHandlerContext.invokeChannelRead(AbstractChannelHandlerContext.java:348) [netty-transport-4.1.32.Final.jar:4.1.32.Final]
        at io.netty.channel.DefaultChannelPipeline.fireChannelRead(DefaultChannelPipeline.java:965) [netty-transport-4.1.32.Final.jar:4.1.32.Final]
        at io.netty.channel.nio.AbstractNioByteChannel$NioByteUnsafe.read(AbstractNioByteChannel.java:163) [netty-transport-4.1.32.Final.jar:4.1.32.Final]
        at io.netty.channel.nio.NioEventLoop.processSelectedKey(NioEventLoop.java:656) [netty-transport-4.1.32.Final.jar:4.1.32.Final]
        at io.netty.channel.nio.NioEventLoop.processSelectedKeysPlain(NioEventLoop.java:556) [netty-transport-4.1.32.Final.jar:4.1.32.Final]
        at io.netty.channel.nio.NioEventLoop.processSelectedKeys(NioEventLoop.java:510) [netty-transport-4.1.32.Final.jar:4.1.32.Final]
        at io.netty.channel.nio.NioEventLoop.run(NioEventLoop.java:470) [netty-transport-4.1.32.Final.jar:4.1.32.Final]
        at io.netty.util.concurrent.SingleThreadEventExecutor$5.run(SingleThreadEventExecutor.java:909) [netty-common-4.1.32.Final.jar:4.1.32.Final]
        at java.lang.Thread.run(Thread.java:748) [?:1.8.0_212]

```

spring boot版本是1.x, 这个版本的是不能调用的. 升级为spring boot 2.x就可以了
