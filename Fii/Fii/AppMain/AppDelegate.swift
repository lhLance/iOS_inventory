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
    var rootVC: FiiTabBarController?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        setupLanguage()
        setupVCs()
        
        return true
    }
    
    func setupLanguage() {
        
        LanguageHelper.shareInstance.initUserLanguage()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadData),
                                               name: NSNotification.Name(rawValue: "LanguageChanged"),
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func reloadData() {
        
        setupVCs()
        
        if let rootVC = rootVC {
            
            rootVC.selectedIndex = 4
            
            let meVC = rootVC.selectedViewController as! UINavigationController
            let vc = SettingsVC()
            meVC.pushViewController(vc, animated: true)
        }
    }
    
    func setupVCs() {
        
        let homeVC = HomeVC()
        let meVC = MeVC()
        let deviceListVC = DeviceListVC()
        let voiceConVC = VoiceControllVC()
        let realVC = RealTimeVC()
        
        let childVCs = [
            createTabbarChildVC(vc: homeVC,
                                title: LanguageHelper.getString(key: "home_title"),
                                normalImage: UIImage("home_none")!,
                                selectImage: UIImage("home")!,
                                tag: 0),
            createTabbarChildVC(vc: realVC,
                                title: LanguageHelper.getString(key: "real_time_shot_title"),
                                normalImage: UIImage("screen_shot_none")!,
                                selectImage: UIImage("screen_shot")!,
                                tag: 0),
            createTabbarChildVC(vc: voiceConVC,
                                title: LanguageHelper.getString(key: "voice_title"),
                                normalImage: UIImage("voice_none")!,
                                selectImage: UIImage("voice")!,
                                tag: 0),
            createTabbarChildVC(vc: deviceListVC,
                                title: LanguageHelper.getString(key: "device_list_title"),
                                normalImage: UIImage("device_data_none")!,
                                selectImage: UIImage("device_data")!,
                                tag: 0),
            createTabbarChildVC(vc: meVC, title: LanguageHelper.getString(key: "me_title"),
                                normalImage: UIImage("me_none")!,
                                selectImage: UIImage("me")!,
                                tag: 0)
        ]
        
        rootVC = FiiTabBarController(childVCs)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        
        // 开屏图停留
        _ = Thread.sleep(forTimeInterval: 0.0)
        
        // rsetupOpenScreenView(vc: rootVC ?? FiiTabBarController())
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
        vc.title = title
        
        let navCon = FiiNavgationController(rootViewController: vc)
        if vc.isKind(of: RealTimeVC.self) {
            navCon.setNavBarColor(UIColor.hex(0x242426))
            navCon.setTextColor(UIColor.white)
        }
        return navCon
    }
    
    func setupOpenScreenView(vc: UIViewController) {
        
        let opView = OpenScreenView()
        
        UIWindow.keyWindow?.addSubview(opView)
        opView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        opView.count = 4
        opView.skipBtnTap = {
            opView.removeFromSuperview()
            
            let subVC = LoginRegsVC()
            let navSubVC = UINavigationController(rootViewController: subVC)
            vc.present(navSubVC, animated: true, completion: nil)
        }
    }

}

