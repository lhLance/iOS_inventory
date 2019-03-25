//
//  APP.swift
//  Fii
//
//  Created by Liu Tao on 2019/3/22.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import UIKit

class APP {
    
    enum Language: String {
        case En
        case Ch
    }
    
    static var isLogin = false
    static var currentLanguage = Language.Ch
    
    static let SINGLE_LINE_HEIGHT = 1 / UIScreen.main.scale
    static let SINGLE_LINE_ADJUST_OFFSET = (1 / UIScreen.main.scale) / 2
    static let version = 1
}
