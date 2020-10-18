---
title: 为树莓派安装花生壳客户端
date: 2018-10-15
catalog: true
tags:
- 树莓派
- 内网穿透
- 建站
---
## 准备
1. 先在本地机器从花生壳官网[下载](https://hsk.oray.com/download)树莓派安装包:`phddns_3.0.4_systemd.deb`   
2. 通过如下命令将安装包上传到树莓派：  

```
scp ~/Downloads/install_packages/phddns_3.0.4_systemd.deb pi@192.168.21.172:~/
```

## 安装
通过ssh命令登陆树莓派。 
通过`su`命令切换到root用户之后输入如下命令进行安装：

```
dpkg -i phddns_3.0.4_systemd.deb
```
安装成功后，将显示此树莓派的SN码、默认密码以及远程管理地址。

*注意：花生壳安装步骤都需要在管理员（Root）权限下运行。root账号默认是禁用状态，且没有密码。可以通过`sudo passwd root`设置密码，然后通过`sudo passwd --unlock root`启用root账号*

若执行命令出现以下提示：

```
dpkg: warning: 'ldconfig' not found in PATH or not executable
dpkg: warning: 'start-stop-daemon' not found in PATH or not executable
dpkg: error: 2 expected programs not found in PATH or not executable
Note: root's PATH should usually contain /usr/local/sbin, /usr/sbin and /sbin
```
则在/root/.zshrc里添加以下配置：
```
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
```
## 配置
用生成的SN码和默认密码admin登录花生壳管理后台：http://b.oray.com
登录成功后，开通内网穿透功能。
*注意：若之前已注册过账号，重新安装客户端后SN码会变更，这时候需要用新的SN码登录，然后点击切换账号用旧的账号登录下，新的映射才会生效。*
## 命令
查看可用命令列表：**phddns**  
启动：**phddns start**  
停止：**phddns stop**  
重启：**phddns restart**  
查看状态：**phddns status**  
查看版本：**phddns version**  
重置：**phddns reset** 

## 日志
花生壳日志文件存放路径：**/var/log/phddns** 
## 卸载
输入如下命令进行卸载：

```
dpkg -r phddns
```