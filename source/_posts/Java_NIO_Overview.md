---
title: Java NIO 概览
date: 2019-03-10
catalog: true
tags:
- NIO
---
>Java NIO 由以下核心组件构成：
>- 通道
>- 缓冲区
>- 选择器
>
>Java NIO 框架包含了很多类和组件，但是Channel，Buffer 和 Selector 是核心。其他的组件，像 Pipe 和 FileLock 只不过是结合了那三个组件作为工具类来使用。所以，在这篇概览里我会着重介绍这三个组件。


## 通道和缓冲区

一般地，NIO框架里所有的IO操作都始于一个通道。一个通道有点像一个流。数据可以从通道读入缓冲区，也可以从缓冲区写入通道。如图：

![](http://tutorials.jenkov.com/images/java-nio/overview-channels-buffers.png)

 通道和缓冲区有很多种。以下是Java NIO框架里Channel的主要实现类：

- FileChannel
- DatagramChannel
- SocketChannel
- ServerSocketChannel

如你所见，这些通道涵盖了UDP + TCP 网络IO和文件IO。

伴随着这些类还有一些有趣的接口，但是简单起见，在这篇概览里我会先忽略他们。他们会在后续相关文章里再做介绍。

以下是Java NIO框架里Buffer接口的主要实现类：

- ByteBuffer
- CharBuffer
- DoubleBuffer
- FloatBuffer
- IntBuffer
- LongBuffer
- ShortBuffer

这些Buffer类涵盖了通过IO可以发送的基础数据类型：byte,short,int,long,float,double和字符。

Java NIO还包含了一个MappedByteBuffer，用于表示内存映射文件。

## 选择器

选择器允许单线程处理多个通道。如果你的应用需要维护很多打开的连接（通道），但是每个连接只有少量的流量，这会使你受益。例如，在一个聊天服务器里。

以下是一个单线程通过一个选择器处理3个通道的示意图 ：

![](http://tutorials.jenkov.com/images/java-nio/overview-selectors.png)

要使用选择器，得向它注册通道。然后调用它的select()方法。这个方法会阻塞直到有某个注册通道有事件就绪。一旦这个方法返回，线程就可以开始处理这些事件。事件包括即将到来的连接，数据已收到等。

------
[原文链接](http://tutorials.jenkov.com/java-nio/overview.html) 	作者：Jakob Jenkov