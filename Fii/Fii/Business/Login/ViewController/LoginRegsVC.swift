//
//  LoginRegsVC.swift
//  Fii
//
//  Created by Liu Tao on 2019/3/11.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import UIKit
import AVKit

let VIDEO_HEIGHT = (UIScreen.width * 2178) / 1006

class LoginRegsVC: UIViewController {

    var avPlayer: AVPlayer!
    var playerItem: AVPlayerItem?
    
    var loginBtn: UIButton?
    var registerBtn: UIButton?
    var discriptionLabel = UILabel()
    
    let descriptionArr = ["6+ 全自动无人自主熄灯工厂",
                          "11+ 覆盖国家",
                          "2000000+ 员工",
                          "3300+ 研发专利",
                          "40000+ 技术人才"]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
        
        displayTitle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    func setupView() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData),
                                               name: NSNotification.Name(rawValue: "LanguageChanged"),
                                               object: nil)
        
        setupPlayerView()
        setupButtons()
    }
    
    @objc func reloadData() {
        
        loginBtn?.Text(LanguageHelper.getString(key: "Account_login"))
        registerBtn?.Text(LanguageHelper.getString(key: "Account_register"))
    }
    
    func setupPlayerView() {
        
        guard let filePath = Bundle.main.path(forResource: "aaa", ofType: ".mp4") else { return }
        let url = URL(fileURLWithPath: filePath)
        
        playerItem = AVPlayerItem(url: url)
        // 监听缓冲进度改变
        playerItem?.addObserver(self, forKeyPath: "loadedTimeRanges", options: .new, context: nil)
        // 监听状态改变
        playerItem?.addObserver(self, forKeyPath: "status", options: .new, context: nil)
        avPlayer = AVPlayer(playerItem: playerItem)
        if #available(iOS 10.0, *) {
            avPlayer.automaticallyWaitsToMinimizeStalling = false
        } else {
            // Fallback on earlier versions
        }
        
        let avPlayerController = AVPlayerViewController()
        avPlayerController.player = avPlayer
        avPlayerController.showsPlaybackControls = false
        avPlayerController.view.frame = CGRect(x: 0, y: 0, width: UIScreen.width, height: VIDEO_HEIGHT)
        
        avPlayerController.player?.play()
        view.addSubview(avPlayerController.view)
        addChild(avPlayerController)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playToEndTime),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: avPlayer.currentItem)
        
        discriptionLabel.TextAlignment(.center).TextColor(UIColor.white).Font(UIFont.PFRegular(22))
        discriptionLabel.added(into: view)
        discriptionLabel.snp.makeConstraints({ (make) in
            make.center.equalToSuperview()
            make.height.equalTo(60)
            make.width.equalToSuperview()
        })
    }
    
    func displayTitle() {
        
        UIView.animate(withDuration: 2.0, animations: {
            self.discriptionLabel.Text(self.descriptionArr[0])
        }) { (bool) in
            if bool {
                UIView.animate(withDuration: 2.0, animations: {
                    self.discriptionLabel.Text(self.descriptionArr[1])
                }, completion: { (bool) in
                    if bool {
                        UIView.animate(withDuration: 2.0, animations: {
                            self.discriptionLabel.Text(self.descriptionArr[2])
                        }, completion: { (bool) in
                            if bool {
                                UIView.animate(withDuration: 2.0, animations: {
                                    self.discriptionLabel.Text(self.descriptionArr[3])
                                }, completion: { (bool) in
                                    if bool {
                                        UIView.animate(withDuration: 2.0, animations: {
                                            self.discriptionLabel.Text(self.descriptionArr[4])
                                        }, completion: { bool in
                                            self.displayTitle()
                                        } )
                                    }
                                })
                            }
                        })
                    }
                })
            }
        }
    }
    
    deinit {
        playerItem?.removeObserver(self, forKeyPath: "loadedTimeRanges")
        playerItem?.removeObserver(self, forKeyPath: "status")
        
        NotificationCenter.default.removeObserver(self)
    }
    
    func setupButtons() {
        
        loginBtn = UIButton(LanguageHelper.getString(key: "Account_login"), UIColor.white, UIFont.PFMedium(16))
        loginBtn?.cornerRadius = 4.0
        loginBtn?.backgroundColor = UIColor.hex(0x0099F1)
        loginBtn?.addTarget(self, action: #selector(loginBtnTapped), for: .touchUpInside)
        loginBtn?.added(into: view)
        loginBtn?.snp.makeConstraints({ (make) in
            make.width.equalTo(130)
            make.height.equalTo(45)
            make.bottom.equalTo(-30)
            make.right.equalTo(-40)
        })
        
        registerBtn = UIButton(LanguageHelper.getString(key: "Account_register"), UIColor.white, UIFont.PFMedium(16))
        registerBtn?.cornerRadius = 4.0
        registerBtn?.backgroundColor = UIColor.hex(0x0099F1)
        registerBtn?.addTarget(self, action: #selector(registerBtnTapped), for: .touchUpInside)
        registerBtn?.added(into: view)
        registerBtn?.snp.makeConstraints({ (make) in
            make.width.equalTo(130)
            make.height.equalTo(45)
            make.bottom.equalTo(-30)
            make.left.equalTo(40)
        })
        
    }
    
    @objc func loginBtnTapped() {
        print("login btn tapped...")
        let vc = LoginVC()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func registerBtnTapped() {
        print("register btn tapped...")
        
        let vc = RegisterVC()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    

}

extension LoginRegsVC {
    
    @objc func playToEndTime() {
        print("播放完成, 重新播放")
        avPlayer.seek(to: CMTime.zero)
        avPlayer.play()
    }
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?)
    {
        guard let playerItem = object as? AVPlayerItem else { return }
        
        if keyPath == "loadedTimeRanges"{
            // 缓冲进度 暂时不处理
        } else if keyPath == "status" {
            // 监听状态改变
            if playerItem.status == AVPlayerItem.Status.readyToPlay {
                // 只有在这个状态下才能播放
                avPlayer.play()
            } else {
                print("加载异常")
            }
        }
    }
}
