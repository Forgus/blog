---
title: 使用Neovim打造Python IDE
date: 2020-06-06
catalog: true
tags:
- Neovim
---

## Windows

### windows terminal

#### 安装

#### 配置

### PowerShell

#### 配置

### chocolatey

#### 安装

1.以管理员身份启动powershell。

2.执行命令`Get-ExecutionPolicy`，如结果为“Restricted”，

则执行`Set-ExecutionPolicy Bypass -Scope Process`。

3.接着执行如下命令：

```shell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```

### vim-plug

powershell里执行如下命令进行安装：

```shell
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force
```

### neovim

#### 安装

执行`choco install neovim`进行安装。

#### 配置

切换工作目录：

`cd ~\AppData\Local`

下载配置文件：

`git clone git@github.com:Forgus/nvim.git`

切换到开发分支：

`cd nvim`

`git checkout dev-qwerty`

安装插件：

`nvim init.vim`

`:PlugInstall`

## Mac OS