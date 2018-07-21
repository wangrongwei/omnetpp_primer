# 错误记录
&#160; &#160; &#160; &#160; 在写这个文档的时候，由于准备资料不是很全，所有选择在此处备注进行无人机网络的设计过程中的各种配置错误，以后再加入到前面的笔记中。

## 7.1 在模块加入移动模块之后，仿真出现nan错误
### 问题描述：
>对于某些

加入移动模块以后，编译过程没有出错，但是当执行仿真程序的时候，出现一些nan错误提示。
需要在仿真配置文件加入：

```c
**.constraintAreaMinX = 0m
**.constraintAreaMinY = 0m
**.constraintAreaMinZ = 0m
**.constraintAreaMaxX = 5000m
**.constraintAreaMaxY = 5000m
**.constraintAreaMaxZ = 0m

```

移动模块配置：

```c
**.UAV[*].mobilityType = "MassMobility"#"RectangleMobility"#"MassMobility"
**.UAV[*].mobility.initFromDisplayString = true
**.UAV[*].mobility.changeInterval = truncnormal(2s, 0.5s)
**.UAV[*].mobility.changeAngleBy = normal(0deg, 30deg)
**.UAV[*].mobility.speed = truncnormal(250mps, 20mps)
**.UAV[*].mobility.updateInterval = 100ms

```

## 7.2 模块内部的消息传输慢
### 问题描述：
>在仿真大量的节点的时候，当节点内部消息只在节点内部模块之间传输的时候，节点内部的消息传输很慢，感觉总是被总是被节点外部的消息打断了，

## 7.3 工程的例如cModule之类的类不能高亮显示？
### 问题描述：
> 原工程是可以高亮显示的，但是由于我在备份这个程序的时候可能方式不对，我采用的是在文件资源管理器的窗口复制原工程文件夹，没有在软件的窗口进行rename，可能是这个原因造成的。

### 解决办法：
在软件的窗口，对工程进行rename就行，编译一次，cMdoule等等关键词就可以高亮了。
