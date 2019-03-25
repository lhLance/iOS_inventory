//
//  UserInfo.swift
//  Fii
//
//  Created by Liu Tao on 2019/3/16.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import Foundation
import UIKit

class UserInfo {
    
    static let shared = UserInfo()

    var appKey = ""
    var infoKey = ""
    var alarmCenterVersion = ""
    var authName = ""
    
    var avatar = UIImage("avatar")
    var userName = "null"
    var userEmail = "null"
}
