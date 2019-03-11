//
//  FiiTabBarController.swift
//  Fii
//
//  Created by Liu Tao on 2019/3/11.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import UIKit

class FiiTabBarController: UITabBarController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

class FiiTabBar: UITabBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.barTintColor = UIColor.white
        self.isTranslucent = false
        
//        let normal_attributes =[]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
