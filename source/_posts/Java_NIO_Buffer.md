---
title: Java NIO 缓冲区
catalog: true
date: 2019-03-24
tags:
- NIO
---

>Java NIO 缓冲区和通道配合使用。如你所知，数据可以从通道读进缓冲区，也可以从缓冲区写进通道。
>缓冲区本质上是一块用于数据读写的内存。这块内存被包装成NIO Buffer对象，并提供了一系列的方法使得操作内存变得更加容易。

## Buffer的简单用法

用Buffer读写数据一般分为以下4个步骤：

1. 将数据写入Buffer
2. 调用buffer.flip()方法
3. 从Buffer读取数据
4. 调用buffer.clear()方法或者buffer.compact()方法

当你往一个buffer里写数据的时候，buffer会记录你已经写了多少数据。一旦你需要读取数据，你需要调用flip()方法将buffer从写模式切换为读模式。在读模式下，你可以读取之前写入到buffer的所有数据。

一旦你已经读完了所有数据，你需要情况缓冲区，使之可以再次被写入。有两种方法可以清理buffer：调用clear()方法或者调用compact()方法。clear()方法会清空整个缓冲区。compact()方法只清除已经读过的数据。任何未被读取的数据被移动到缓冲区的起始处，之后数据将从那些未读数据的后面位置开始写入。

以下是一个简单的Buffer使用举例：

```
RandomAccessFile aFile = new RandomAccessFile("data/nio-data.txt", "rw");
FileChannel inChannel = aFile.getChannel();

//create buffer with capacity of 48 bytes
ByteBuffer buf = ByteBuffer.allocate(48);

int bytesRead = inChannel.read(buf); //read into buffer.
while (bytesRead != -1) {

  buf.flip();  //make buffer ready for read

  while(buf.hasRemaining()){
      System.out.print((char) buf.get()); // read 1 byte at a time
  }

  buf.clear(); //make buffer ready for writing
  bytesRead = inChannel.read(buf);
}
aFile.close();
```

## Buffer的Capacity，Position和Limit

buffer本质上是一块可读写的内存区域。这块内存被包装成NIO Buffer对象，并提供了一组方法，用来方便的访问该块内存。

为了理解buffer的工作原理，你需要熟悉下buffer的三个属性。它们是：

- capacity
- position
- limit

`position`和`limit`的含义取决于buffer是处于读模式还是写模式。`capacity`则在读模式和写模式下拥有相同的含义。下文会详细解释，先看下原理图：

![](http://tutorials.jenkov.com/images/java-nio/buffers-modes.png)

### Capacity

作为一块内存区域，buffer有一个固定的大小值，称为"capacity"。你最多可以往buffer里写入capacity个byte、long、char等类型的数据。一旦buffer满了，在你往你写入更多数据前，你需要清空它(通过读取数据或者清除数据)。

### Position

当往buffer里写数据时，position表示当前的位置。初始的position值为0。当一个byte、long等类型数据写到buffer后，position会向前移动到下一个可插入数据的buffer单元。position最大可为capacity - 1。

当从buffer读数据时，也是从某个特定位置读。当你将buffer从写模式切换到读模式，position被重置为0。这样读数据的时候就从position所在位置往前移动指向下一个位置进行数据读取。

### Limit

limit在buffer写模式里的含义是你最多可以写入的数据量。写模式下limit的值等于buffer的capacity。

当切换Buffer到读模式时， limit表示你最多能读到多少数据。因此，当切换Buffer到读模式时，limit会被设置成写模式下的position值。换句话说，你能读到之前写入的所有数据（limit被设置成已写数据的数量，这个值在写模式下就是position）

##      缓冲区类型

Java NIO 有以下缓冲区类型：

- ByteBuffer
- MappedByteBuffer
- CharBuffer
- DoubleBuffer
- FloatBuffer
- IntBuffer
- LongBuffer  
- ShortBuffer

如你所见，这些buffer代表了不同的数据类型。换句话说，它们可以让你在缓冲区里以char，short，int，long，float或者double类型来处理字节。

MappedByteBuffer有一点特殊，会单独介绍。

## 分配缓冲区

为了获得一个Buffer对象你必须先为它分配内存。每一个buffer类都有一个allocate()方法用来完成这项工作。以下是一个用`ByteBuffer`分配内存的例子，缓冲区容量大小48字节：

```java
ByteBuffer buf = ByteBuffer.allocate(48);
```

这是另一个例子，用`CharBuffer`类分配1024个字符大小的缓冲区：

```java
CharBuffer buf = CharBuffer.allocate(1024);
```

## 向缓冲区写数据

有两种方式可以往一个buffer里写数据：

1. 从Channel往buffer里写数据。
2. 通过buffer的`put()`方法直接往buffer里写数据。

以下是一个从Channel往buffer里写数据的例子：

```java
int bytesRead = inChannel.read(buf); //read into buffer.
```

这是另一个例子，通过`put()`方法往buffer里写数据：

```java
buf.put(127)
```

有很多其他版本的`put()`方法，允许你以各种不同的方式往buffer里写数据。比如，从指定位置开始写入，或者以字节数组的方式写入。可以查看JavaDoc获取更多buffer实现的细节。

### flip()

`flip()`方法用于将buffer从写模式切换成读模式。调用flip()方法会将position重设为0，同时将limit设置为先前position所在位置的值。

换句话说，position现在标记的是读取的位置，而limit标记的是有多少字节，字符被写进了buffer——有多少字节，字符可以被读取。

## 从缓冲区读数据

有两种方式可以从缓冲区读取数据：

1. 将数据从buffer读进channel。
2. 用get()方法直接从buffer读取数据。

以下是一个将数据从buffer读进channel的例子：

```java
//read from buffer into channel.
int bytesWritten = inChannel.write(buf);
```

以下则是用get()方法从buffer读取数据的例子：

```java
byte aByte = buf.get();    
```

有很多其他版本的get()方法，允许你以各种不同的方式从buffer读取数据。比如，从指定位置开始读取，或者以字节数组的方式读取。可以查看JavaDoc获取buffer实现的更多信息。

### rewind()

Buffer.rewind()方法将position设置为0，这样你可以重新读取buffer里的所有数据。limit保留未触碰的，这样仍然标记有多少元素(字节，字符等)可以从buffer读取。

### clear()和compact()

一旦你已经完成了从buffer里读取数据的工作，你必须让buffer做好再次写入的准备。这可以通过调用clear()方法或者compact()。

如果调用clear()方法，position被设置为0，limit被设置为容量大小。换句话说，缓冲区被清空了。缓冲区里的数据没有被清除。只是这些标记告诉我们可以从哪里开始往buffer里写数据。

如果缓冲区里还有未读的数据，当你调用clear()方法时，数据会被"遗忘"，这意味着你将不再有任何标记可以告知你哪些数据已被读取，哪些数据还未被读取。

如果缓冲区里仍然有未读的数据，而你想要在之后继续读取，因为目前需要进行一些写操作，那么可以用compact()方法来取代clear()。

compact()方法会复制所有未读的数据放到缓冲区的开始位置。然后它会将position设置在最后未读元素的下一个位置。limit属性依然被设置为容量大小，就像clear()方法一样。现在buffer已经做好了写入的准备，而你不会覆盖未读的数据。

### mark()和reset()

你可以通过调用Buffer.mark()方法标记buffer里的某个位置。然后你在之后可以重置position到标记的位置。举例如下：

```java
buffer.mark();

//call buffer.get() a couple of times, e.g. during parsing.

buffer.reset();  //set position back to mark.  
```

### equals()和compareTo()

比较两个缓冲区可以通过equals()方法和compareTo()方法。

#### equals()

两个buffer相等的条件如下：

1. 类型相同(字节，字符，整形等)。
2. buffer里有等量的剩余数据。
3. 所有剩余的数据相等。

如你所见，equals()方法仅比较buffer的一部分，并不比较里面所有的单个元素。实际上，它只比较buffer里剩余的数据。

#### compareTo()

compareTo()方法比较两个buffer剩余元素，用于例如常规排序。一个buffer比另一个buffer小的条件如下：

1. buffer的首个元素小于另一个buffer。
2. 所有元素相等，但是第一个buffer比另一个buffer更早用完(它拥有更少的元素)。

------
[原文链接](http://tutorials.jenkov.com/java-nio/buffers.html) 	作者：Jakob Jenkov

