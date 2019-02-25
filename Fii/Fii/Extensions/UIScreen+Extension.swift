
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
        return (UIDevice.isPhoneX || UIDevice.isPhoneXR || UIDevice.isPhoneXMax) ? 88 : 64
    }
    
    static var tabBarHeight: CGFloat {
        return (UIDevice.isPhoneX || UIDevice.isPhoneXR || UIDevice.isPhoneXMax) ? 83 : 49
    }
    
    static let safeAreaBottomHeight = 49.cgFloat
}
