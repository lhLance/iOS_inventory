//
//  LoginRegsVC.swift
//  Fii
//
//  Created by Liu Tao on 2019/3/11.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

let VIDEO_HEIGHT = (UIScreen.width * 2178) / 1006

class LoginRegsVC: UIViewController {

    var playerView = FiiPlayerView()
    var playerLayer: AVPlayerLayer?
    var player: AVPlayer?
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
        
        setupPlayerView()
        setupButtons()
    }
    
    func setupPlayerView() {
        
        guard let path = Bundle.main.path(forResource: "video", ofType: ".mp4") else { return }
        
        let url = URL(fileURLWithPath: path)
        
        playerItem = AVPlayerItem(url: url)
        // 监听缓冲进度改变
        playerItem?.addObserver(self, forKeyPath: "loadedTimeRanges", options: .new, context: nil)
        // 监听状态改变
        playerItem?.addObserver(self, forKeyPath: "status", options: .new, context: nil)
        player = AVPlayer(playerItem: playerItem)
        player?.automaticallyWaitsToMinimizeStalling = false
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.videoGravity = AVLayerVideoGravity.resizeAspect
        playerLayer?.contentsScale = UIScreen.main.scale
        playerView.playerLayer = self.playerLayer
        playerView.layer.insertSublayer(playerLayer!, at: 0)
        
        playerView.frame = CGRect(x: 0, y: 0, width: UIScreen.width, height: VIDEO_HEIGHT)
        playerView.added(into: view)
        playerView.backgroundColor = UIColor.white
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playToEndTime),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: player?.currentItem)
        
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
    }
    
    func setupButtons() {
        
        loginBtn = UIButton("登录", UIColor.white, UIFont.PFMedium(16))
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
        
        registerBtn = UIButton("注册", UIColor.white, UIFont.PFMedium(16))
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
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func registerBtnTapped() {
        print("register btn tapped...")
        
        let vc = RegisterVC()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}

extension LoginRegsVC {
    
    @objc func playToEndTime() {
        print("播放完成, 重新播放")
        self.player?.seek(to: CMTime.zero)
        self.player?.play()
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
                self.player?.play()
            } else {
                print("加载异常")
            }
        }
    }
}
