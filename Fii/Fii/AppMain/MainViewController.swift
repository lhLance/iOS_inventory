//
//  ViewController.swift
//  Fii
//
//  Created by Liu Tao on 2019/2/25.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: UITabBarController {

    static let shared = MainViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setupView() {
        
        let vc1 = RealTimeVC()
        vc1.tabBarItem = UITabBarItem(title: "实时快照",
                                      image: UIImage("screenshot")?.withRenderingMode(.alwaysOriginal),
                                      tag: 0)
        
        let vc2 = VoiceControllVC()
        vc2.tabBarItem = UITabBarItem(title: "语音控制",
                                      image: UIImage("voice")?.withRenderingMode(.alwaysOriginal),
                                      tag: 0)
        
        let vc3 = DeviceListVC()
        vc3.tabBarItem = UITabBarItem(title: "设备数据",
                                      image: UIImage("device_data")?.withRenderingMode(.alwaysOriginal),
                                      tag: 0)
        
        let vc4 = MeVC()
        vc4.tabBarItem = UITabBarItem(title: "我的",
                                      image: UIImage("me")?.withRenderingMode(.alwaysOriginal),
                                      tag: 0)
        
        setViewControllers([vc1, vc2, vc3, vc4], animated: true)
    }
    
}

