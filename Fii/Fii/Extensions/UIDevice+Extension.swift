
//
//  UIDevice+Extension.swift
//  Fii
//
//  Created by Liu Tao on 2019/2/25.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import UIKit

extension UIDevice {
    
    static var isPhoneX: Bool {
        return UIScreen.main.bounds.size.height == 812
    }
    
    static var isPhoneXMax: Bool {
        return UIScreen.main.bounds.size.height == 896
    }
    
    static var isPhoneXR: Bool {
        return UIScreen.main.bounds.size.width == 276
    }
    
    static let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
    }
    
    extension UIWindow {
        
        static var keyWindow: UIWindow? {
            return UIApplication.shared.keyWindow
        }
}
