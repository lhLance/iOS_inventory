//
//  FiiTabBarController.swift
//  Fii
//
//  Created by Liu Tao on 2019/3/11.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import UIKit

class FiiTabBarController: UITabBarController {

    convenience init(_ subVCs: [UIViewController]) {
        self.init(nibName: nil, bundle: nil)
        
        subVCs.forEach { vc in
            self.addChild(vc)
        }
    }
    
    override func loadView() {
        super.loadView()
        
        let tabBar = FiiTabBar(frame: CGRect.zero)
        self.setValue(tabBar, forKey: "tabBar")
    }

    override var childForStatusBarStyle: UIViewController? {
        
        return self.selectedViewController
    }
}

class FiiTabBar: UITabBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.barTintColor = UIColor.white
        self.isTranslucent = false
        
        let normal_attributes = [NSAttributedString.Key.font: UIFont.Kmedium(11),
                                 NSAttributedString.Key.foregroundColor: UIColor.hex(0x515151)]
        let select_attributes = [NSAttributedString.Key.font: UIFont.Kmedium(11),
                                 NSAttributedString.Key.foregroundColor: UIColor.hex(0xdf3231)]
        
        UITabBarItem.appearance().setTitleTextAttributes(normal_attributes, for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(select_attributes, for: .selected)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
