//
//  AppDelegate.swift
//  Fii
//
//  Created by Liu Tao on 2019/2/25.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: MainViewController.shared)
        
        // 开屏图停留
        _ = Thread.sleep(forTimeInterval: 1.0)
        
        return true
    }

}

