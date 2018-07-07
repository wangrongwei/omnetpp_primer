# 4.1 经验之谈

&#160; &#160; &#160; &#160;欢迎读者来到第四章的学习，本章作者打算从工程应用的角度，结合作者现有的仿真经验分享一些技巧，用套路二字来形容也不为过。</br>
&#160; &#160; &#160; &#160;本章涉及的内容包括信道模型应用、节点分布相关、节点之间如何建立通信以及门向量的相关设置，同时也会涉及以上代码相关的说明，简而言之，本章采用情景分析的方法进行说明。

# 4.2 信道模型很重要

 &#160; &#160; &#160; &#160;据说理想的运放可以摧毁整个地球，那么作者在想是不是理想的充电宝是不是充不满电，偏题了偏题了，那么理想的信道呢？在<b>OMNeT++</b>中仿真的时候，如果没有添加信道模型，消息在两个节点之间传输线就是理想的信道模型，这个仿真信道会影响什么呢？

-   仿真结果
-   仿真现象

&#160; &#160; &#160; &#160;影响仿真结果好理解，仿真现象呢，那我们来看看仿真模型：

```c
channel Channel extends DatarateChannel
{
    delay = default(uniform(20ns, 100ns));
    datarate = default(1000Mbps);
}
```

以上代码是一个简单的信道模型，将这个信道加入到传输线上将会有意想不到的效果。

# 4.3 send函数有套路

&#160; &#160; &#160; &#160;不知道读者有时候有没有感觉到<b>send</b>函数很麻烦，<b>send</b>函数用于两个模块之间的消息传输，但是当我们需要发送多条消息的时候，我们不能使用<b>for</b>循环直接就上，其主要原因就上我们使用<b>send</b>函数发送的消息还没有到达目的节点，此时我们不能使用<b>send</b>函数发送下一条消息，那么怎么办呢？这里有两种方案：

-   利用<b>scheduleAt</b>函数

```c
void Node::handleMessage(cMessage* msg)
{
    if(msg->isSelfMessage()){
        if(msg->getKind()==SMSG_INIT){
                ...
                ...
		cMessage* cloudMsg = new cMessage("hello");
		cloudMsg->setKind(SMSG_INIT);//设置节点类型
		scheduleAt(simTime()+0.01,cloudMsg); //调度一个事件，发送消息给自己
        }
    }
}
```

&#160; &#160; &#160; &#160;通过使用<b>scheduleAt</b>函数使仿真时间走动，完成上一个消息的完成，这里补充一点，如果读者想使用延时来等待消息传输完成是不可行的，因为使用这种方法仿真时间是不会走动的。例如下面一段代码：

```c
time1 = simTime();
func();
time2 = simTime();
```

&#160; &#160; &#160; &#160;在上面这段代码中我们的使用<b>func</b>函数想使时间走动，但是实验结果告诉我们：
$time1==time2$，
经过多次多个地方验证，发现在<b>OMNeT++</b>中如果不调用与仿真时间相关的函数，仿真时间是不会走动的，与上面的实验现象是一致的。因此为了实现仿真时间的走动我们可以采用上面<b>scheduleAt</b>函数自我调度一个时间然后再发送下一个消息。

- 一定要采用<b>send</b>函数呢？

&#160; &#160; &#160; &#160;上述采用<b>scheduleAt</b>的方法太麻烦，需要new一个消息，然后还需要定义一个<b>SMSG_INIT</b>，另外无端增多<b>handleMessage</b>函数内容，这种方法的确不是特别简洁。这里再分享另一种方法：
```c
cPacket *pkt = ...; // packet to be transmitted
cChannel *txChannel = gate("out")->getTransmissionChannel();
simtime_t txFinishTime = txChannel->getTransmissionFinishTime();
if (txFinishTime <= simTime())
{
    // channel free; send out packet immediately
    send(pkt, "out");
}
else
{
    // store packet and schedule timer; when the timer expires,
    // the packet should be removed from the queue and sent out
    txQueue.insert(pkt);
    scheduleAt(txFinishTime, endTxMsg);
}

```
&#160; &#160; &#160; &#160;上面的代码用于通过<b>out</b>门发送一个<b>pkt</b>包，但是在传输前需要得到该门上传输的消息的完成时间，需要注意的是当<b>txFinishTime</b>为<b>-1</b>时，说明该门没有消息传输，可以直接发送，如果<b>txFinishTime</b>为一个大于0的值，说明有消息正在传输，需要等待。所以在判断时我们采用$txFinishTime <= simTime()$。</br>
&#160; &#160; &#160; &#160;通过这种方式，我们可以在<b>for</b>循环中发送多个消息。




#


#
