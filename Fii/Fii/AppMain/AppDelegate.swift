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
        let homeVC = LoginRegsVC()//HomeVC()
        let meVC = MeVC()
        let deviceListVC = DeviceListVC()
        let voiceConVC = VoiceControllVC()
        let realVC = RealTimeVC()
        
        let childVCs = [
            createTabbarChildVC(vc: homeVC,
                                title: "首页",
                                normalImage: UIImage("home")!,
                                selectImage: UIImage("home")!,
                                tag: 0),
            createTabbarChildVC(vc: realVC,
                                title: "实时快照",
                                normalImage: UIImage("screen_shot")!,
                                selectImage: UIImage("screen_shot")!,
                                tag: 0),
            createTabbarChildVC(vc: deviceListVC,
                                title: "语音",
                                normalImage: UIImage("voice")!,
                                selectImage: UIImage("voice")!,
                                tag: 0),
            createTabbarChildVC(vc: voiceConVC,
                                title: "设备数据",
                                normalImage: UIImage("device_data")!,
                                selectImage: UIImage("device_data")!,
                                tag: 0),
            createTabbarChildVC(vc: meVC, title: "我的",
                                normalImage: UIImage("me")!,
                                selectImage: UIImage("me")!,
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

