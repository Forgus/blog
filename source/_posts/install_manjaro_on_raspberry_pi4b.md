---
title: 在树莓派4b上安装manjaro
date: 2020-10-01
catalog: true
tags:
- 树莓派
- manjaro
---
## 终端快捷键
ctrl+win+t

## 配置蓝牙

```shell
sudo pacman -S bluez bluez-utils pulseaudio-bluetooth pavucontrol pulseaudio-alsa pulseaudio-bluetooth-a2dp-gdm-fix
systemctl enable bluetooth
systemctl start bluetooth
pulseaudio -k                 
pulseaudio --start
bluetoothctl #连接交互命令
power on #开启控制器电源，默认关闭
scan on # 扫描可配对的蓝牙设备
pair MAC_ADDRESS #配对
connect MAC_ADDRESS #连接
pavucontrol #指定蓝牙音频输出，如果蓝牙没有声音可能是这一步没有设置
```

## 安装中文字体
```shell
sudo pacman -S wqy-zenhei
```