# 网心容器魔方部署

挂载移动硬盘

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
```

启动容器
```bash
docker run \
--name=wxedge \
--privileged \
--net=host \
--tmpfs /run \
--tmpfs /tmp \
-v /media/wxedge_storage:/storage:rw \
-e LISTEN_ADDR=":18888" \
-d \
onething1/wxedge:2.2.20
```
# pi-dashboard

```bash
docker run -d --name docker-pi-dashboard -e 'LISTEN=1024' --net=host --restart=always ecat/docker-pi-dashboard
```

电信首选DNS：202.101.172.35

备选DNS：202.101.172.47

网关：36.24.168.1
