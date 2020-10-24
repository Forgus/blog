---
title: 如何优雅地发布博客
date: 2020-10-24
catalog: true
tags:
- 建站
- 博客
---
# 背景
1.目前获取信息已经很便利了，但是信息太多，而且重复、错误、干扰信息太多，搜索引擎也很难快速找到自己真正需要的信息，因此建立个人信息检索库相当有必要。
2.写博客是一种比较好的管理自己知识库的方式，最好放到万维网上，能随时随地访问，还需要支持全文检索。
3.最好能部署在自己的服务器上，那么问题来了，怎样才能拥有自己的服务器？一般都是租的vps，但是需求只是要托管下自己的博客，每个月还要掏一笔服务器的租赁费用，成本太高，不可持续。最好能有一次开销，一劳永逸的方案。

# 需求
1.搭建个人博客站点，要求低成本，一次性开销。
2.响应速度要快，支持全文检索。
3.支持markdown格式，发布简单。

# 方案

树莓派+花生壳+Hexo+Nginx

1.花生壳花6元就可以买到一个壳域名，支持内网穿透，永久使用，每个月1G流量，个人使用足够。

2.树莓派Model3A+，成本不到200人民币，功率5w，每个月电费基本可以忽略不计。

3.Hexo支持markdown，可以生成成静态HTML文件，GitHub上相关主题丰富。

4.Nginx作为web服务器，实现站点高性能访问。

Nginx配置：

```
server {
	listen 80;
	server_name forgus.vicp.io;
	location / {
		root /home/pi/blog/public;
		index index.html index.htm;
	}
	location ^~ /resources {
		root /home/pi/;
	}
	location /pi-dashboard {
		proxy_pass http://localhost;
	}
}
```

待续。。。