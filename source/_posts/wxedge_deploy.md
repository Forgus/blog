---
title: 网心容器魔方部署
date: 2022-09-22
catalog: true
tags:
- 网心云
---

## 挂载移动硬盘

```bash
#查看硬盘
lsblk
fdisk -l
#格式化硬盘
mkfs.ext4 /dev/sda
# 挂载硬盘
mkdir -p /media/wxedge_storage
mount /dev/sda /media/wxedge_storage
# 重启自动挂载
nvim /etc/fstab
/dev/sda /media/wxedge_storage ext4 defaults 0 0
# macOS 下格式化移动硬盘
brew install e2fsprogs
diskutil list
diskutil unmountdisk /dev/disk2
sudo $(brew --prefix e2fsprogs)/sbin/mkfs.ext4 /dev/disk2
diskutil eject /dev/disk2
```

## 启动容器
```bash
docker login --username=815498030@qq.com registry.cn-hangzhou.aliyuncs.com
docker run -d --name=wxedge --privileged --net=host --tmpfs /run --tmpfs /tmp \
-v /media/wxedge_storage:/storage:rw \
-e LISTEN_ADDR=":18888" -e NIC=eth0 -e REC=false \
registry.cn-hangzhou.aliyuncs.com/forgus/wxedge:2.4.0
```
