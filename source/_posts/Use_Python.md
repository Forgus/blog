---
title: Python简明手册
date: 2020-05-14
catalog: true
tags:
- Python
---

## 数据结构
### 字符串
```Python
# 创建字符串
child_name = '小明' #或者 child_name = "小明"
# 字符串和其他类型拼接
child_name + '的年龄是：' + str(age) + '岁。'
```
### 列表
```Python
# 创建空列表
children_name = []
# 追加元素
children_name.append('小刚')
# 插入元素
children_name.insert(i,'小刚')
# 删除元素
del children_name[i] # i等于索引位置
children_name.remove('小刚')
# 弹出元素
child_name = children_name.pop()
child_name = children_name.pop(i)
# 获取倒数第i个元素
last_child = children_name[-i]
# 永久排序
children_name.sort()
# 临时排序
tmp_list = sorted(children_name)
# 创建数字列表
numbers = list(range(1,6))
# 用列表解析创建列表
squares = [value*2 for value in range(1,11)]
# 切片,从指定区间复制元素，前闭后开
children_name[i:j]
children_name[i:]
children_name[:j]
# 复制列表
names = children_name[:]
# 元组,不可变列表
children_name = ('小明','小刚')
```
### 字典
```python
# 定义空字典
children = {}
children = {
  '1':'小刚',
  '2':'小明'
}
# 赋值
children['1','小刚']
# 取值
children['1'] = '小明'
# 删键值对
del children['1']
# 遍历key-value
for key,value in children.items():
  print("\nKey: " + key)
  print("Value: " + value)
# 遍历key
for key in children.keys():
    print("\nKey: " + key)
# 按顺序遍历key
for key in sorted(children.keys()):
    print("\nKey: " + key)
# 遍历值
for value in children.values():
    print("Value: " + value)
# 遍历值并去重
for value in set(children.values()):
    print("Value: " + value)
```

## 函数

```python
# 定义函数
def describe_pet(pet_name,animal_type='dog'):
  """显示宠物的信息"""
  print("\nI have a " + animal_type + ".")
  print("My " + animal_type + "'s name is" + pet_name.title() + ".")
# 调用函数
describe_pet('willie',animal_type='cat')
# 禁止函数修改列表
def print_models(model_list[:]):
  print(str(model_list))
# 传递任意数量实参,*创建元组
def make_pizza(size, *toppings):
  print('\nMaking a ' + str(size) + '-inch pizza with the following toppings:')
  for topping in toppings:
    print('- ' + topping)
make_pizza(16,'mushrooms','extra cheese')
# 传递任意数量关键字实参，**创建字典
def build_profile(first,last,**user_info):
  profile = {}
  profile['first_name'] = first
  profile['last_name'] = last
  for key, value in user_info.items():
    profile[key] = value
  return profile
user_profile = build_profile('albert','einstein',location='princeton',field='physics')
# 导入模块
import module_name as mn
# 导入特定函数
from module_name inport function_name as fn

```

## 面向对象

```python
# 创建类car.py
class Car:
  """类注释写这里"""
  def __init__(self,make,model,year):
    self.make = make
    self.model = model
    self.year = year
    self.odometer_reading = 0
# 创建实例
car = Car('audi','a4',2020)
# 继承
class ElectricCar(Car):
  def __int__(self,make,model,year):
    super()._init_(make,model,year)
# 导入类
from car import ElectricCar
```





