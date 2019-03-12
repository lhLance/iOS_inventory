//
//  FiiPlayerView.swift
//  Fii
//
//  Created by Liu Tao on 2019/3/12.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import UIKit
import AVKit

class FiiPlayerView: UIView {

    var playerLayer: AVPlayerLayer?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        playerLayer?.frame = self.bounds
    }

}
