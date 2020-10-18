---
title: 用Redis实现分布式锁
date: 2019-04-01
catalog: true
tags:
- Redis
- 分布式
---

### 用SETNX、GET、GETSET做分布式锁

#### GETSET命令

该命令接收两个参数：key，value。命令效果为，设置key的值为value，同时返回该key存储的旧值。该操作是原子操作。

#### 使用步骤

1. 计算expireTime = 当前时间 + 过期超时时间，执行SETNX key expireTime，如果返回1，则代表获取锁成功；如果返回0，

   则没有获取到锁，执行第2步。

2. GET key 获取oldExpireTime，并与当前时间进行比较，如果小于当前时间，则认为这个锁已经超时，可以允许别的请求重新获取，执行第3步。

3. 计算newExpireTime = 当前时间 + 过期超时时间，执行GETSET key，newExpireTime 会返回currentExpireTime。

4. 判断currentExpireTime 与 oldExpireTime是否相等，如果相等，说明获取锁成功，如果不相等，说明获取锁失败。

5. 获取锁之后，当前线程执行业务处理，处理完毕后，应检查锁对应的过期时间是否大于当前时间，如果是，则执行DEL命令释放锁。

#### 伪代码

```java
public final class RedisLockUtil {
  
	public static boolean lock(String key, int expire) {
        RedisService redisService = SpringUtils.getBean(RedisService.class);

        long expireTime = System.currentTimeMillis() + expire;
        long status = redisService.setnx(key, String.valueOf(expireTime));

        if(status == 1) {
            return true;
        }
        long oldExpireTime = Long.parseLong(redisService.get(key, "0"));
        if(oldExpireTime < System.currentTimeMillis()) {
            //超时
            long newExpireTime = System.currentTimeMillis() + expire;
            long currentExpireTime = Long.parseLong(redisService.getSet(key, String.valueOf(newExpireTime)));
            if(currentExpireTime == oldExpireTime) {
                return true;
            }
        }
        return false;
    }

    public static void unLock(String key) {    
        RedisService redisService = SpringUtils.getBean(RedisService.class);    
        long oldExpireTime = Long.parseLong(redisService.get(key, "0"));   
        if(oldExpireTime > System.currentTimeMillis()) {        
            redisService.del(key);    
        }
   }
}
```

------
[原文链接](https://www.cnblogs.com/seesun2012/p/9214653.html) 	

