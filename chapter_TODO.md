## 一 待完善

- [1] 如何加快节点间消息的传输？
- [2] 在一个复合模块下，如何访问同一级的其他模块？
- [3] 如何得到某一个模块引用的ned路径？   
- [4] 如何使用cTopology类遍历网络的拓扑来初始化路由表?
- [5] 如何在omnet上使用OpenSceneGraph


## 二 详细内容

### 1 在节点之间传输消息的时候，如何加快消息的传输速度？
当节点数量较大的时候，需要较快的实现消息传送的效果。



### 2 通过父模块取出同一级其他模块

```c
cModule *parent = getParentModule();

// 取出父模块下的beBuffer模块
cModule *psubmodBE = parent->getSubmodule("beBuffer");
BEBuffer *pBEBuffer = check_and_cast<BEBuffer *>(psubmodBE);

cModule *psubmodRC = NULL;
RCBuffer *pRCBuffer = NULL;
// 取出父模块下的rcBuffer模块
psubmodRC = parent->getSubmodule("rcBuffer");
pRCBuffer = check_and_cast<RCBuffer *>(psubmodRC);

```

### 2.1 访问所有节点

```c

void Node::doNext()
{
    char dis[50];
    cModule* parent = getParentModule();
    cModule* mod,*UAVHead,*UAVmod;

    cGate* gOut;
    cGate* gIn;

    //显示蓝色
    sprintf(dis,"p=%f,%f;i=device/drone4_64",this->xpos,this->ypos);
    parent->setDisplayString(dis);

    //testmod = cSimulation::getActiveSimulation()->getModule(1)->getSubmodule("UAVA",j)->getSubmodule("WirelessMod");
    //网络中的所有节点都初始化
    for(int i=1;i<=cSimulation::getActiveSimulation()->getLastComponentId();i++){

        int number_of_Bees = cSimulation::getActiveSimulation()->getLastComponentId();

        cSimulation *simobj = cSimulation::getActiveSimulation();
        //这里需要优化
        mod=cSimulation::getActiveSimulation()->getModule(i);
        if(strcmp(mod->getName(),"CenController") == 0){
            continue;
        }
        else{
            int j=0;
            while(1){
                string modname = cSimulation::getActiveSimulation()->getModule(i)->getName();

                UAVHead = cSimulation::getActiveSimulation()->getModule(i)->getSubmodule(this->clustername.c_str(),j)->getSubmodule("WirelessMod");
                if(((Node*)UAVHead)->myId == this->headId){
                    //找到簇头节点,退出while循环
                    break;
                }
                j++;
            }
            //定一个时间，啥时候将这个id，pop出容器
            break;
        }
    }
}

```



### 3 如何得到一个简单模块的引用的ned路径？

```c
cModule *parent = getParentModule();
const char *name = parent->getNedTypeName();

if (strcmp(name, "SimpleNetwork.Node.SimpleNode") == 0){
    cGate *outgate = gate("line$o");
    cChannel *chan = outgate->findTransmissionChannel();
    linkspeed = chan->getNominalDatarate();

}
else if (strcmp(name, "SimpleNetwork.Switch.SwitchPort") == 0){
    //int id = parent->findGate("line$o");
    cGate *outgate = parent->gate("line$o");
    cChannel *chan = outgate->findTransmissionChannel();
    linkspeed = chan->getNominalDatarate();
}


```

### 4 探测该节点node的拓扑：
```c
/*
 * 探测交换机网络的拓扑
 */
void Router::TopoFind()
{
    cTopology *topo = new cTopology("topo");

    topo->extractByNedTypeName(cStringTokenizer("SimpleNetwork.Node.SimpleNode SimpleNetwork.Switch.SimpleSwitch").asVector());

    EV << "cTopology found " << topo->getNumNodes() << " nodes\n";

    //得到表示本节点的对象
    cTopology::Node *thisNode = topo->getNodeFor(getParentModule());

    // find and store next hops
    for (int i = 0; i < topo->getNumNodes(); i++){
        if (topo->getNode(i) == thisNode)
            continue; // skip ourselves
        //采用迪杰斯特拉算法计算到节点i的最短距离
        topo->calculateUnweightedSingleShortestPathsTo(topo->getNode(i));
        //本节点与外界连接的通道
        if (thisNode->getNumPaths() == 0)
            continue; // not connected

        cGate *parentModuleGate = thisNode->getPath(0)->getLocalGate();
        int gateIndex = parentModuleGate->getIndex();
        int address = topo->getNode(i)->getModule()->par("address");
        rtable[address] = gateIndex;
        EV << "  towards address " << address << " gateIndex is " << gateIndex  << endl;
    }
    delete topo;
}

```
### 5 cMessage类相关的函数

```c

cMessage *bagReset;

// bagReset->isScheduled() == 1 : 该消息已经传输完成
// bagReset->isScheduled() == 0 : 该消息不在传输状态
if (!bagReset->isScheduled()){
        scheduleAt(simTime(), bagReset);
}

```

### 6 如何使用OpenSceneGraph
其实在omnet中是可以直接使用OpenSceneGraph的，可怜的我尝试了安装了一下午，才知道omnet已经支持OpenSceneGraph了，以后补充这一点可以看：

>file:///D:/omnetpp-5.2/doc/manual/index.html#sec:graphics:opp-api-for-osg


### 使用send发送一个消息如何看这个消息是否发送完，然后再使用send函数

send(pk, "line$o");

```c

simtime_t endTransmission =  gate("line$o")->getTransmissionChannel()->getTransmissionFinishTime()+ETHERNETFRAMEGAP;
scheduleAt(endTransmission, endTransmissionEvent);


然后在handlemessage函数里边：
if (dynamic_cast<MessageAssist *>(msg)){
    if (endTransmissionEvent->isScheduled()){
         delete msg;
    }
    else{
         scheduleMessage();
         delete msg;
    }
}

```
检测好不好使。      



### 7 如何检测一个信道上是否有消息传输

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
上面的代码可以检测当一个信道上消息传输完成以后再传输其他消息。需要注意的是当<b>txFinishTime</b>为<b>-1</b>时，说明该门没有消息传输，可以直接发送。
