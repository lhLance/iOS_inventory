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

class LoginRegsVC: UIViewController {

    var playerView = FiiPlayerView()
    var playerLayer: AVPlayerLayer?
    var player: AVPlayer?
    var playerItem: AVPlayerItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupPlayerView()
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
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.videoGravity = AVLayerVideoGravity.resizeAspect
        playerLayer?.contentsScale = UIScreen.main.scale
        playerView.playerLayer = self.playerLayer
        playerView.layer.insertSublayer(playerLayer!, at: 0)
        
        playerView.frame = CGRect(x: 0, y: 0, width: UIScreen.width, height: UIScreen.height)
        playerView.added(into: view)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playToEndTime),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: player?.currentItem)
    }
    
    deinit {
        playerItem?.removeObserver(self, forKeyPath: "loadedTimeRanges")
        playerItem?.removeObserver(self, forKeyPath: "status")
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
