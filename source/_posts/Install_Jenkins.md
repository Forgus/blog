---
title: Jenkins安装教程
date: 2018-03-31
catalog: true
tags:
- Jenkins
- 敏捷
---

以下介绍在Debian或者Ubuntu系统上安装Jenkins

## 添加key

```
wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key \
| sudo apt-key add -
```
```
sudo echo "deb http://pkg.jenkins-ci.org/debian binary/" > \
/etc/apt/sources.list.d/jenkins.list
```

## 更新Debian的包仓库

`sudo aptitude update`

## 通过aptitude安装Jenkins

`sudo aptitude install -y jenkins`

## 启动Jenkins

`sudo /etc/init.d/jenkins start`

## 停止Jenkins

`sudo /etc/init.d/jenkins stop`