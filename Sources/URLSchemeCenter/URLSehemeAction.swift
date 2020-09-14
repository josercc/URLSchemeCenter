//
//  URLSehemeAction.swift
//  
//
//  Created by 张行 on 2020/9/14.
//

import Foundation

/// 路径方法
public struct URLSehemeAction {
    /// 监听路径
    let path:String
    /// 对应的方法
    let action:((_ scheme:URLScheme?, _ queryItem:[String:String]) -> Void)
}


