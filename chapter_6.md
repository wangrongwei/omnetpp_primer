# 6 仿真结果分析

&#160; &#160; &#160; &#160;<b>OMNeT++</b>有诸多工具对网络代码中统计的标量和矢量进行数据分析。</br>
&#160; &#160; &#160; &#160;本章以一个<b>AFDX</b>网络的<b>RC</b>和<b>BE</b>消息的仿真结果为前提，依赖<b>OMNeT++</b>自带的工具集对这些结果进行分析，重点主要放在如何设置需要统计的标量和矢量？如何对最后的仿真结果进行操作得到我们想要的散点图、直方图等其他便于分析的数据图形。

## 6.1 仿真结果有哪些

&#160; &#160; &#160; &#160;先备注一下，每次运行完仿真后，将会产生三个文件：
<b>.sca .vci .vec</b>，点击<b>.vec</b>文件将会生成<b>.anf</b>文件，这个<b>.anf</b>文件当我们下一次重新运行仿真程序的时候，会更新，不需要删除后执行仿真程序。

## 6.2 仿真结果的获取

&#160; &#160; &#160; &#160;在平常各种各样的仿真实验中，首先我们需要去获取所需的结果信息。在<b>OMNeT++</b>中有以下几种常用的获取仿真结果的方式，这里同时简单描述一下它们的用法。

- cLongHistogram：记录数据然后实现等距直方图 </br>
定义：cLongHistogram hopCountStats;
我们可以对名称进行设置，如hopCountStats.setName(“hopcountStats”);
设置上限值：hopCountStats.setRangeAutoUpper(“0,10,1.5”);
记录数据：hopCountStats.collect(hopcount);
一些其他的属性如getMin()、getMax()、getMean()以及getStddev()，不做赘述。

- cOutVector：获取输出向量</br>
定义：cOutVector hopCountVector;
同样可以人为地对名称进行设置，比如hopCountVector.setName(“Hopcount”);
记录数据：hopCountVector.record(hopcount);
其中，record表示记录数据。缺少这一语句的话，不会有任何的数据输出。

- recordScalar</br>
输出程序中某个标量的值，直接调用即可。即
recordScalar(“string 输出名称”, 输出变量名);
仿真之后的result文件中会有以“string 输出名称”命名的文件。“输出变量名”为我们要输出查看的变量。recordScalar较为简单，一般在Finish()函数中使用。





## 6.3 仿真结果分析

&#160; &#160; &#160; &#160;每次仿真的结果都会存储在project下面的result文件夹中。
cOutVector: \result\xxx.vec
cLongHistogram: \result\xxx.sca

<div align="center">

<img src="img/chapter6/6-1.png" height="400" width="700" >

<b>图6-1 doc目录</b>
</div>

&#160; &#160; &#160; &#160;如图所示，<b>Project Explorer</b>中选中的文件就是我们的仿真结果。之后双击打开就可以查看里面的内容，这里我选择打开了<b>vec</b>文件。
<div align="center">

<img src="img/chapter6/6-2.png" height="500" width="500" >

<b>图6-2 doc目录</b>
</div>

然后会让我们建立新的分析文件。点击finish即可
<div align="center">

<img src="img/chapter6/6-3.png" height="400" width="650" >

<b>图6-3 doc目录</b>
</div>

点击打开Data栏中vec下属的记录。Tictoc15网络中有6个节点，可以看到仿真对它们全部进行了记录

<div align="center">

<img src="img/chapter6/6-4.png" height="300" width="500" >

<b>图6-4 doc目录</b>
</div>

<div align="center">

<img src="img/chapter6/6-5.png" height="400" width="700" >

<b>图6-5 doc目录</b>
</div>

其实，观察选项卡就可以发现，这里我们就可以查看所有的结果了。由于笔者打开的是vec文件，所以只有输出向量。

<div align="center">

<img src="img/chapter6/6-6.png" height="300" width="600" >

<b>图6-6 doc目录</b>
</div>

双击打开想查看的一行，如下所示：

<div align="center">

<img src="img/chapter6/6-7.png" height="300" width="600" >

<b>图6-7 doc目录</b>
</div>

接下来我们打开sca文件查看直方图：

<div align="center">

<img src="img/chapter6/6-8.png" height="300" width="600" >

<b>图6-8 doc目录</b>
</div>

<div align="center">

<img src="img/chapter6/6-9.png" height="300" width="600" >

<b>图6-9 doc目录</b>
</div>



可以看到，如前文所述，文件名是匹配的

在Histogram栏中选中一条，并打开：

<div align="center">

<img src="img/chapter6/6-10.png" height="300" width="600" >

<b>图6-10 doc目录</b>
</div>

另外，我们也可以直接取出数据，方法如下：


<div align="center">

<img src="img/chapter6/6-11.png" height="350" width="600" >

<b>图5-11 doc目录</b>
</div>
之后可以自己进行数据处理和作图。
