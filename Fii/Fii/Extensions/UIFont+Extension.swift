//
//  UIFont+Extension.swift
//  Fii
//
//  Created by Liu Tao on 2019/2/25.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import UIKit

extension UIFont {
    
    static func MILanTing(_ size: CGFloat) -> UIFont {
        
        return UIFont(name: "MILanTing_GB", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func Kmedium(_ size: CGFloat) -> UIFont {
        
        return UIFont.init(name: "Kmedium", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func FZLTZCHJW(_ size: CGFloat) -> UIFont {
        
        return UIFont.init(name: "FZLTZCHJW", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
