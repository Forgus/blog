---
title: 安装zsh
catalog: true
date: 2018-02-06
tags:
- Shell
- Linux
---
查看当前系统可用的shell
```
cat /etc/shells
```
查看当前用户使用的shell
```
echo $SHELL
```
切换当前用户使用的shell
```
chsh -s /bin/zsh
```
## 安装zsh
Redhat Linux
```
sudo yum install zsh
```
Ubuntu Linux
```
sudo apt-get install zsh
```

## 安装oh my zsh
确保你已经安装了git。`sudo apt-get install git`

然后执行以下命令即可进行自动安装:

```
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
```
## 配置
```
vim ~/.zshrc
```
部分配置如下
```zsh
alias cls='clear'
alias ll='ls -l'
# 推荐主题：michelebologna、fishy，更多主题可翻看https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
```
## 插件

### autojump
下载autojump源码
```
git clone git://github.com/joelthelion/autojump.git
```
安装
```
cd autojump
./install.py
```

将以下代码加入.zshrc

```
[[ -s /home/pi/.autojump/etc/profile.d/autojump.sh ]] && source /home/pi/.autojump/etc/profile.d/autojump.sh
```

执行`source ~/.zshrc`使配置生效