# URLSchemeCenter

这个库是一个让其他模块通过`URL Scheme`方式调用其他模块的一种方法的库

> 对于模块化之间可能需要调用对应的方法来实现通信
>
> 1. 比如A模块需要调用B模块是否有最新版本的方法(这个也可以通过其他方法)
> 2. 比如Flutter需要发送数据给原生项目，又不想配置复杂的Flutter Channel
> 3. 比如WebView一个点击事件需要唤起App原生功能
> 4. 等等

![image-20200914202236294](https://gitee.com/joser_zhang/upic/raw/master/uPic/image-20200914202236294.png)

```
[Scheme]://[Host]/[path]?[Query]
```

- `Scheme`指代工程支持的`URL Scheme`
- ``Host``指代需要调用模块对应的`Host`
- `Path`指代对应模块功能的路径
- `Query`指代需要传递的参数

## 怎么安装

目前只支持`Swift Package Manager`的安装方式

## 怎么使用

导入库

```swift
import URLSchemeCenter
```

实现`URLScheme`协议

**Example**

```swift
struct DataCollect: URLScheme {
  	/// 添加路径
    static func urlSchemeActions() {
      	/// 添加topic路径方法
        self.addURLSchemeAction(path: "topic") { (collection, parameter) in
            print("topic \(parameter)")
        }
      	/// 添加delete路径方法
        self.addURLSchemeAction(path: "delete") { (collection, parameter) in
            print("delete \(parameter)")
        }
    }
    /// 设置惟一的Host
    static var host: String {
        return "DataCollection"
    }
}
```

