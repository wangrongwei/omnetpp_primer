# 错误记录 #

在我刚开始使用<b>OMNeT++</b>进行实验的时候，总是会出现一些稀奇古怪的错误，每一个错误都花了我大量的时间，所以在最后一章中总结出来，也许你正好用上。

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

### 问题描述 ###

> 原工程是可以高亮显示的，但是由于我在备份这个程序的时候可能方式不对，我采用的是在文件资源管理器的窗口复制原工程文件夹，没有在软件的窗口进行rename，可能是这个原因造成的。

### 解决办法 ###

在软件的窗口，对工程进行rename就行，编译一次，cMdoule等等关键词就可以高亮了。

## 在建立工程时，需要实时显示节点的移动坐标时，编译出错##

### 问题描述 ###

>在对节点的坐标进行实时的显示的过程中，编写如下的函数：

```c

void node::initialize()
{
    cModule *host = getContainingNode(this);
    IMobility *mobility = check_and_cast<IMobility *>(host->getSubmodule("mobility"));
    Coord selfPosition = mobility->getCurrentPosition();
}

```

同时以 "inet/mobility/contract/IMobility.h"的形式引用头文件，但是在编译的过程中，会报出如下的错误：
../out/clang-release/src/node.o:(.text[_ZN7omnetpp14check_and_castIPN4inet9IMobilityENS_7cModuleEEET_PT0_]+0x18): undefined reference to `__imp__ZTIN4inet9IMobilityE'
../out/clang-release/src/node.o:(.rdata[_ZTIPN4inet9IMobilityE]+0x18): undefined reference to `typeinfo for inet::IMobility'

### 解决办法： ###

方法一：
在inet中将IMobility.h中第一行将 "INet_API" 删除后，重新对inet进行编译，然后在对所建立的工程进行编译，编译既可以通过。
方法二：
打开当初安装OMNET++ 的文件夹，找到configure.user的文本，打开后，找到CC==gcc，将前面的“#”注释符号去掉；然后打开mingwenv.cmd
，按顺序先后执行"./configure" and "make"命令，编译完成后，重新对工程进行编译即可。


## 在进行移动模型的构建时，如何可以看到移动轨迹##

### 问题描述 ###
当节点进行移动的时候，想观察节点的移动轨迹，那么如何进行操作？

### 解决办法： ###
完成这个问题，需要进行两步操作，分别在.ned .ini文件中：
1）在整个网络拓扑ned文件中，需要添加必要的路径和模块：
```c
/*调用inet中的库函数*/
import inet.visualizer.integrated.IntegratedCanvasVisualizer;
import inet.visualizer.contract.IIntegratedVisualizer;

//添加visualizer模块
visualizer: <default("IntegratedCanvasVisualizer")> like IIntegratedVisualizer if hasVisualizer() {
    parameters:
        @display("p=50103.34,27751.85");
}
```
2）然后在.ini文件中进行配置
```c

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

```

通过以上两步就可以实现完成轨迹的显示
