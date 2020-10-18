---
title: Raspbian安装Nginx
date: 2018-09-11
catalog: true
tags:
- 树莓派
---
## 安装：

```
sudo apt-get update
sudo apt-get install nginx -y
```
## 用法
```
sudo service nginx
```

## 配置
默认配置文件为`nginx.conf`，所在目录：`/etc/nginx`  (mac上为：`/usr/local/etc/nginx`)
该目录下还有一个`conf.d`文件夹，可以在里面添加子配置文件。  
*注意：子配置文件需要以`.conf`结尾。 
每次改完配置文件需要用`sudo service nginx reload`命令让nginx重新加载才会生效，不需要重启。*