//
//  UIImageView-SquareBorder.swift
//  Fii
//
//  Created by yetao on 2019/3/27.
//  Copyright © 2019 Liu Tao. All rights reserved.
//

import UIKit
public enum SquareBorder{
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
}



extension UIImageView{
    
    convenience init(frame: CGRect,imageName:String, direct:SquareBorder) {
        self.init(imageName);
        self.frame = frame;
        switch direct {
        case .topLeft:
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        case .topRight:
            self.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        case .bottomLeft:
            self.transform = CGAffineTransform(scaleX: 1.0, y: -1.0)
        case .bottomRight:
            self.transform = CGAffineTransform(scaleX: -1.0, y: -1.0)
        }
    }
    
    
}
