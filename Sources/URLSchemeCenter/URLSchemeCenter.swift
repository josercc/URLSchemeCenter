import Foundation
/// URL Scheme功能管理器
/// [URL Scheme]://[HOST]/[Path][Query]
public class URLSchemeCenter {
    /// 支持的Scheme列表 如果为空则支持全部
    public let schemes:[String] = []
    /// 获取URLSchemeCenter功能的单利
    public static let center = URLSchemeCenter()
    /// 存放注册的回掉
    private var registerURLSehemeMap:[String:() -> URLScheme?] = [:]
    /// 存放`Host`下面对应`Path`的执行方法
    internal var urlSchemeActionMap:[String:[URLSehemeAction]] = [:]
    
    /// 注册监听URL Scheme
    /// - Parameters:
    ///   - seheme: 符合`URLScheme`协议的监听类型
    ///   - block: 监听对象
    public func register<U:URLScheme>(seheme:U.Type, _ block:@escaping() -> U?) {
        let host = U.host
        assert(!registerURLSehemeMap.keys.contains(host), "\(host)已经被其他注册请更换")
        let _block:() -> URLScheme? = {
            return block()
        }
        registerURLSehemeMap[U.host] = _block
        U.urlSchemeActions()
    }
    
    /// 解析路由是否被URL Scheme功能管理器支持
    /// - Parameter url: 路由
    /// - Returns: true代表支持 false 代表不支持
    public func router(url:String) -> Bool {
        guard let urlComponments = URLComponents(string: url) else {
            return false
        }
        guard let scheme = urlComponments.scheme, !scheme.contains("http") else {
            return false
        }
        guard schemes.contains(scheme) || schemes.count == 0 else {
            return false
        }
        guard let host = urlComponments.host else {
            return false
        }
        guard registerURLSehemeMap.keys.contains(host) else {
            return false
        }
        guard let urlSchemeBlock:(() -> URLScheme?) = registerURLSehemeMap[host] else {
            return false
        }
        guard let urlScheme = urlSchemeBlock() else {
            return false
        }
        guard let actions = urlSchemeActionMap[host] else {
            return false
        }
        for action in actions {
            if urlComponments.path == action.path {
                let queryItems:[URLQueryItem] = urlComponments.queryItems ?? []
                let parameters:[String:String] = self.queryItemsToDic(queryItems: queryItems)
                action.action(urlScheme, parameters)
                return true
            }
        }
        return false
    }
    
    /// 将`URLQueryItem`数组转换成字典 如果是数组类型 则用,分割的字符串
    /// - Parameter queryItems: `URLQueryItem`数组
    /// - Returns: 字符串类型字典
    func queryItemsToDic(queryItems:[URLQueryItem]) -> [String:String] {
        var arrayDic:[String:[String]] = [:]
        for item in queryItems {
            var list:[String] = arrayDic[item.name] ?? []
            if let value = item.value {
                list.append(value)
            }
            arrayDic[item.name] = list
        }
        return arrayDic.mapValues({$0.joined(separator: ",")})
    }
}



