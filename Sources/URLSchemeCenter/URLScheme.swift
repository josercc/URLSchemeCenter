//
//  URLScheme.swift
//  
//
//  Created by 张行 on 2020/9/14.
//

import Foundation

public protocol URLScheme {
    /// 对应的Host
    static var host:String {get}
    
    /// 添加对应的路径事件
    static func urlSchemeActions()
}

extension URLScheme {
    
    public static func addURLSchemeAction(path:String, action:@escaping(Self, [String:String]) -> Void) {
        let action = URLSehemeAction(path: "/\(path)") { (urlScheme, parameters) in
            guard let _urlScheme = urlScheme as? Self else {
                return
            }
            action(_urlScheme,parameters)
        }
        var actions = URLSchemeCenter.center.urlSchemeActionMap[Self.host] ?? []
        actions.append(action)
        URLSchemeCenter.center.urlSchemeActionMap[Self.host] = actions
    }
}
