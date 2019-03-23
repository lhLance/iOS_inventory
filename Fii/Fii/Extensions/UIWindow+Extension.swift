//
//  UIWindow+Extension.swift
//  Fii
//
//  Created by Liu Tao on 2019/3/23.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import Foundation
import UIKit

extension UIWindow {
    
    static let keyWindow = UIApplication.shared.keyWindow
    
    var topVC: UIViewController? {
        
        if let tabVC = self.rootViewController as? UITabBarController,
            let navVC = tabVC.selectedViewController as? UINavigationController,
            let topVC = navVC.topViewController {
            return topVC
        }
        
        return nil
    }
}
