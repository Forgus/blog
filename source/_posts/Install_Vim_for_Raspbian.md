---
title: Raspbian安装Vim
date: 2018-10-01
catalog: true
tags:
- 树莓派
---
## 安装：
执行如下命令：

``` bash
sudo apt-get remove vim-common
sudo apt-get install vim -y
```
## 配置
用命令`vim ~/.vimrc`打开配置文件，输入以下配置：
```
syn on
set number
```