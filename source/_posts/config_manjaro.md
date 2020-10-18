---
title: 配置Manjaro
date: 2020-05-31
catalog: true
tags:
- Linux
- Manjaro
---

## 切换源

打开配置文件：

```shell
sudo nano /etc/pacman.conf
```

添加如下配置：

```
[archlinuxcn]
SigLevel = Never
# 浙大源
Server = https://mirrors.zju.edu.cn/archlinuxcn/$arch
# 清华源
# Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
```
更新源：

```shell
sudo pacman-mirrors -c China
sudo pacman -Syu
sudo pacman -S archlinuxcn-keyring
# 设置dpi
vim ~/.Xresources
Xft.dpi:166
# 重启
reboot
```

## 软件安装


### fish

#### 安装

```shell
# 安装fish
sudo pacman -S fish
# 安装oh-my-fish
git clone https://github.com/oh-my-fish/oh-my-fish
cd oh-my-fish
bin/install --offline
# 设置fish为默认shell
which fish
chsh -s /usr/bin/fish
# 天气插件
omf install wttr
```
#### 配置

```shell
# 配置主题
fish_config
```

#### 使用

```shell
# 设置快捷键
alias c clear
funcsave c
alias s screenfetch
funcsave c
```

### 美化

```shell
# 窗口渲染器
sudo pacman -S compton
compton
# ui美化
sudo pacman -S lxappearance
lxappearance
# 动态壁纸
sudo pacman -S feh
sudo pacman -S variety
variety
```
### vim

#### 安装

```shell
sudo pacman -S vim
```


### i3

#### 安装

```shell
sudo pacman -S i3
reboot
```

#### 配置

```shell
vim ~/.config/i3/config
bindsym $mod+Return exec alacritty
bindsym $mod+c exec firefox
exec_always variety
exec_always compton
exec_always sleep 1; xmodmap ~/.xmodmap
exec_always kill screenkey
gaps inner 15
#去边框
new_window 1pixel
#刷新配置
Super+Shift+r
```

#### 使用

```shell
# 分屏
Super+return
# 水平分屏模式
Super+v
# 垂直分屏模式
Super+h
#全屏
Super+f
#窗口切换
Super+jkl;
#调整窗口大小
Super+r
```
### st(simple terminal)
```shell
git clone https://git.suckless.org/st
cd st
vim config.mk
X11INC = /usr/include/X11
X11LIB = /usr/include/X11
sudo make clean install
st
vim config.h
```

### alacritty

#### 安装

```shell
# alacritty
sudo pacman -S alacritty
```

#### 配置

```shell
# 设置终端透明度
vim ~/.config/alacritty/alacritty.yml
background_opacity: 0.6
```
### ranger

#### 安装

```shell
sudo pacman -S ranger
```


### 其他

```shell
#pacman 高亮
sudo -E vim /etc/pacman.conf
Color
# dmenu
sudo pacman -S dmenu
Super+d
# 改建
sudo pacman -S xorg
xmodmap -pke > ~/.xmodmap
vim ~/.xmodmap
xev
xmodmap ~/.xmodmap
# 中文输入法
sudo pacman -S fcitx fcitx-im fcitx-configtool
sudo pacman -S fcitx-googlepinyin
vim ~/.xprofile
export GTK_TM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
reboot
fcitx-configtool
# 谷歌浏览器
sudo pacman -S chromium
# office
sudo pacman -S libreoffice
# 视频播放软件
sudo pacman -S vlc 
# 状态栏
sudo pacman -S polybar
# i3-gap3
sudo pacman -S i3-gaps
```


