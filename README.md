<p align="center">
  <a href="https://reach.tech/router/">
    <img alt="Reach Router" src="./img/logo-horizontal.png" width="400">
  </a>
</p>

<p align="center">
  一个实用的<b>OMNeT++</b>编程指导手册
</p>

<p align="center">
  <a href="https://github.com/wangrongwei/omnetpp_primer/stargazers"><img src="https://img.shields.io/github/stars/wangrongwei/omnetpp_primer.svg?style=flat&label=Star"></a>
  <a href="https://github.com/wangrongwei/omnetpp_primer/fork"><img src="https://img.shields.io/github/forks/wangrongwei/omnetpp_primer.svg?style=flat&label=Fork"></a>
  <a href="https://github.com/wangrongwei/omnetpp_primer/watchers"><img src="https://img.shields.io/github/watchers/wangrongwei/omnetpp_primer.svg?style=flat&label=Watch"></a>

</p>



# 文档说明

&#160; &#160; &#160; &#160;<b>omnetppp-zh.pdf</b>记录了我在设计无人机蜂群网络仿真过程中，从初学<b>OMNeT++</b>软件到能灵活使用各种接口所遇到的各种问题，苦于当初无处找到详细的<b>OMNeT++</b>工程开发资料，尤其是针对实际功能实现的代码说明资料基本没有。我在阅读大量的网络仿真程序后，慢慢的对这个软件的各种接口和配置才熟悉，同时也从官方提供的手册中提取出较为常用的接口进行说明，最后将我熟悉的套路总结成文档回馈开源。</br>
&#160; &#160; &#160; &#160;由于我水平有限，难免会存在理解错误的地方，欢迎读者发邮件指出，如果您有其他宝贵的建议，也欢迎发邮件交流，希望这个文档能帮助更多的开发者。</br>

<div align="right">
———Zackary 2018年5月
</div>


# 主要内容

&#160; &#160; &#160; &#160;<b>OMNeT++</b>下网络仿真程序的设计一般分为两种：完全的设计一个网络和调用相关模型搭建网络，目前国内<b>OMNeT++</b>相关论文基本没有提供源码，无法知道他们是怎么仿真的，但是国外的相关论文基本都提供源码，并且大多数都是自己编写的源代码。<b>omnetppp-zh.pdf</b>从自行设计一个网络角度出发，提供一些实用的接口使用方法，包括以下内容：
- [1] OMNeT++的安装
- [2] INET库的安装 && INET库的基本使用
- [3] OMNeT++个性化设置
- [4] OMNeT++工程设计技巧
- [5] cModule | cPar | cGate | cTopology相关类使用
- [6] 仿真结果分析
- [7] 仿真错误记录



# 工程目录

- dirtree：工程目录树文件，陈列了当前工程各目录下子文件结构
- img：omnetpp_primer_zh文档所需图片
- latexbook：omnetpp_primer_zh文档LaTex排版（目前未排版完）
- markdown-pdf：omnetpp_primer_zh文档Markdown版本（文字还需修改再精炼）
- pdf：omnetpp_primer_zh文档pdf格式
- tools：生成pdf相关工具（目前还在修改中，希望改成支持make命令）



# 下载地址

&#160; &#160; &#160; &#160;本书不定时更新，欢迎到[https://github.com/wangrongwei/omnetpp_primer/pdf](<https://github.com/wangrongwei/omnetpp_primer/tree/master/pdf>)下载最新的omnetppp-zh.pdf（目前的pdf还存在不完美的地方，尤其是其中的文字无法复制，后期希望能找到解决办法）。</br>



# TODO

- [1] 如何加快节点间消息的传输？

- [2] 在一个复合模块下，如何访问同一级的其他模块？

- [3] 如何得到某一个模块引用的ned路径？   

- [4] 如何使用cTopology类遍历网络的拓扑来初始化路由表?

- [5] 如何在omnet上使用OpenSceneGraph

- [6] 如何从仿真场景读取节点的坐标

- [7] 使用sendDirect()函数

- [8] 复合模块初始化时，先初始化节点的顺序

- [9] 在initialize()中初始化类成员数组与在其他函数中的不同



# 邮箱
|||
| :-----: | :------------------------- |
| email | 1312553554@qq.com |


# 贡献者

| 贡献者 | 贡献内容 |
| ------ | -------- |
| @Zackary | 编写第一、二到七部分以及其他一些文章，并完善 pdf 格式排版|
| @Kmtalexwang | 维护omnetppp_zh.pdf的LaTeX排版 |
| @Stephenhua| 添加appendix中网络性能初版|
| @Ericsyoung| 维护chapter_6.md仿真结果分析|

# 勘误
&#160; &#160; &#160; &#160;如果您发现有关技术上的错误或有必要纠正的内容，欢迎发邮件指出。目前文档正在组织中，借鉴了网上相关资料，在这里表示感谢！后续在慢慢加上相关引用。

# 授权许可
GNU FDL 1.3 （GNU 自由文档许可证）


[travis-image]: https://api.travis-ci.org/wangrongwei/omnetpp_primer.svg
[travis-url]: https://travis-ci.org/wangrongwei/omnetpp_primer
[npm-image]: https://img.shields.io/npm/v/omnetpp_primer.svg
[npm-url]: https://npmjs.org/package/omnetpp_primer
[downloads-image]: https://img.shields.io/npm/dm/omnetpp_primer.svg
[downloads-url]: https://npmjs.org/package/omnetpp_primer
