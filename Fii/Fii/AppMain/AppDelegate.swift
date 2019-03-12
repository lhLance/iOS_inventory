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

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        let vc1 = HomeVC()
        let vc2 = MeVC()
        let vc3 = DeviceListVC()
        let vc4 = VoiceControllVC()
        let vc5 = RealTimeVC()
        
        let childVCs = [
            createTabbarChildVC(vc: vc1,
                                title: "首页",
                                normalImage: UIImage("home")!,
                                selectImage: UIImage("home")!,
                                tag: 0),
            createTabbarChildVC(vc: vc2,
                                title: "实时快照",
                                normalImage: UIImage("screen_shot")!,
                                selectImage: UIImage("screen_shot")!,
                                tag: 0),
            createTabbarChildVC(vc: vc3,
                                title: "语音",
                                normalImage: UIImage("voice")!,
                                selectImage: UIImage("voice")!,
                                tag: 0),
            createTabbarChildVC(vc: vc4,
                                title: "设备数据",
                                normalImage: UIImage("device_data")!,
                                selectImage: UIImage("device_data")!,
                                tag: 0),
            createTabbarChildVC(vc: vc5, title: "我的",
                                normalImage: UIImage.init("me")!,
                                selectImage: UIImage.init("me")!,
                                tag: 0)
        ]
        
        let rootVC = FiiTabBarController(childVCs)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        
        // 开屏图停留
        _ = Thread.sleep(forTimeInterval: 1.0)
        
        return true
    }
    
    func createTabbarChildVC(vc: UIViewController,
                             title: String,
                             normalImage: UIImage,
                             selectImage: UIImage,
                             tag: Int) -> UIViewController
    {
        let item = UITabBarItem.init(title: title,
                                     image: normalImage.withRenderingMode(.alwaysOriginal),
                                     tag: tag)
        item.selectedImage = selectImage.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem = item
        
        return UINavigationController(rootViewController: vc)
    }

}

