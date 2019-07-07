# OMNeT++仿真类 #

在完成第五章后，考虑需要在之前加一章节关于<b>OMNeT++</b>类说明，在这个仿真软件中，主要使用的语言是<b>C++</b>，因此大多数数据类型是类或者结构，本章还是走其他技术书一样的老路线，注释这些数据类型，对类成员函数进行说明，可能与第五章有些重复的地方，但是其五章更多的偏向于实际应用，可能读者看过这里后，会发现<b>OMNeT++</b>接口是真好用。

## 类说明 ##

### cModule ###

为了能更好的解释这个的库的使用，程序清单<b>4.1</b>为类<b>cModule</b>原型，<b>cModule</b>类在<b>OMNeT++</b>中表示一个节点的对象，这个节点可以是复合节点或者简单节点，通过这个类，程序员可以访问描述这个节点的<b>.ned</b>文件中设置的参数，或者是由<b>omnetpp.ini</b>传入的参数。简而言之，我们最后就是面向这些类进行网络设计。

```c
程序清单4.1
class SIM_API cModule : public cComponent //implies noncopyable
{
    friend class cGate;
    friend class cSimulation;
    friend class cModuleType;
    friend class cChannelType;

  public:
    /********************************************************************************
     * 迭代器
     *******************************************************************************/
    GateIterator; /* 门迭代器 */
    SubmoduleIterator; /* 复合模块的子模块迭代器 */
    ChannelIterator; /* 模块信道迭代器 */

  public:
    virtual void callRefreshDisplay();
    virtual const char *getFullName(); /* 获取模块全名（绝对名） */
    virtual std::string getFullPath(); /* 获取模块路径（绝对路径） */
    virtual bool isSimple();

    virtual cModule *getParentModule(); /* 返回模块的父模块，对于系统模块，返回nullptr */
    bool isVector(); /* 如何模块是使用向量的形式定义的，返回true */
    int getIndex(); /*返回模块在向量中的索引 */
    int getVectorSize(); /*返回这个模块向量的大小，如何该模块不是使用向量的方式定义的，返回true */

    _OPPDEPRECATED int size(); /* 与getVectorSize()功能相似 */
    virtual bool hasSubmodules(); /* 检测该模块是否有子模块 */

    // 寻找子模块name，找到返回模块ID，否则返回-1
    // 如何模块采用向量形式定义，那么需要指明index
    virtual int findSubmodule(const char *name, int index=-1);

    // 直接得到子模块name的指针，没有这个子模块返回nullptr
    // 如何模块采用向量形式定义，那么需要指明index
    virtual cModule *getSubmodule(const char *name, int index=-1);

    /* 一个更强大的获取模块指针的接口，通过路径获取 */
    virtual cModule *getModuleByPath(const char *path);

    /********************************************************************************
     * 门的相关函数
     *******************************************************************************/
    virtual bool hasGate(const char *gatename, int index=-1); /* 检测是否有门 */
    virtual int findGate(const char *gatename, int index=-1); /* 寻找门，如果没有返回-1，找到返回门ID */
    const cGate *gate(int id); /* 通过ID得到门地址，目前我还没有用到过 */
    virtual void deleteGate(const char *gatename); /*删除一个门（很少用） */
    virtual std::vector<const char *> getGateNames(); /* 返回模块门的名字，只是基本名字(不包括向量门的索引, "[]" or the "$i"/"$o"） */ 
    virtual cGate::Type gateType(const char *gatename); /* 检测门（向量门）类型，可以标明"$i","$o" */
    virtual bool isGateVector(const char *gatename); /* 检测是否是向量门，可以标明"$i","$o" */
    virtual int gateSize(const char *gatename); /* 得到门的大小，可以指明"$i","$o" */

    /*******************************************************************************
     * 公用
     *******************************************************************************/
    virtual cPar& getAncestorPar(const char *parname); /* 在父模块中寻找某个参数，没找到抛出cRuntimeError */
    virtual void setBuiltinAnimationsAllowed(bool enabled); /* 设置是否在此模块的图形检查器上请求内置动画 */
    virtual void deleteModule(); /* 删除自己 */
    virtual void changeParentTo(cModule *mod); /* 移动该模块到另一个父模块下，一般用于移动场景。规则较复杂，可到原头文件查看使用说明 */
};
```

**cModule**是**OMNeT++**中用于代表一个模块的对象实体，如果你在编写网络仿真代码时，这个模块可以是简单模块或者复合模块，当需要得到这个模块相关属性时可以考虑到这个**cModule**类里边找找，说不定有意外的惊喜，也许有现成的函数实现你需要的功能。下面将这个类原型解剖看看：

- **迭代器：GateIterator**

```c
usage：
for (cModule::GateIterator it(module); !it.end(); ++it) {
        cGate *gate = *it;
        ...
}
```

该迭代器可用于遍历模块**module**的门向量，得到该门可用于其他作用。

- **迭代器：SubmoduleIterator**

```c
usage:
for (cModule::SubmoduleIterator it(module); !it.end(); ++it) {
        cModule *submodule = *it;
        ...
}
```

对于一个复合模块，包括多个简单模块或者复合模块，可使用该迭代器进行遍历操作，在第五章涉及到这个迭代器的使用。

- **迭代器：ChannelIterator**

```c
usage:
for (cModule::ChannelIterator it(module); !it.end(); ++it) {
        cChannel *channel = *it;
        ...
}
```

可用于遍历该模块的所有的信道。

### cPar ###

**cPar**同样是我们设置网络时不可避免的类，通过<b>cPar</b>得到节点在网络拓扑文件和配置文件中设置的参数，浏览完<b>cPar</b>所有成员函数，可以看出<b>cPar</b>基本提供了网络设计者想要的所有数据转换接口。

```c
class SIM_API cPar : public cObject
{
    friend class cComponent;
  public:
    // 返回参数的名字
    virtual const char *getName() const override;

    // 以字符串的形式返回参数
    virtual std::string str() const override;

    virtual cObject *getOwner() const override; // note: cannot return cComponent* (covariant return type) due to declaration order

    Type getType() const;

    static const char *getTypeName(Type t);

    bool isNumeric() const;

    bool isVolatile() const;

    bool isExpression() const;

    bool isShared() const;

    bool isSet() const;

    cPar& setBoolValue(bool b);

    cPar& setLongValue(long l);

    cPar& setDoubleValue(double d);

    cPar& setStringValue(const char *s);

    cPar& setStringValue(const std::string& s)  {setStringValue(s.c_str()); return *this;}

    cPar& setXMLValue(cXMLElement *node);

    bool boolValue() const;

    long longValue() const;

    double doubleValue() const;

    const char *getUnit() const;

    const char *stringValue() const;

    std::string stdstringValue() const;

    cXMLElement *xmlValue() const;

    void parse(const char *text);

    // 与stdstringValue()功能一样
    operator std::string() const  {return stdstringValue();}

    // 与xmlVlaue()等同。注意：返回对象树的生命周期被限制了，具体看xmlValue说明。
    operator cXMLElement *() const  {return xmlValue();}
};
```

### cGate ###

如果你需要在网络仿真运行时，动态实现两个节点之间的连接或者断开，那么你就需要在程序中用到这个类。

```c
class SIM_API cGate : public cObject, noncopyable
{
    friend class cModule;
    friend class cModuleGates;
    friend class cPlaceholderModule;

  public:
    cGate *prevGate;    // previous and next gate in the path
    cGate *nextGate;

    static int lastConnectionId;

    static void clearFullnamePool();

    // internal
    void installChannel(cChannel *chan);

    // internal
    void checkChannels() const;

    /* 例如返回门out */
    virtual const char *getName() const override;

    /* 与getName()不同，需要返回门索引，例如out[4] */
    virtual const char *getFullName() const override;

    /**
     * This function is called internally by the send() functions and
     * channel classes' deliver() to deliver the message to its destination.
     * A false return value means that the message object should be deleted
     * by the caller. (This is used e.g. with parallel simulation, for
     * messages leaving the partition.)
     */
    virtual bool deliver(cMessage *msg, simtime_t at);

    cChannel *connectTo(cGate *gate, cChannel *channel=nullptr, bool leaveUninitialized=false);

    void disconnect();

    cChannel *reconnectWith(cChannel *channel, bool leaveUninitialized=false);

    const char *getBaseName() const;

    const char *getNameSuffix() const;

    cProperties *getProperties() const;

    Type getType() const  {return desc->getTypeOf(this);}

    static const char *getTypeName(Type t);

    cModule *getOwnerModule() const;

    int getId() const;

    bool isVector() const  {return desc->isVector();}

    int getIndex() const  {return desc->indexOf(this);}

    int getVectorSize() const  {return desc->gateSize();}

    cChannel *getChannel() const  {return channel;}

    cChannel *getTransmissionChannel() const;

    cChannel *findTransmissionChannel() const;

    cChannel *getIncomingTransmissionChannel() const;

    cChannel *findIncomingTransmissionChannel() const;
  
    cGate *getPreviousGate() const {return prevGate;}

    cGate *getNextGate() const   {return nextGate;}

    cDisplayString& getDisplayString();

    void setDisplayString(const char *dispstr);
};
```

### cTopology ###

### cExpression ###

### EV类 ###

一个对调试程序有帮助的类。

```c
class SIM_API cLog
{
  public:
    static LogLevel logLevel;

    static const char *getLogLevelName(LogLevel logLevel);

    static LogLevel resolveLogLevel(const char *name);
};

#define EV_LOG(logLevel, category) OPP_LOGPROXY(getThisPtr(), logLevel, category).getStream()

#define EV        EV_INFO

#define EV_FATAL  EV_LOG(omnetpp::LOGLEVEL_FATAL, nullptr)

#define EV_ERROR  EV_LOG(omnetpp::LOGLEVEL_ERROR, nullptr)

#define EV_WARN   EV_LOG(omnetpp::LOGLEVEL_WARN, nullptr)

#define EV_INFO   EV_LOG(omnetpp::LOGLEVEL_INFO, nullptr)

#define EV_DETAIL EV_LOG(omnetpp::LOGLEVEL_DETAIL, nullptr)

#define EV_DEBUG  EV_LOG(omnetpp::LOGLEVEL_DEBUG, nullptr)

#define EV_TRACE  EV_LOG(omnetpp::LOGLEVEL_TRACE, nullptr)

#define EV_C(category)        EV_INFO_C(category)

#define EV_FATAL_C(category)  EV_LOG(omnetpp::LOGLEVEL_FATAL, category)

#define EV_ERROR_C(category)  EV_LOG(omnetpp::LOGLEVEL_ERROR, category)

#define EV_WARN_C(category)   EV_LOG(omnetpp::LOGLEVEL_WARN, category)

#define EV_INFO_C(category)   EV_LOG(omnetpp::LOGLEVEL_INFO, category)

#define EV_DETAIL_C(category) EV_LOG(omnetpp::LOGLEVEL_DETAIL, category)

#define EV_DEBUG_C(category)  EV_LOG(omnetpp::LOGLEVEL_DEBUG, category)

#define EV_TRACE_C(category)  EV_LOG(omnetpp::LOGLEVEL_TRACE, category)
}
```

## 虚函数 ##

### initialize函数 ###

### handleMessage函数 ###

### refreshDisplay函数 ###

### finish函数 ###

## 本章小结 ##

本章对OMNeT++中提供的相关类进行了描述和说明，阅读相关头文件是掌握OMNeT++仿真有效方法。
