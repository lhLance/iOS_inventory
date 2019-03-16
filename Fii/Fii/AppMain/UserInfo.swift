//
//  UserInfo.swift
//  Fii
//
//  Created by Liu Tao on 2019/3/16.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import Foundation

class UserInfo {
    
    static let shared = UserInfo()

    var appKey: String? = nil
    var infoKey: String? = nil
    var version: String? = nil
    var authName: String? = nil
}
