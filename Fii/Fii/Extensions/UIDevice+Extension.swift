
//
//  UIDevice+Extension.swift
//  Fii
//
//  Created by Liu Tao on 2019/2/25.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import UIKit

extension UIDevice {
    
    static var isPhoneXorMore: Bool {
        return UIScreen.main.bounds.size.height == 812
    }
    
    static var isPhone678Plus: Bool {
        return UIScreen.main.bounds.size.height == 736
    }
    
    static var isPhone678: Bool {
        return UIScreen.main.bounds.size.height == 667
    }
    
    static var isPhone5orSE: Bool {
        return UIScreen.main.bounds.size.height == 568
    }
    
    /*判断是否是刘海屏*/
    public func isIphoneXMore() -> Bool
    {
        var isMore: Bool = false
        if #available(iOS 11.0, *) {
            isMore = CGFloat((UIApplication.shared.keyWindow?.safeAreaInsets.bottom)!) > CGFloat(0)
        }
        return isMore
    }
    
    static let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
}
