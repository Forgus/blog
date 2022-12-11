---
title: pcdn部署
date: 2022-12-11
catalog: true
tags:
- pcdn
---
# 网心云
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
registry.cn-hangzhou.aliyuncs.com/forgus/wxedge:2.4.2
# windows
docker run -d -p 18888:18888 --name=wxedge --privileged --tmpfs /run --tmpfs /tmp -v D:\wxedge:/storage:rw -e REC=false registry.cn-hangzhou.aliyuncs.com/forgus/wxedge:2.4.1_x86
```
## 硬盘常用操作
```bash
#将硬盘做成裸盘
pvcreate /dev/sda
vgcreate wxedge /dev/sda
lvcreate -n storage -l 100%Free wxedge
mkfs.ext4 /dev/wxedge/storage
mount /dev/wxedge/storage /media/wxedge_storage
#添加新硬盘
umount /media/wxedge_storage
vgextend wxedge /dev/sdb
lvextend -l +100%FREE /dev/wxedge/storage
resize2fs /dev/wxedge/storage
mount /dev/wxedge/storage /media/wxedge_storage
#将裸盘还原成普通硬盘
umount /media/wxedge_storage
lvremove /dev/wxedge/storage
vgcremote wxedge
pvremote /dev/sda

```
# 甜糖
```bash
docker run -d \
  -v /mnt/pcdn_storage:/mnt/data/ttnode \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /proc:/host/proc:ro \
  --name ttnode \
  --hostname ttnode \
  --privileged \
  --net=host \
  --restart=always \
 registry.cn-hangzhou.aliyuncs.com/tiptime/ttnode:latest
```
