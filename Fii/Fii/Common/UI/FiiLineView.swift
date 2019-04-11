//
//  FiiLineView.swift
//  Fii
//
//  Created by Thomas Lau on 2019/4/11.
//  Copyright © 2019 Liu Tao. All rights reserved.
//

import UIKit

class FiiLineView: UIView {
    
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
    
    var lineWidth = CGFloat(6.0) {
        didSet {
            backgroundLayer.lineWidth = lineWidth
            progressLayer.lineWidth = lineWidth
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
        progressLayer.lineCap = CAShapeLayerLineCap.round
        layer.addSublayer(progressLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(0, 0))
        linePath.addLine(to: CGPoint(width, 0))
        linePath.lineWidth = height
        
        progressLayer.path = linePath.cgPath
        progressLayer.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        backgroundLayer.path = linePath.cgPath
        backgroundLayer.frame = CGRect(x: 0, y: 0, width: width, height: height)
    }
    
}
