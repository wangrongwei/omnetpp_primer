# 文档说明
&#160; &#160; &#160; &#160;由于在markdown下无法转换出一个满意的pdf文档，因此将原来chapterX.md文档转换成latex格式。<b>omnetppbook.pdf</b>为转换后的文档（目前正在转换）。

# 环境
- 系统：Windows10

- latex工具：texstudio

# 源文件
- tstextbook.cls

&#160; &#160; &#160; &#160;<b>omnetppp_zh.pdf</b>采用的latex模板为开源的tstextbook，该文件为模板类文件，包括封面、目录、章节等格式的定义。

- tstextbook_se.cls

&#160; &#160; &#160; &#160;类模板补充文件，latex开源模板的一部分，在本手册中没有修改。

- omnetppbook.tex

&#160; &#160; &#160; &#160;<b>omnetppp_zh.pdf</b>的顶层latex文件，使用include包括其他的chapterX.tex文件。
