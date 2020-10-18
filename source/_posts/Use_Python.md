---
title: Python简明手册
date: 2020-05-14
catalog: true
tags:
- Python
---

## 数据结构

```python
# 字符串
child_name = '小明'
# 列表
children_name = []
children_name.append('小刚')
# 字典
children = {}
children['1','小刚']
children['1'] = '小明'
del children['1']
children = {
  '1':'小刚',
  '2':'小明'
}
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
```

## 面向对象

```python
# 创建类
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
from car import Car,ElectricCar
# 导入模块
import car
# 导入模块中所有类
from car import *
```





