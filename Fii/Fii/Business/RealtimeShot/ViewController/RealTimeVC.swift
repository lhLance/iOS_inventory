//
//  RealTimeVC.swift
//  Fii
//
//  Created by Liu Tao on 2019/3/11.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import UIKit

private let kCategoryMenuWidth = CGFloat(95)


class RealTimeVC: UIViewController {

    let cloumnCategoryMenuTableVc = CloumnCategoryMenuTableController()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.blue
        self.setupUI()
    }

}


extension RealTimeVC{
   private func setupUI(){
    cloumnCategoryMenuTableVc.view.frame = CGRect(0, kNavigationBarH + kStatusBarH, kCategoryMenuWidth, self.view.frame.height - kStatusBarH - kNavigationBarH)
    self.view.addSubview(cloumnCategoryMenuTableVc.view)
    }
}
