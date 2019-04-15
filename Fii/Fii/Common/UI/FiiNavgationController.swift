//
//  FiiNavgationController.swift
//  Fii
//
//  Created by Liu Tao on 2019/4/15.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import UIKit

class FiiNavgationController: UINavigationController {
    
    override func loadView() {
        super.loadView()
        
        resetNavbar()
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        // 解决自定义 leftItem 导致无法使用侧滑手势返回的的问题
        interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        super.pushViewController(viewController, animated: animated)
    }
    
    func resetNavbar() {
        let bar = navigationBar
        bar.tintColor = UIColor.black
        bar.barTintColor = UIColor.white
        bar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.PFRegular(18)
        ]
    }
    
    func setNavBarColor(_ color: UIColor) {
        
        navigationBar.isTranslucent = UIColor.clear == color
        navigationBar.barTintColor = color
    }
}
