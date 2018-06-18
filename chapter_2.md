# 2.1 OMNeT++下载
&#160; &#160; &#160; &#160; OMNeT++可以直接从网上下载，网站地址是：
[https://www.omnetpp.org](),
但是国内直接从该网站下载，下载较慢，同时时常在安装下载过程中出现下载中断的情况，导致前功尽弃，下载成功较难。读者可直接到作者的GitHub:  下载版本OMNeT++5.2。

# 2.2 OMNeT++安装

## 2.2.1 安装准备
&#160; &#160; &#160; &#160; 由于OMNeT++支持多个操作系统环境的安装，包括MacOS、linux和Windows，在这里只描述Windows环境下的安装。
软件的安装说明肯定在软件的安装文件有说明，我们没有必要每次安装一个软件的时候都去百度一下软件安装的过程，作者的观点是对于一些破解较难，安装复杂的软件安装可以写写blog，记录记录。我们可以在OMNeT++的安装包下发现readme文件和doc目录下的installguide，去看看吧，总会发现我们的安装执行步骤，掌握这种办法，断网了也能安装、无论过多久还能记得安装过程。好了，废话不多说了。
下面是几个你在安装过程中可能会用到的命令：

- [1] **./configure**

&#160; &#160; &#160; &#160; 在PC机上第一次安装的时候，需要根据配置文件配置一下具体我们需要的软件的功能：静态编译程序、依赖库路径、其他什么文件路径

- [2] **make**

&#160; &#160; &#160; &#160; 在PC机上第一次安装的时候，需要根据配置文件配置一下具体我们需要的软件的功能：静态编译程序、依赖库路径、其他什么文件路径


- [3] **make clean**  

&#160; &#160; &#160; &#160; 清除前面安装过程中产生的中间二进制文件，这个命令主要用于重新安装软件的过程中，如果遇到make出错的问题，可以选择这个命令清除到二进制文件，然后在使用make命令编译安装（因为有些时候下载的安装包不是原始文件）。

## 2.2.2 图文并茂
&#160; &#160; &#160; &#160;  其实这一部分没有说明必要，姑且就当作者无聊，还是想写写，作者的原则就是坚持把故事讲得透彻明白，有些时候，在阅读别人博客的时候，老是会有很多疑问，其实博主以为读者懂，但读者的专业背景不一样，导致可能很简单的问题，还得下边留个言......好了，我们还是回到本节的话题上。</br>
&#160; &#160; &#160; &#160; 以下三张图：

<div align="center">

<img src="img/chapter2/file1.png" height="130" width="200" >
<img src="img/chapter2/file2.png" height="130" width="200" >
<img src="img/chapter2/doc.png" height="130" width="200" >

 </div>

图片可真不好截，三张图片大小不一，以后再完善吧。以上三张图标识的三个文件是OMNeT++团队提供给开发者的基本帮助文档，作者在写这个文档的时候，自我认为都还没有把这些文档翻完，慢慢的，觉得这些资料本身已经够用了......作者会在后续的文档中，描述一下OMNeT++提供给我们的地图。



# 2.3 INET库

## 2.3.1 INET库的介绍
&#160; &#160; &#160; &#160; 从一个初学者的角度，当安装OMNeT++后，大多数的情况下是需要安装INET库的，这个集成库包含了丰富的仿真模型，多数时候，读者如果设计一个网络仿真程序，有不想重新编写代码，这时候，可以在INET下寻找是否有满足要求的example，包括的网络有：

- adhoc
- aodv
- ethernet
- ipv6

等等，上面列举出的只是其中经常用到的一小部分，但是这也存在读者的不同研究背景，可能其中涉及的还不算很全。目前，作者，对于INET的使用较浅薄，水平还停留在调用INET库中的ned文件中的节点类型，或者其他诸如移动模型的水平上。在该小节，作者先为读者描述一下如何在OMNeT++下快速的使用INET库和目前作者的经常使用的技巧。


## 2.3.2 INET库的安装
&#160; &#160; &#160; &#160;通常有两种方法安装INET，在安装之前，首先需要到:
[https://inet.omnetpp.org]()
下载合适的版本，由于前面的OMNeT++使用的5.2的版本，这里我们可以选择**inet-3.6.2**，下载结束以后，将inet解压到omnetpp的安装路径下的samples文件下，此时inet文件的路径可能是：
**xxx/omnetpp-5.2/samples/inet**
(解压INET-3.6.2文件后只有一个inet文件)。接下来，我们需要：
- 方法一：命令窗口安装INET

&#160; &#160; &#160; &#160;其实，如果需要为omnetpp安装新的插件或者库，都可以通过命令行的形式进行安装，甚至，你可以在命令行的环境下对编写好的网络进行编译和运行。
&#160; &#160; &#160; &#160;作者编写这个学习手册的原则，就是为读者提供一个学习omnetpp的地图，而不是一般详细字典，可能作者的水平还远远没有达到写一本学习omnetpp的大全。首先，安装这个INET库，我们到inet文件下看看有什么有用的文件没有，当然是先看看**README.md**了，这个文件提示我们安装请看：**INSTALL**，下面是这个INSTALL的英文：
```
If you are building from command line:
--------------------------------------
3. Change to the INET directory.

4. Type "make makefiles". This should generate the makefiles for you automatically.

5. Type "make" to build the inet executable (debug version). Use "make MODE=release"
   to build release version.

6. You can run specific examples by changing into the example's directory and executing "./run"

```
当然，你可以选择**mingwenv.cmd**命令窗口，输入以上指令进行编译安装。上面的英文安装较为简洁，下面是作者使用命令窗口安装的过程：

- [1] 在安装INET库之前，应先确保OMNeT++已经安装成功。进入到OMNeT++安装路径，找到**mingwenv.cmd**文件，双击执行，进入下图：

<div align="center">
<img src="img/chapter2/cmd.png" height="130" width="200" >
<img src="img/chapter2/cmd2.png" height="130" width="200" >
 </div>

- [2] 接下来，使用命令：**cd samples/inet**，进入到samples下的inet，另可使用ls命令查看当前inet文件下各子文件。

- [3] 然后，执行**make makefiles**命令生成编译整个inet库的makefile文件，结束以后输入命令**make**。到这来，使用命令窗口编译inet库就结束了。
- [4] 最后需要在OMNeT++ IDE中Project Explore窗口空白处右击, 如图，使用Import功能导入已经编译好的inet库。

<div align="center">
<img src="img/chapter2/import.png" height="130" width="200" >
<img src="img/chapter2/import2.png" height="130" width="200" >
<img src="img/chapter2/import3.png" height="130" width="200" >

 </div>



- 方法二：OMNeT++窗口安装

&#160; &#160; &#160; &#160;一样的，在**INSTALL**下命令行安装方式下面就是使用IDE的安装方式，这个IDE的使用方式就是将INET库使用omnetpp打开，当然此时库文件inet已经在**samples**文件下，我们需要做的就是打开omnet IDE，然后导入整个inet工程。
```
If you are using the IDE:
-------------------------
3. Open the OMNeT++ IDE and choose the workspace where you have extracted the inet directory.
   The extracted directory must be a subdirectory of the workspace dir.

4. Import the project using: File | Import | General | Existing projects into Workspace.
   Then select the workspace dir as the root directory, and be sure NOT to check the
   "Copy projects into workspace" box. Click Finish.

5. Open the project (if already not open) and wait until the indexer finishes.
   Now you can build the project by pressing CTRL-B (Project | Build all)

6. To run an example from the IDE open the example's directory in the Project Explorer view,
   find the corresponding omnetpp.ini file. Right click on it and select Run As / Simulation.
   This should create a Launch Configuration for this example.

If the build was successful, you may try running the demo simulations.
Change into examples/ and type "./rundemo".

```
&#160; &#160; &#160; &#160;根据上面的步骤，需要点击：**File | Import | General | Existing projects into Workspace** ，导入inet整个工程文件，对整个工程进行编译即可。


# 2.4 常规使用

## 2.4.1 导入工程
&#160; &#160; &#160; &#160;其实作者觉得还是有必要把这一小节的内容加入其中，考虑了一下，这个软件的有些操作还是不太一样，可能初学者自己去找需要花大量的时间。</br>
&#160; &#160; &#160; &#160;在学习如何导入工程前，先观察一张图：

<div align="center">

<img src="img/图2-4-1.png" height="400" width="700" >

<b>图2-4-1 IDE视图</b>

</div>

&#160; &#160; &#160; &#160;图2-4-1中，左边窗口为**Project Explorer**，在软件安装首次打开**IDE**时，**Project Explorer**中已经默认有相关的**samples**目录下的工程，如果开发者想要打开已有的工程，需要在**Project Explorer**窗口空白处右击鼠标，进行**Import | General | Existing Projects into Workspace**，最后选择工程文件即可，不需要任何设置直接**finish**即可。其中相关的中间过程如下：

<div align="center">

<img src="img/图2-4-2.png" height="600" width="700" >

<b>图2-4-2 点击Import后视图</b>

</div>

<div align="center">

<img src="img/图2-4-3.png" height="700" width="600" >

<b>图2-4-3 点击Existing Projects into Workspace后视图</b>

</div>

&#160; &#160; &#160; &#160;前面已经描述了相关过程，需要注意的是保证工程文件**不要放在有中文名的路径**下，如果包括的中文路径，在后期编译工程时，可能在**ned**文件下出现大量错误，无法识别**ned**文件路径。



## 2.4.2 程序执行与调试
