//
//  RealtimePlayerVC.swift
//  Fii
//
//  Created by Thomas Lau on 2019/4/28.
//  Copyright © 2019 Ye Tao. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class RealtimePlayerVC: UIViewController {

    let urlStr = "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"
    var playerView = FiiPlayerView()
    var playerLayer: AVPlayerLayer?
    var player: AVPlayer?
    var playerItem: AVPlayerItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupPlayer()
    }
    
    func setupPlayer() {
        
        guard let url = URL(string: urlStr) else { fatalError("连接错误") }
        
        playerItem = AVPlayerItem(url: url)
        // 监听缓冲进度改变
        playerItem?.addObserver(self, forKeyPath: "loadedTimeRanges", options: .new, context: nil)
        // 监听状态改变
        playerItem?.addObserver(self, forKeyPath: "status", options: .new, context: nil)
        player = AVPlayer(playerItem: playerItem)
        player?.isMuted = false
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.videoGravity = AVLayerVideoGravity.resizeAspect
        playerLayer?.contentsScale = UIScreen.main.scale
        playerView.playerLayer = self.playerLayer
        playerView.layer.insertSublayer(playerLayer!, at: 0)
        
        playerView.frame = CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        view.addSubview(playerView)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playToEndTime),
                                               name: .AVPlayerItemDidPlayToEndTime,
                                               object: player?.currentItem)
    }
    
    @objc func playToEndTime(notify: NSNotification) {
        print("播放完成")
        self.player?.seek(to: CMTime.zero)
        self.player?.play()
    }
    
    deinit {
        playerItem?.removeObserver(self, forKeyPath: "loadedTimeRanges")
        playerItem?.removeObserver(self, forKeyPath: "status")
    }
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?)
    {
        guard let playerItem = object as? AVPlayerItem else { return }
        
        if keyPath == "loadedTimeRanges"{
            print("mmm") // 缓冲进度 暂时不处理
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
