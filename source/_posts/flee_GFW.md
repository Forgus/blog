---
；……………………………………………………title: 各类软件镜像源配置
catalog: true
date: 2018-11-02
tags:
- mirrors
- Linux
---
## Homebrew 镜像源进行加速

### 替换 / 还原 brew.git 仓库地址
```shell
# 替换成阿里巴巴的 brew.git 仓库地址: 
cd "$(brew --repo)" 
git remote set-url origin https://mirrors.aliyun.com/homebrew/brew.git** 
# 还原为官方提供的 brew.git 仓库地址 :
cd "$(brew --repo)" 
git remote set-url origin https://github.com/Homebrew/brew.git
```
### 替换 / 还原 homebrew-core.git 仓库地址
```shell
# 替换成阿里巴巴的 homebrew-core.git 仓库地址: 
cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core" 
git remote set-url origin https://mirrors.aliyun.com/homebrew/homebrew-core.git 
# 还原为官方提供的 homebrew-core.git 仓库地址 
cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core" 
git remote set-url origin https://github.com/Homebrew/homebrew-core.git
```

### 替换 / 还原 homebrew-bottles 访问地址
```shell
# ZSH 替换 homebrew-bottles 访问地址: 
echo 'export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.aliyun.com/homebrew/homebrew-bottles' >> ~/.zshrc 
source ~/.zshrc 
# 还原为官方提供的 homebrew-bottles 访问地址:
vim ~/.zshrc 
# 然后，删除 HOMEBREW_BOTTLE_DOMAIN 这一行配置 
source ~/.bash_profile
```

## Gradle镜像源
打开全局配置文件
```shell
nvim ~/.gradle/init.gradle
```
写入如下配置：
```
allprojects{
    repositories {
        def ALIYUN_REPOSITORY_URL = 'http://maven.aliyun.com/nexus/content/groups/public'
        def ALIYUN_JCENTER_URL = 'http://maven.aliyun.com/nexus/content/repositories/jcenter'
        all { ArtifactRepository repo ->
            if(repo instanceof MavenArtifactRepository){
                def url = repo.url.toString()
                if (url.startsWith('https://repo1.maven.org/maven2')) {
                    project.logger.lifecycle "Repository ${repo.url} replaced by $ALIYUN_REPOSITORY_URL."
                    remove repo
                }
                if (url.startsWith('https://jcenter.bintray.com/')) {
                    project.logger.lifecycle "Repository ${repo.url} replaced by $ALIYUN_JCENTER_URL."
                    remove repo
                }
            }
        }
        maven {
            url ALIYUN_REPOSITORY_URL
            url ALIYUN_JCENTER_URL
        }
    }
}
```


## NodeJS 修改镜像源

```shell
# 设置 淘宝镜像源
npm config set registry https://registry.npm.taobao.org
# 查看 使用的 镜像源
npm config get registry
```