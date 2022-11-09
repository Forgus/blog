---
title: Helm简明手册
date: 2022-11-09
catalog: true
tags:
- k8s
- helm
- cncf
---

## 核心概念
### Chart
适用于k8s环境下的软件安装包，是一系列k8s资源的集合
### Repository
用于存放chart的仓库，分为本地仓库和远程仓库，类似git仓库。
### Hub
用于存放repository的仓库中心，分为官方hub（https://artifacthub.io/) 和自建hub
### Release
基于某个chart的运行实例，即运行于k8s上的软件服务，一个chart可以对应多个release，chart和release的关系类似容器镜像和容器的关系。
## 常用操作
```bash
# 列举仓库
helm repo ls
# 添加仓库
# 这个动作有点类似于"git remote add"命令，都是在本地添加远程仓库的引用，不同的是，git需要额外执行"git fetch"命令拉取远程仓库的内容，而helm则是在执行完添加命令后直接同步远程仓库内容
helm repo add [NAME] [URL]
# 更新仓库，同步远程仓库最新内容
helm repo update
# 移除仓库
helm repo rm [REPO1 [REPO2 ...]]
# 创建自定义chart
helm create NAME
# 验证chart
helm lint PATH
# 打包chart
helm package [CHART_PATH] [...]
# 安装chart
#There are five different ways you can express the chart you want to install:
#
#1. By chart reference: helm install mymaria example/mariadb
#2. By path to a packaged chart: helm install mynginx ./nginx-1.2.3.tgz
#3. By path to an unpacked chart directory: helm install mynginx ./nginx
#4. By absolute URL: helm install mynginx https://example.com/charts/nginx-1.2.3.tgz
#5. By chart reference and repo url: helm install --repo https://example.com/charts/ mynginx nginx
helm install [NAME] [CHART]
# 查看release
helm ls
# 卸载release
helm uninstall RELEASE_NAME [...]
```



