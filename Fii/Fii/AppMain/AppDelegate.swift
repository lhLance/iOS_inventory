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

        setupVCs()
        // setupOpenScreenView(vc: rootVC)
        setupRongCloud()
        
        return true
    }
    
    func setupRongCloud() {
        
        RCIMClient.shared()?.initWithAppKey(SDK_Constant.RongCloudAppkey)
        RongCloudAPI.getToken(userId: SDK_Constant.UserID,
                              name: SDK_Constant.UserName,
                              portraitUri: SDK_Constant.Uri) { model in
                                
                                if let token = model.token {
                                    print("model.token = \(token)")
                                    RCIMClient.shared()?.connect(withToken: token, success: { (userId) in
                                        print("登录成功，当前登录的用户ID: \(String(describing: userId))")
                                    }, error: { (status) in
                                        print("登录的错误码为\(status)")
                                    }, tokenIncorrect: {
                                        print("token 错误")
                                    })
                                }
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
                                title: "首页",
                                normalImage: UIImage("home_none")!,
                                selectImage: UIImage("home")!,
                                tag: 0),
            createTabbarChildVC(vc: realVC,
                                title: "实时快照",
                                normalImage: UIImage("screen_shot_none")!,
                                selectImage: UIImage("screen_shot")!,
                                tag: 0),
            createTabbarChildVC(vc: voiceConVC,
                                title: "语音",
                                normalImage: UIImage("voice_none")!,
                                selectImage: UIImage("voice")!,
                                tag: 0),
            createTabbarChildVC(vc: deviceListVC,
                                title: "设备数据",
                                normalImage: UIImage("device_data_none")!,
                                selectImage: UIImage("device_data")!,
                                tag: 0),
            createTabbarChildVC(vc: meVC, title: "我的",
                                normalImage: UIImage("me_none")!,
                                selectImage: UIImage("me")!,
                                tag: 0)
        ]
        
        let rootVC = FiiTabBarController(childVCs)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        
        // 开屏图停留
        _ = Thread.sleep(forTimeInterval: 0.0)
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

