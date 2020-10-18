---
title: 翻墙服务器搭建
date: 2018-09-26
tags:
- 网络工具
---

## 登录VPS服务器

## 执行如下命令

```
wget –no-check-certificate  https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks.sh
```

```
chmod +x shadowsocks.sh
```

```
./shadowsocks.sh 2>&1 | tee shadowsocks.log
```
根据提示设置翻墙账号密码和端口号以及加密方式

