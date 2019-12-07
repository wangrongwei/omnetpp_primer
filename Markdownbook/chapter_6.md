# OMNeT++数据统计与仿真分析 #

**OMNeT++**提供标量和矢量的形式对数据进行统计。

本章以一个**AFDX**网络的**RC**和**BE**消息的仿真结果为前提，依赖**OMNeT++**自带的工具集对这些结果进行分析，重点：

- [1] 如何设置需要统计的标量和矢量？
- [2] 如何对最后的仿真结果进行操作得到我们想要的散点图、直方图等其他便于分析的数据图形？

## 统计结果文件 ##

先备注一下，每次运行完仿真后，将会产生三个文件：

- sca
  标量统计结果，仅为一个数据，例如平均值或最大值；
- vci
  待补充
- vec
  矢量统计结果，一组数据，且每一个数据存在一个时间戳，因此可以看做**(t,data)**的形式；

通过点击**vec**文件，**OMNeT++**将提醒保存**anf**文件，新建的**anf**文件中以包括了**sca**和**vec**两个文件，此时可通过**anf**文件同时查看到标量数据和矢量数据。此外，**anf**文件在仿真程序运行过程中将根据主动更新，因此下一次运行相同的配置时，**anf**中数据自动更新。

## 仿真结果统计 ##

### 标量 ###

在**OMNeT++**中，操作标量统计接口主要包括两个步骤：在模块的**ned**文件中添加需统计标量，在模块**cc**文件中对标量进行注册。**ned**文件添加如下：

```C++
    @signal[TaskThroughput_Network](type=long);
    @statistic[TaskThroughput_Network](title="Task throughput of network";unit=long;record=mean,max;interpolationmode=none);
```

在模块的**initialize**函数中，利用**registerSignal**函数对信号进行注册。代码示例如下：

```C++
    ThroughputSignal = registerSignal("TaskThroughput_Network");
```

完成以上操作，在需要统计该变量的地方可使用emit函数进行记录。

### 矢量 ###

与标量的操作方式相似，都需要在ned文件中添加相应变量和注册。唯一不同，主要在ned文件中**record**的值存在差异，详细如下：

```C++
    @signal[endToEndDelay_Packet](type="simtime_t");
    @statistic[endToEndDelay_Packet](title="end-to-end delay of arrived packets";unit=s;record=vector,mean,max;interpolationmode=none);
```

```C++
    end2endSignal = registerSignal("endToEndDelay_Packet");
```

### 直方图 ###

在平常各种各样的仿真实验中，首先我们需要去获取所需的结果信息。在**OMNeT++**中有以下几种常用的获取仿真结果的方式，这里同时简单描述一下它们的用法。

- cLongHistogram：记录数据然后实现等距直方图

```C++
cLongHistogram hopCountStats;
hopCountStats.setName("hopcountStats"); /* 设置名称 */
hopCountStats.setRangeAutoUpper("0,10,1.5"); /* 设置上限值 */
hopCountStats.collect(hopcount); /* 记录数据 */
```

以上为使用cLongHistogram类的常用成员函数，此外，getMin()、getMax()、getMean()以及getStddev()等其他成员函数可通过查看头文件了解。

- cOutVector：获取输出向量

```C++
cOutVector hopCountVector;
hopCountVector.setName("Hopcount"); /* 设置名称 */
hopCountVector.record(hopcount); /* 记录数据 */
```

- recordScalar

```C++
recordScalar(“string 输出名称”, 输出变量名)
```

输出程序中某个标量的值，直接调用即可。仿真之后的result文件中会有以“string 输出名称”命名的文件。“输出变量名”为我们要输出查看的变量。一般在Finish()函数中调用recordScalar函数。

## 仿真结果分析 ##

仿真的结果存储在project下result文件夹中。例如：

```C++
cOutVector: \result\**.vec
cLongHistogram: \result\**.sca
```

![doc目录](../img/chapter6/6-1.png)

如图所示，**Project Explorer**中选中的文件就是我们的仿真结果。之后双击打开就可以查看里面的内容，这里我选择打开了**vec**文件。

![doc目录](../img/chapter6/6-2.png)

然后会让我们建立新的分析文件。点击finish即可

![doc目录](../img/chapter6/6-3.png)

点击打开Data栏中vec下属的记录。Tictoc15网络中有6个节点，可以看到仿真对它们全部进行了记录

![doc目录](../img/chapter6/6-4.png)

![doc目录](../img/chapter6/6-5.png)

其实，观察选项卡就可以发现，这里我们就可以查看所有的结果了。由于笔者打开的是vec文件，所以只有输出向量。

![doc目录](../img/chapter6/6-6.png)

双击打开想查看的一行，如下所示：

![doc目录](../img/chapter6/6-7.png)

接下来我们打开sca文件查看直方图：

![doc目录](../img/chapter6/6-8.png)

![doc目录](../img/chapter6/6-9.png)


可以看到，如前文所述，文件名是匹配的

在Histogram栏中选中一条，并打开：

![doc目录](../img/chapter6/6-10.png)

另外，我们也可以直接取出数据，方法如下：

![doc目录](../img/chapter6/6-11.png)

之后可以自己进行数据处理和作图。

## 事件日志文件的使用 ##

事件日志文件（EventLog）所记录的内容包括用户仿真过程中各个模块发送的消息细节以及提示发送和消息接收的细节。在Tkenv界面进行仿真前，点击“Enable recording on/off”按钮，即可对仿真过程中的事件进行记录。

![avatar](../img/chapter6/6-12.png)

默认情况下，相应工程的result文件夹中会出现一个后缀为“.elog”的文件，即我们本次仿真记录所得的时间日志文件。这里需要特别注意的是，记录的数据数量会直接决定elog文件的大小，不仅会影响仿真的速度，还可能在仿真结束后，omnetpp无法打开过大的日志文件，导致闪退，严重时甚至出现过黑屏等情况。因此建议在使用时不要记录过长的时间或过多无用的内容。

### 序列图 ###

打开elog文件后，里面的内容会以序列图的形式来展现，如下图所示：

![常用符号](../img/chapter6/6-15.png)

序列图可分为三个部分：上沿、主区域和下沿。其中，上下沿显示的是仿真时间轴。主区域则是显示各个模块名称和周线、时间与消息的发送。下面是常用符号的图例：

![常用符号](../img/chapter6/map_1.png)

### 事件日志表 ###

事件日志表的事件记录分为三栏，依次是事件编号、仿真时间和事件的具体细节。善用过滤器来减少无用内容的显示对提高工作效率很有帮助，行过滤器可以过滤特定类型的显示行。同时，事件日志表支持导航历史纪录，每个用户停留超过三秒的位置都会被记录下来作为临时数据。

![avatar](../img/chapter6/6-13.png)

此外，一定不要让elog文件的体积过大，因为这很可能导致处理过程中的闪退。然后，过滤器是我最常用的功能。除了行过滤器外，序列图和事件日志表都支持同一个Filter。

![avatar](../img/chapter6/6-14.png)

如图所示，一般包括：

- 范围过滤器：过滤掉elog中的起始和结束事件，有助于减少计算时间；

- 模块过滤器：用户可以指定特定的模块，非指定模块的事件会被全部过滤。当我们倾向于研究一个或几个特定模块时，这非常有用；

- 消息过滤器：最复杂的一个过滤器。需要根据消息的C++名称、消息名称、消息id以及匹配表达式等进行选择；

- 因果过滤器：通过指定特定的事件并对其愿意和结果进行过滤；

同时，**OMNeT++**对filter结果的计算和显示会耗费大量的时间，一定要指定适当的范围。具体根据什么来设置范围，就要以各位各自的使用情况作为标准了。

## 小结 ##

**OMNeT++**提供的普通的标量数据形式统计接口和带时间戳的矢量形式统计方式，两种方式已经基本满足需求。若需要复杂的数据对比图，可在
