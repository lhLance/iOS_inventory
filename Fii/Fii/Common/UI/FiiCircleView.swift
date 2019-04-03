//
//  FiiCircleView.swift
//  Fii
//
//  Created by Thomas Lau on 2019/4/3.
//  Copyright © 2019 Liu Tao. All rights reserved.
//

import UIKit

class FiiCircleView: UIView {
    
    var progress = Float(0) {
        didSet {
            progressLayer.strokeEnd = CGFloat(progress)
        }
    }
    
    var strokeColor = UIColor.hex(0xE94444) {
        didSet {
            progressLayer.strokeColor = strokeColor.cgColor
        }
    }
    
    var backColor = UIColor.hex(0xCECECE) {
        didSet {
            backgroundLayer.strokeColor = backColor.cgColor
        }
    }
    
    private let progressLayer = CAShapeLayer()
    private let backgroundLayer = CAShapeLayer()
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initView()
    }
    
    private func initView() {
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.strokeColor = UIColor.hex(0xCECECE).cgColor
        backgroundLayer.strokeStart = 0.0
        backgroundLayer.lineWidth = 6.0
        backgroundLayer.lineCap = CAShapeLayerLineCap.round
        layer.addSublayer(backgroundLayer)
        
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = strokeColor.cgColor
        progressLayer.lineWidth = 6.0
        progressLayer.lineCap = CAShapeLayerLineCap.square
        layer.addSublayer(progressLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let bezierPath = UIBezierPath(
            arcCenter: CGPoint(x: width/2, y: height/2),
            radius: width/2,
            startAngle: -CGFloat.pi * 3 / 2,
            endAngle: CGFloat.pi / 2, clockwise: true
        )
        
        progressLayer.path = bezierPath.cgPath
        progressLayer.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        backgroundLayer.path = bezierPath.cgPath
        backgroundLayer.frame = CGRect(x: 0, y: 0, width: width, height: height)
    }
    
}
