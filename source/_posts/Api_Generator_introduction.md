---
title: Api Generator使用教程
date: 2019-10-28
catalog: true
tags:
- YApi
- 开发工具
---

>前后分离开发模式下，接口文档是否靠谱直接影响开发协作效率，因此文档的时效性和准确性至关重要，但是，文档的维护又是一项琐碎耗时的工作，手工录入不仅麻烦，还存在出错的风险，因此，如果能有自动生成文档的方法，将极大地提升开发效率。

# 前言

一般来讲，接口文档由后端同学维护，而Java是目前主流的后端语言，与之对应的，IDEA是最流行的集成开发环境。基于插件机制，IDEA拥有极强的可扩展性，因此，思路是开发一个IDEA插件，通过插件让手中的IDEA拥有自动生成文档的能力。
	
其实，jetbrains插件仓库里已有几款插件可以帮助生成接口文档，但是没有一款插件令我满意，要么无法解析复杂的类结构，要么就是生成的文档格式差强人意，因此，我在借鉴他们的设计的基础上，开发了这款文档生成插件，我将它取名为《Api Generator》。

# 安装插件

Preferences → Plugins → Marketplace → 搜索“Api Generator” → 安装该插件 → 重启IDE

![img](http://forgus.vicp.io/resources/images/install_api_generator.png)

# 开始使用

## 上传REST接口

选择一个Controller类，将光标定位到方法区（方法名或者方法注释），点击鼠标右键，在弹出的菜单项里选择“Generate Api”。如图所示：

![img](http://forgus.vicp.io/resources/images/upload_yapi.png)

首次使用会弹窗提示输入必要信息：

![img](http://forgus.vicp.io/resources/images/yapi_server_url.png)

首先输入YApi服务器部署地址，接着输入项目token：

![img](http://forgus.vicp.io/resources/images/yapi_token.png)

点击OK，则插件会自动配置，然后自动生成文档并上传到YApi。上传成功后，IDE右下角会弹出提示框：

![img](http://forgus.vicp.io/resources/images/upload_yapi_success.png)

上传效果如图：

![img](http://forgus.vicp.io/resources/images/yapi_demo.png)

### 解析规则

#### 入参解析

![img](http://forgus.vicp.io/resources/images/rest_param_resolve.png)

![img](http://forgus.vicp.io/resources/images/rest_param_resolve_result.png)

#### 响应解析

![img](http://forgus.vicp.io/resources/images/rest_response_resolve.png)

![img](http://forgus.vicp.io/resources/images/rest_response_resolve_result.png)

插件默认保存分类为api_generator，可以在配置项中修改默认分类：

Preferences → Other Settings → Api Generator Setting → YApi Setting → Default save category，如图所示：

![img](http://forgus.vicp.io/resources/images/save_directory.png)

如果勾选了选项“Classify API automatically”，则插件会自动从类注释里抽取分类名，自动创建并保存。效果如下：

![img](http://forgus.vicp.io/resources/images/classify_auto.png)

![img](http://forgus.vicp.io/resources/images/category_resolve.png)

![img](http://forgus.vicp.io/resources/images/category_resolve_result.png)

备注:每个项目只需配置一次，插件会自动持久化配置项，下次打开无需再次配置。

### token获取方法
登录yapi，选择对应项目，找到设置→ token配置，点击复制即可。

![img](http://forgus.vicp.io/resources/images/get_token.png)
## 生成接口文档

如果在接口类中进行文档生成操作，则插件会将文档以markdown的形式输出，默认保存在当前项目的target目录下，如图：

![img](http://forgus.vicp.io/resources/images/api_resolve.png)

生成的接口文档效果图：

![img](http://forgus.vicp.io/resources/images/api_resolve_result.png)
## 生成POJO文档

操作同上，步骤略。

# 插件设置
自定义配置项： Preferences —> Other Settings —> Api Generator Setting  
配置项|含义|详细解释
---|---|---
Exclude Fields|过滤字段（多个字段以","分隔）|该配置项功能类似JSONField，用于过滤不想被解析的字段，多用于排除二方包里的干扰字段
Save Directory|markdown文档保存目录（绝对路径）|用于配置生成的markdown形式的接口文档的保存路径，默认保存在当前项目的target目录
Indent Style|二级字段缩进前缀|生成的markdown文档是类似于json schema的字段表格，涉及类型是对象的字段，展示上做缩进处理，默认缩进前缀是“└”
Overwrite exists docs|是否覆盖同名markdown文档|如果生成的markdown文件已存在，会弹框提示是否覆盖，勾选该选项，则直接覆盖不提示
Extract filename from doc comments|是否从javadoc抽取文件名|生成的markdown文件默认是方法名，勾选该选项，将从注释里抽取文件名
YApi server url|YApi部署服务器地址|内网部署的yapi平台的域名，如：http://yapi.xxx.com
Project token|项目token|接口对应的yapi项目的token
Default save category|默认保存分类|插件生成的yapi文档保存位置，默认api_generator
Classify API automatically|是否自动分类|勾选该选项后，生成文档时插件将从controller类注释里抽取模块名，并在yapi上自动创建对应分类保存接口

# 后记

笔者在开发这款插件之前，也是先用了一段时间别人写的插件，

使用过的插件有：Yapiupload、idea-yapi、EasyYapi、RedsoftYapiUpload等。

这些插件并不完美，或多或少存在一些问题，要么关键功能缺失，要么用户体验较差，以下是关键功能对比：

| 插件              | 智能解析 | 无入侵 | markdown | 智能选中 | json5 | 常用注解 |
| :---------------- | :------- | :----- | :------- | :------- | :---- | :------- |
| Api Generator     | √        | √      | √        | √        | √     | √        |
| EasyYapi          | √        | √      | √        | ✘        | ✘     | ✘        |
| Yapiupload        | ✘        | ✘      | ✘        | ✘        | ✘     | ✘        |
| idea-yapi         | ✘        | ✘      | ✘        | ✘        | ✘     | ✘        |
| RedsoftYapiUpload | ✘        | ✘      | ✘        | ✘        | ✘     | √        |

从上面可以看出，“Api Generator”是集大成者，因为在立项之初就参考了它们的设计，取其精华，去其糟粕。