# 错误记录（持续更新）

本章节将记录在实际仿真中所遇到的各种问题，希望通过该章节的持续更新和总结，能够有效帮助您解决在工程中所遇到的各种疑问。注：问题所出现的环境可能不同，所以以下解决方法仅作参考。

## 1. class “...” not found

### 问题描述

完成工程的搭建后，点击运行，出现仿真运行界面，点击开始仿真时，弹窗报错如下所示：

![手册](../img/extend0\classNotFound.PNG)

### 问题解决

根据提示信息，首先查看是否在 CDTFlow.cc中进行 Define_Module(CDTFlow);  状态：已经写好了。

然后发现由于在 .h 和 .cc中的命名空间为 tsn，而工程新建时，命名为tsnSim。CDTFlow.ned部分代码情况如下：

```
package tsnSim.app;

simple CDTFlow
{       
    parameters:
        @class(CDTFlow);
        ...
 }
```

导致错误。

更正为：

```
package tsnSim.app;

simple CDTFlow
{       
    parameters:
        @class(tsn::CDTFlow);
        ...
 }
```

重新进行编译运行，发现该问题得到了解决。

注：为了避免该问题的出现，建议让命名空间和工程名保持一致。

## 2. “...” does not name a type

### 问题描述

在进行编译时，报错：

```
'string' does not name a type; did you mean 'stdin'?	 
```

### 问题解决

定位到报错的代码位置，发现原始代码为：

```c++
class Shaping{
  ...
  string getMACAddress(FlowPacket* packet);
  ...
}
```

string前应加上std::

```c++
class Shaping{
  ...
  std::string getMACAddress(FlowPacket* packet);
  ...
}
```

