---
title: Jetbrains产品激活教程
date: 2020-02-17
catalog: false
tags:
- Jetbrains
- 开发工具
---

### 获取专属激活码

https://zhile.io/custom/license
*注意：需要Github授权登录，Github账号注册需要超过7天，将使用你的Github用户名作为License name*

### 下载激活工具

地址：https://xclient.info/s/intellij-idea.html
找到激活工具进行下载，大小不超过2M

### 配置IntelliJ IDEA

1.将jetbrains-agent.jar文件复制到 /Applications/IntelliJ IDEA.app/Contents/bin/ 目录中；
2.用编辑器打开 /Applications/IntelliJ IDEA.app/Contents/bin/idea.vmoptions 文件，添加 -javaagent:jetbrains-agent.jar 到最后一行；

### 配置DataGrip

1.将jetbrains-agent.jar文件复制到 /Applications/DataGrip.app/Contents/bin/ 目录中；
2.用编辑器打开 /Applications/DataGrip.app/Contents/bin/datagrip.vmoptions 文件，添加 -javaagent:jetbrains-agent.jar 到最后一行；