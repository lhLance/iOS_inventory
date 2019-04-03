//
//  ChatUserInfo.swift
//  Fii
//
//  Created by yetao on 2019/3/30.
//  Copyright © 2019 Liu Tao. All rights reserved.
//

import Foundation

/*
 用户信息类
 */
class ChatUserInfo: NSObject
{
    var username: String = ""
    var avatar: String = ""
    
    init(name: String, logo: String)
    {
        self.username = name
        self.avatar = logo
    }
}
