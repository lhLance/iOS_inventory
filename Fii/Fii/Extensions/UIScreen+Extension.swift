
//
//  UIScreen+Extension.swift
//  Fii
//
//  Created by Liu Tao on 2019/2/25.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import UIKit

extension UIScreen {
    
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    
    static var navBarHeight: CGFloat {
        return UIDevice.isPhoneXorMore ? 88 : 64
    }
    
    static var tabBarHeight: CGFloat {
        return UIDevice.isPhoneXorMore ? 83 : 49
    }
    
    static let safeAreaBottomHeight = 49.cgFloat
}

let kStatusX_H = UIDevice.isPhoneXorMore ? 20 : 0
let kStatusBarH: CGFloat = CGFloat(20 + kStatusX_H)
let kNavigationBarH: CGFloat = CGFloat(44)
let kTabBottomH = CGFloat(49)
