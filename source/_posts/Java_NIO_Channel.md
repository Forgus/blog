---
title: Java NIO 通道
date: 2019-03-20
catalog: true
tags:
- NIO
---
Java NIO 通道和流很像，但有一些区别：

- 你既可以往通道里写数据，也可以从通道读数据。流一般只支持读或写。
- 通道可以支持异步读写。
- 通道要么将数据读入缓冲区，要么从缓冲区写数据到通道。

上文提到，你可以从通道将数据读入缓冲区，也可以从缓冲区将数据写入通道。以下是一个示意图：

![](http://tutorials.jenkov.com/images/java-nio/overview-channels-buffers.png)

## 通道实现

以下是Java NIO框架里最重要的几个通道的具体实现：

- FileChannel
- DatagramChannel
- SocketChannel
- ServerSocketChannel

FileChannel 用于文件之间的数据读写。

DatagramChannel 可以在网络上基于UDP进行数据读写。

SocketChannel 可以在网络上基于TCP进行数据读写。

ServerSocketChannel 允许你监听TCP连接请求，就像web服务器那样。对于每一个连接请求会创建一个SocketChannel。

## 通道简单例子

以下是一个使用FileChannel将一些数据读进一个缓冲区的例子：

```java
	RandomAccessFile aFile = new RandomAccessFile("data/nio-data.txt", "rw");
    FileChannel inChannel = aFile.getChannel();

    ByteBuffer buf = ByteBuffer.allocate(48);

    int bytesRead = inChannel.read(buf);
    while (bytesRead != -1) {

      System.out.println("Read " + bytesRead);
      buf.flip();

      while(buf.hasRemaining()){
          System.out.print((char) buf.get());
      }

      buf.clear();
      bytesRead = inChannel.read(buf);
    }
    aFile.close();
```

这里要留意下`buf.flip()`的调用。首先将数据读进缓冲区。然后反转它。接着你就可以从里面往外读数据。在下一节我将会进一步讲解更加详细的细节。                            

------
[原文链接](http://tutorials.jenkov.com/java-nio/channels.html) 	作者：Jakob Jenkov