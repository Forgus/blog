---
title: 无线无屏幕安装树莓派
date: 2019-02-18
catalog: true
tags:
- 树莓派
---

## 准备材料

- 一张micro SD卡，推荐容量8G以上
- 一个读卡器
- 一台mac电脑
- 一个5V 2A的USB Micro接口的电源
- 一个下载好的系统镜像

## 安装步骤

### 制作系统盘

1. 把SD卡插进读卡器，再插进Mac，用自带应用Disk Utility将sd卡格式化为FAT32（FAT或MS-DOS）分区格式。

2. 用Etcher将镜像文件烧进sd卡。

3. 在sd卡根目录(`/Volumes/boot`)创建一个`wpa_supplicant.conf`文件，内容如下：

   ```
   country=CN
   ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
   update_config=1
   
   network={
       ssid="WiFi名称"
       psk="WiFi密码"
       key_mgmt=WPA-PSK
       priority=1
   }
   ```

4. 在sd卡根目录创建一个空的ssh文件，这将允许树莓派启用ssh。

### SSH免密登录

1. 将sd卡插入树莓派，接上电源，等指示灯停止闪烁之后，从路由器管理后台查看树莓派的ip地址。  
2. 通过以下命令将电脑公钥发送给树莓派：  
```
   ssh-copy-id pi@192.168.21.172
```
之后将提示输入pi用户的密码，初始密码为：raspberry

3. 使用`ssh pi@192.168.21.172`免密登录服务器

## 系统配置
### 启用root账号

解锁root账号

`sudo passwd --unlock root`

设置root密码

`sudo passwd root`


### 替换Raspbian软件源

#### 备用原文件

```bash
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
sudo cp /etc/apt/sources.list.d/raspi.list /etc/apt/sources.list.d/raspi.list.bak
```

#### 编辑软件源配置

1. 用命令`sudo vim /etc/apt/sources.list`打开配置文件。
2. 删除原文件内容，用以下内容取代：

```bash
deb http://mirrors.ustc.edu.cn/raspbian/raspbian/ bullseye main contrib non-free rpi
deb-src http://mirrors.ustc.edu.cn/raspbian/raspbian/ bullseye main contrib non-free rpi
```

*注：此处示例为**bullseye**版本，其他版本类推。*

#### 编辑系统源配置

1. 编辑系统更新源文件，参考命令：`sudo vim /etc/apt/sources.list.d/raspi.list`。
2. 用以下内容取代：

```bash
deb http://mirrors.ustc.edu.cn/archive.raspberrypi.org/debian/ bullseye main ui
deb-src http://mirrors.ustc.edu.cn/archive.raspberrypi.org/debian/ bullseye main ui
```

#### 更新

```bash
#更新软件源列表
sudo apt update
#更新软件版本
sudo apt full-upgrade
```

#### 配置npm镜像

```bash
npm config set registry https://registry.npm.taobao.org
```

### 更改分区文件大小

#### 编辑分区文件

```bash
sudo vim /etc/dphys-swapfile
```

#### 修改配置

```
CONF_SWAPSIZE=1024
```

*备注：默认配置为100（M）*

#### 重启服务

```bash
sudo /etc/init.d/dphys-swapfile stop
sudo /etc/init.d/dphys-swapfile start
```

#### 查看内存

```bash
free -m
```

#### 软件安装

```bash
#nodejs
sudo apt install nodejs npm
npm config set registry https://registry.npm.taobao.org
#pip3
sudo apt install python3-venv python3-pip
#docker
sudo apt-get remove docker docker-engine docker.io containerd runc
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo nvim /etc/docker/daemon.json
{
  "registry-mirrors": ["https://docker.mirrors.ustc.edu.cn/"]
}
sudo systemctl restart docker
#docker-compose
sudo pip3 install docker-compose
#portainer
docker volume create portainer_data
docker run -d -p 8000:8000 -p 9000:9000 --name portainer \
    --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    portainer/portainer-ce:2.11.0
#home-assistant docker-compose.yml
version: '3'
services:
  homeassistant:
    container_name: homeassistant
    image: "ghcr.io/home-assistant/home-assistant:stable"
    volumes:
      - /home/pi/.config/home-assistant:/config
      - /etc/localtime:/etc/localtime:ro
    restart: unless-stopped
    privileged: true
    network_mode: host
```