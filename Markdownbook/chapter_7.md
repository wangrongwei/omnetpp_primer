# 错误记录 #
&#160; &#160; &#160; &#160;在我刚开始使用<b>OMNeT++</b>进行实验的时候，总是会出现一些稀奇古怪的错误，每一个错误都花了我大量的时间，所以在最后一章中总结出来，也许你正好用上。

## 在模块加入移动模块之后，仿真出现nan错误 ##
### 问题描述： ###
>对于某些工程加入移动模块以后，编译过程没有出错，但是当执行仿真程序的时候，出现一些nan错误提示。
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
**.UAV[*].mobilityType = "MassMobility"
**.UAV[*].mobility.initFromDisplayString = true
**.UAV[*].mobility.changeInterval = truncnormal(2s, 0.5s)
**.UAV[*].mobility.changeAngleBy = normal(0deg, 30deg)
**.UAV[*].mobility.speed = truncnormal(250mps, 20mps)
**.UAV[*].mobility.updateInterval = 100ms

```

## 工程的例如cModule之类的类不能高亮显示？ ##
### 问题描述： ###
> 原工程是可以高亮显示的，但是由于我在备份这个程序的时候可能方式不对，我采用的是在文件资源管理器的窗口复制原工程文件夹，没有在软件的窗口进行rename，可能是这个原因造成的。

### 解决办法： ###
在软件的窗口，对工程进行rename就行，编译一次，cMdoule等等关键词就可以高亮了。
