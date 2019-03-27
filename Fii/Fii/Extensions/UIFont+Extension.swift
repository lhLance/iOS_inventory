//
//  UIFont+Extension.swift
//  Fii
//
//  Created by Liu Tao on 2019/2/25.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import UIKit

extension UIFont {
    
    static func PFRegular(_ size: CGFloat) -> UIFont {
        
        return UIFont(name: "PingFang_Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func PFMedium(_ size: CGFloat) -> UIFont {
        
        return UIFont(name: "PingFang_Medium", size: size) ?? UIFont.boldSystemFont(ofSize: size)
    }
    
    static func PFBold(_ size: CGFloat) -> UIFont {
        
        return UIFont(name: "PingFang_Bold", size: size) ?? UIFont.boldSystemFont(ofSize: size)
    }
}
