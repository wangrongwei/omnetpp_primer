<p align="center">
  <a href="https://reach.tech/router/">
    <img alt="Reach Router" src="./img/logo-horizontal.png" width="400">
  </a>
</p>

<p align="center">
  一个较为详细的<b>OMNeT++</b>学习手册
</p>

<p align="center">
  <a href="https://github.com/wangrongwei/OMNeTpp_Manual/stargazers"><img src="https://img.shields.io/github/stars/wangrongwei/OMNeTpp_Manual.svg?style=flat&label=Star"></a>
  <a href="https://github.com/wangrongwei/OMNeTpp_Manual/fork"><img src="https://img.shields.io/github/forks/wangrongwei/OMNeTpp_Manual.svg?style=flat&label=Fork"></a>
  <a href="https://github.com/wangrongwei/OMNeTpp_Manual/watchers"><img src="https://img.shields.io/github/watchers/wangrongwei/OMNeTpp_Manual.svg?style=flat&label=Watch"></a>

</p>

# 文档说明

&#160; &#160; &#160; &#160;该文档记录了作者从在设计一个无人机蜂群网络的时候，从初学<b>OMNeT++</b>软件开始遇到的各种问题，苦于当初无处找到答案，只能上**google group**提问题，阅读大量的网络仿真程序，慢慢的才对这个软件的各种接口使用和设置才熟悉，特此，在该文档下记录各种<b>OMNeT++</b>的操作，来减少读者的开发和网络仿真的烦恼。</br>
&#160; &#160; &#160; &#160;由于作者的水平有限，本文大多数都是基于<b>OMNeT++</b>初学者的角度进行描述，也会存在理解错误的地方，欢迎读者发邮件指出，如果您有其他宝贵的建议，也欢迎发邮件交流，我希望这个文档让广大的网络设计者受惠。</br>
<div align="right">
———zackary 2018年5月于北航
</div>

# 主要内容
&#160; &#160; &#160; &#160;<b>OMNeT++</b>下网络仿真程序的设计一般分为两种：完全的设计一个网络和可调用相关模型设计，为了满足两种设计模式的需求，作者将以下内容补充到手册中：
- [1] OMNeT++的安装
- [2] INET库的安装
- [3] INET库的基本使用
- [4] OMNeT++工程设计
- [5] OMNeT++个性化设置
- [6] 仿真结果分析
- [7] 仿真错误记录



# 下载地址

&#160; &#160; &#160; &#160;本书不定时更新，欢迎读者到
[https://github.com/wangrongwei/omnetpp_primer](<https://github.com/wangrongwei/omnetpp_primer>)
下载最新版本。</br>

# 如何构建《OMNeT++学习笔记》PDF

### GNU/Linux 发行版
&#160; &#160; &#160; &#160;这里给出如何在自己的机器上构建此书的简单介绍。因作者经验有限，此文仅列出**GNU/Linux**发行版下的构建，欢迎各位增补。</br>
&#160; &#160; &#160; &#160;这里使用了**texlive 2015**工具集，越新越好。**Debian Stretch**和**Ubuntu 16.04/16.10**可直接运行**install.latex.ubuntu.sh**脚本安装所有需要的包。**Fedora 24 / 25**可以运行如下命令：</br>
>sudo dnf -y install @"Authoring and Publishing" pandoc pandoc-pdf pandoc-citeproc texlive-textpos texlive-tocbibind texlive-framed  texlive-appendix texlive-tabulary texlive-fandol google-noto-cjk-fonts texlive-bigfoot

这样可以安装必须的包。低于**Fedora 23**（含）的版本均需要安装**Fandol**系列字体，可以运行**install.fandol.sh**脚本安装。

安装好后执行**make pdf**即可，会在当前目录下生成**omnetpp-zh.pdf**文件。

### Windows 和 macOS

[TODO]




# 联系方式
| - | - |
| ----- | ------------------------- |
| email | wangrongwei2014@gmail.com |
| QQ | 1312553554 |


# 贡献者

| 贡献者 | 贡献内容 |
| ------ | -------- |
| @nadebula | 编写了第一、二到七部分以及其他一些文章，并完善 pdf 格式排版|



# 授权许可
GNU FDL 1.3 （GNU 自由文档许可证）
