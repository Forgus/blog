---
title: 二叉树的搜索算法
date: 2020-05-08
catalog: true
tags:
- 算法
---

## 深度优先搜索

深度优先搜索（Depth First Search），一般用递归实现，算法比较巧妙，关键在于寻找遍历的套路。

### 前序遍历

#### 递归法

```java
public void dfs(TreeNode x) {
  if(x == null) {
    return;
  }
  //do something
  dfs(x.left);
  dfs(x.right);
}
```

#### 迭代法

```java
public void dfs(TreeNode x) {
  if(x == null) {
    return;
  }
  Stack<TreeNode> stack = new Stack<>();
  stack.push(x);
  while(!stack.empty()) {
    TreeNode node = stack.pop();
    //do something
    if(node.right != null) {
      stack.push(node.right);
    }
    if(node.left != null) {
      stack.push(node.left);
    }
  }
}
```



### 中序遍历

中序遍历可以按顺序访问二叉搜索树中的节点。

#### 递归法

```java
public void dfs(TreeNode x) {
  if(x == null) {
    return;
  }
  dfs(x.left);
  //do something
  dfs(x.right);
}
```

#### 迭代法

```java
public void dfs(TreeNode x) {
  if(x == null) {
    return;
  }
  Stack<TreeNode> stack = new Stack<>();
  TreeNode curr = x;
  while(curr != null || !stack.empty()) {
    while(curr != null) {
      stack.push(curr);
      curr = curr.left;
    }
    curr = stack.pop();
    //do something
    curr = curr.right;
  }
}
```



### 后序遍历

#### 递归法

```java
public void dfs(TreeNode x) {
  if(x == null) {
    return;
  }
  dfs(x.left);
  dfs(x.right);
  //do something
}
```

#### 迭代法

```java
public void dfs(TreeNode x) {
  if(x == null) {
    return;
  }
  Stack<TreeNode> stack = new Stack<>();
  Stack<TreeNode> result = new Stack<>();
  stack.push(x);
  while(!stack.empty()) {
    TreeNode node = stack.pop();
    result.push(node);
    if(node.left != null) {
      stack.push(node.left);
    }
    if(node.right != null) {
      stack.push(node.right);
    }
  }
  while(!result.empty()) {
    TreeNode node = result.pop();
    //do something
  }
}
```



## 广度优先搜索

广度优先搜索（Breadth First Search），即层序遍历，一般用队列加两层循环实现，外层循环遍历树的层次，内循环遍历每一层的节点。

### 自顶向下层序遍历

```java
public void bfs(TreeNode x) {
  if(x == null) {
    return;
  }
  Queue<TreeNode> queue = new LinkedList<>();
  queue.add(x);
  while(!queue.isEmpty()) {
    int count = queue.size();
    while(count > 0) {
      TreeNode node = queue.poll();
    	//do something
      if(node.left != null) queue.add(node.left);
      if(node.right != null) queue.add(node.right);
      count --;
    }
  }
}
```

### 自底向上层序遍历

可以用自顶向下遍历法的套路，在具体处理上反转结果。