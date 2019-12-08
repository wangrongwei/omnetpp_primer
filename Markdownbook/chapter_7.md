# 错误记录 #

<<<<<<< HEAD
在我刚开始使用**OMNeT++**进行实验的时候，总是会出现一些稀奇古怪的错误，每一个错误都花了我大量的时间，所以在最后一章中总结出来，也许你正好用上。

## 在模块加入移动模块之后，仿真出现nan错误 ##

### 问题描述 ###
=======
在我刚开始使用<b>OMNeT++</b>进行实验的时候，总是会出现一些稀奇古怪的错误，每一个错误都花了我大量的时间，所以在最后一章中总结出来，也许你正好用上。

## 在模块加入移动模块之后，仿真出现nan错误 ##

### 问题描述： ###
>>>>>>> upstream/master

>对于某些工程加入移动模块以后，编译过程没有出错，但是当执行仿真程序的时候，出现一些nan错误提示。
需要在仿真配置文件加入：

<<<<<<< HEAD
```C++
=======
```c
>>>>>>> upstream/master
**.constraintAreaMinX = 0m
**.constraintAreaMinY = 0m
**.constraintAreaMinZ = 0m
**.constraintAreaMaxX = 5000m
**.constraintAreaMaxY = 5000m
**.constraintAreaMaxZ = 0m
<<<<<<< HEAD
=======

>>>>>>> upstream/master
```

移动模块配置：

<<<<<<< HEAD
```C++
=======
```c
>>>>>>> upstream/master
**.UAV[*].mobilityType = "MassMobility"
**.UAV[*].mobility.initFromDisplayString = true
**.UAV[*].mobility.changeInterval = truncnormal(2s, 0.5s)
**.UAV[*].mobility.changeAngleBy = normal(0deg, 30deg)
**.UAV[*].mobility.speed = truncnormal(250mps, 20mps)
**.UAV[*].mobility.updateInterval = 100ms
<<<<<<< HEAD
```

## 高亮显示cModule等类 ##

### 问题描述 ###

原工程是可以高亮显示的，但是由于我在备份这个程序的时候可能方式不对，我采用的是在文件资源管理器的窗口复制原工程文件夹，没有在软件的窗口进行rename，可能是这个原因造成的。
=======

```

## 工程的例如cModule之类的类不能高亮显示？ ##

### 问题描述 ###

> 原工程是可以高亮显示的，但是由于我在备份这个程序的时候可能方式不对，我采用的是在文件资源管理器的窗口复制原工程文件夹，没有在软件的窗口进行rename，可能是这个原因造成的。
>>>>>>> upstream/master

### 解决办法 ###

在软件的窗口，对工程进行rename就行，编译一次，cMdoule等等关键词就可以高亮了。

<<<<<<< HEAD
## 调用INET类 ##

### 问题描述 ###

在对节点的坐标进行实时的显示的过程中，编写如下的函数：

```C++
=======
## 在建立工程时，需要实时显示节点的移动坐标时，编译出错##

### 问题描述 ###

>在对节点的坐标进行实时的显示的过程中，编写如下的函数：

```c

>>>>>>> upstream/master
void node::initialize()
{
    cModule *host = getContainingNode(this);
    IMobility *mobility = check_and_cast<IMobility *>(host->getSubmodule("mobility"));
    Coord selfPosition = mobility->getCurrentPosition();
}
<<<<<<< HEAD
```

同时以 "inet/mobility/contract/IMobility.h"的形式引用头文件，但是在编译的过程中，会报出如下的错误：

```C++
../out/clang-release/src/node.o:(.text[_ZN7omnetpp14check_and_castIPN4inet9IMobilityENS_7cModuleEEET_PT0_]+0x18): undefined reference to `__imp__ZTIN4inet9IMobilityE'
../out/clang-release/src/node.o:(.rdata[_ZTIPN4inet9IMobilityE]+0x18): undefined reference to `typeinfo for inet::IMobility'
```

### 解决办法 ###

方法一：
在inet中将IMobility.h中第一行将 "INET_API" 删除后，重新对inet进行编译，然后在对所建立的工程进行编译，编译既可以通过。

=======

```

同时以 "inet/mobility/contract/IMobility.h"的形式引用头文件，但是在编译的过程中，会报出如下的错误：
../out/clang-release/src/node.o:(.text[_ZN7omnetpp14check_and_castIPN4inet9IMobilityENS_7cModuleEEET_PT0_]+0x18): undefined reference to `__imp__ZTIN4inet9IMobilityE'
../out/clang-release/src/node.o:(.rdata[_ZTIPN4inet9IMobilityE]+0x18): undefined reference to `typeinfo for inet::IMobility'

### 解决办法： ###

方法一：
在inet中将IMobility.h中第一行将 "INet_API" 删除后，重新对inet进行编译，然后在对所建立的工程进行编译，编译既可以通过。
>>>>>>> upstream/master
方法二：
打开当初安装OMNET++ 的文件夹，找到configure.user的文本，打开后，找到CC==gcc，将前面的“#”注释符号去掉；然后打开mingwenv.cmd
，按顺序先后执行"./configure" and "make"命令，编译完成后，重新对工程进行编译即可。

<<<<<<< HEAD
## 节点移动轨迹 ##

### 问题描述 ###

当节点进行移动的时候，想观察节点的移动轨迹，那么如何进行操作？

### 解决办法 ###

完成这个问题，需要进行两步操作，分别在.ned .ini文件中：

1）在整个网络拓扑ned文件中，需要添加必要的路径和模块：

```C++
=======

## 在进行移动模型的构建时，如何可以看到移动轨迹##

### 问题描述 ###
当节点进行移动的时候，想观察节点的移动轨迹，那么如何进行操作？

### 解决办法： ###
完成这个问题，需要进行两步操作，分别在.ned .ini文件中：
1）在整个网络拓扑ned文件中，需要添加必要的路径和模块：
```c
>>>>>>> upstream/master
/*调用inet中的库函数*/
import inet.visualizer.integrated.IntegratedCanvasVisualizer;
import inet.visualizer.contract.IIntegratedVisualizer;

<<<<<<< HEAD
/* 添加visualizer模块 */
=======
//添加visualizer模块
>>>>>>> upstream/master
visualizer: <default("IntegratedCanvasVisualizer")> like IIntegratedVisualizer if hasVisualizer() {
    parameters:
        @display("p=50103.34,27751.85");
}
```
<<<<<<< HEAD

2）然后在.ini文件中进行配置

```C++
=======
2）然后在.ini文件中进行配置
```c

>>>>>>> upstream/master
*.visualizertype = "IntegratedOsgVisualizer"
*.hasVisualizer = true
*.visualizer.mobilityVisualizer.moduleFilter = "**"
*.visualizer.mobilityVisualizer.displayMovementTrails = true
*.visualizer.mobilityVisualizer.movementTrailLineColor = "dark"
*.visualizer.mobilityVisualizer.movementTrailLineStyle = "solid"
*.visualizer.mobilityVisualizer.movementTrailLineWidth =  2
*.visualizer.mobilityVisualizer.trailLength = 100000
*.visualizer.mobilityVisualizer.displayOrientations = true
*.visualizer.mobilityVisualizer.displayVelocities = true
<<<<<<< HEAD
```

通过以上两步就可以实现完成轨迹的显示
## 在新构建模块,函数调用##

### 问题描述 ###
当构建新的Ned模块时，如何调用inet中的指定模块？

### 解决办法###
完成这个问题，需要完成下面的操作：
1）在调用inet模块时，首先利用import函数从inet中导入指定模块即可，而对应的.cc文件和.h文件并不需要进行调用，直接利用既可以完成；


## 文件引用##

### 问题描述 ###
在新建.h和.cc文件时，如果引用调用同一个文件的其他.cc文件，该如何解决该问题

### 解决办法###
完成这个问题，需要完成下面的操作：
1）工程文件的perpetual的设置中，将文件的路径添加进去即可实现相邻文件的调用；


## .msg文件调用外部函数#

### 问题描述 ###
当在.msg文件中调用其他消息时，
```C++
import inet.common.INETDefs;
```
将会提示下面的错误：
```C++
Error: syntax error, unexpected NAME, expecting $end
```
### 解决办法###
完成这个问题，需要完成下面的操作：
1）工程文件的properties中，选择oment++/Makemake/src floder /options/ Custom,
2）添加下面的程序：
```C++
MSGC:=$(MSGC) --msg6
```

## 本章小结 ##

本章主要对OMNeT++中常见错误进行配置，后续尝试将解决办法进行补充。
=======

```

通过以上两步就可以实现完成轨迹的显示
>>>>>>> upstream/master
