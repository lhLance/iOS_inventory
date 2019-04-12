//
//  FiiDashBoardView.swift
//  Fii
//
//  Created by Liu Tao on 2019/4/11.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func CG_COLOR(颜色数组 values : Array<CGFloat>) -> CGColor {
        let r = values[0]
        let g = values[1]
        let b = values[2]
        let a = values[3]
        
        return UIColor(red: r, green: g, blue: b, alpha: a).cgColor
    }
}

class FiiDashBoardView: UIView {
    
    var value: CGFloat? {
        didSet {
            print("sender.value = \(String(describing: value))")
            progressLater?.strokeEnd = value ?? 0
            drawNeedle(progressValue: value ?? 0)
            displayShowLabel(sliderP: value ?? 0)
        }
    }
    
    var progressLater : CAShapeLayer?
    var aLabel : UILabel?
    var isContaint : Bool?
    var needleLayer : CAShapeLayer?
    
    let theStartAngle = -(CGFloat)(1.25 * Double.pi)
    let theEndAngle = CGFloat(0.25 * Double.pi)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    func setupView() {
        
        backgroundColor = UIColor.green
        
        isContaint = false
        drawProgressLayer()
        drawGradientLayer()
        drawScale()
    }
    
    //根据半径画圆
    func drawCurve(Radius r : CGFloat) -> CAShapeLayer {
        
        print("center = \(self.center)")
        let path = UIBezierPath(arcCenter: CGPoint.init(x: self.frame.width / 2, y: self.frame.height / 2),
                                radius: r,
                                startAngle: theStartAngle,
                                endAngle: theEndAngle,
                                clockwise: true)
        let curve = CAShapeLayer()
        curve.lineWidth = 2.5
        curve.fillColor = UIColor.clear.cgColor
        curve.strokeColor = UIColor.white.cgColor
        curve.path = path.cgPath
        
        return curve
    }
    
    //进度图层
    func drawProgressLayer() {
        
        let outArc = drawCurve(Radius: 150)
        let intArc = drawCurve(Radius: 110)
        self.layer.addSublayer(outArc)
        self.layer.addSublayer(intArc)
        
        let progressPath = UIBezierPath(arcCenter: CGPoint.init(x: self.frame.width / 2, y: self.frame.height / 2),
                                        radius: 130,
                                        startAngle: theStartAngle,
                                        endAngle: theEndAngle,
                                        clockwise: true)
        progressLater = CAShapeLayer()
        progressLater?.lineWidth = 38.0
        progressLater?.fillColor = UIColor.clear.cgColor
        progressLater?.strokeColor = UIColor.white.cgColor
        progressLater?.strokeStart = 0
        progressLater?.strokeEnd = 0.5
        progressLater?.path = progressPath.cgPath
        self.layer.addSublayer(progressLater!)
    }
    
    //渐变图层
    func drawGradientLayer() {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor.CG_COLOR(颜色数组: [0.96, 0.08, 0.10, 1.00]),
                                UIColor.CG_COLOR(颜色数组: [0.97, 0.65, 0.22, 1.00]),
                                UIColor.CG_COLOR(颜色数组: [0.60, 0.82, 0.22, 1.00]),
                                UIColor.CG_COLOR(颜色数组: [0.20, 0.63, 0.25, 1.00]),
                                UIColor.CG_COLOR(颜色数组: [0.09, 0.58, 0.15, 1.00])]
        gradientLayer.locations = [0, 0.25, 0.5, 0.75, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0, y:0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.mask = progressLater
        self.layer.addSublayer(gradientLayer)
    }
    
    //刻度
    func drawScale() {
        
        let perAngle : CGFloat = CGFloat(1.5 * Double.pi) / 50
        let calWidth : CGFloat = perAngle / 5
        
        for i in 0...50 {
            
            let startAngel = theStartAngle + perAngle * CGFloat(i)
            let endAngel = startAngel + calWidth
            let tickPath = UIBezierPath.init(arcCenter: CGPoint.init(x: self.frame.width / 2, y: self.frame.height / 2),
                                             radius: 140,
                                             startAngle: startAngel,
                                             endAngle: endAngel,
                                             clockwise: true)
            let perLayer = CAShapeLayer()
            if i % 5 == 0 {
                
                perLayer.strokeColor = UIColor.white.cgColor
                perLayer.lineWidth = 10.0
                let point = calculateTextPosition(center: CGPoint.init(x: self.frame.width / 2, y: self.frame.height / 2), angle: -startAngel)
                let calibrationLabel = UILabel(frame: CGRect(x: point.x - 10, y: point.y - 10, width: 20, height: 20))
                calibrationLabel.text = String(format: "%d", i * 2)
                calibrationLabel.font = UIFont.systemFont(ofSize: 10)
                calibrationLabel.textColor = UIColor.white
                calibrationLabel.textAlignment = .center
                self.addSubview(calibrationLabel)
            } else {
                
                perLayer.strokeColor = UIColor.CG_COLOR(颜色数组: [0.22, 0.66, 0.87, 1.0])
                perLayer.lineWidth = 5
            }
            
            perLayer.path = tickPath.cgPath
            self.layer.addSublayer(perLayer)
        }
        needleLayer = CAShapeLayer()
        needleLayer?.fillColor = UIColor.white.cgColor
        needleLayer?.lineWidth = 1.0
        needleLayer?.strokeColor = UIColor.clear.cgColor
        self.layer.addSublayer(needleLayer!)
        showDataLabel()
        drawNeedle(progressValue: 0.5)
    }
    
    func drawNeedle(progressValue value: CGFloat) {
        
        let centerCircle = UIBezierPath(arcCenter: CGPoint.init(x: self.frame.width / 2, y: self.frame.height / 2),
                                        radius: 20,
                                        startAngle: CGFloat(0.25 * Double.pi),
                                        endAngle: CGFloat(0.75 * Double.pi),
                                        clockwise: false)
        let centerCircleLayer = CAShapeLayer()
        centerCircleLayer.strokeColor = UIColor.white.cgColor
        centerCircleLayer.lineWidth = 3.0
        centerCircleLayer.path = centerCircle.cgPath
        centerCircleLayer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(centerCircleLayer)
        
        let angel = CGFloat(1.5 * Double.pi) * (0.8333333333 - value)
        let leewayX : CGFloat = CGFloat(2 * sinf(Float(angel)))
        
        var leewayY : CGFloat = CGFloat(2 * cosf(Float(angel)))
        
        if (value <= 0.05) || (value >= 0.95) {
            leewayY = 1
        }
        
        let startPX = CGFloat(25 * cosf(Float(angel))) + self.frame.width / 2
        let startPY = CGFloat(-25 * sinf(Float(angel))) + self.frame.height / 2
        let startPX1 = startPX - leewayX
        let startPX2 = startPX + leewayX
        let startPY1 = startPY - leewayY
        let startPY2 = startPY + leewayY
        let endPX = CGFloat(130 * cosf(Float(angel))) + self.frame.width / 2
        let endPY = CGFloat(-130 * sinf(Float(angel))) + self.frame.height / 2
        let needlePath = UIBezierPath()
        
        needlePath.move(to: CGPoint(x: startPX1, y: startPY1))
        needlePath.addLine(to: CGPoint(x: endPX, y: endPY))
        needlePath.addLine(to: CGPoint(x: startPX2, y: startPY2))
        needleLayer?.path = needlePath.cgPath
    }
    
    //计算label位置
    func calculateTextPosition(center: CGPoint,
                               angle: CGFloat) -> CGPoint
    {
        let calRadius: Float = 125.0
        let x = calRadius * cosf(Float(angle))
        let y = calRadius * sinf(Float(angle))
        
        return CGPoint(x: CGFloat(x) + center.x, y: -CGFloat(y) + center.y)
    }
    
    func showDataLabel() {
        
        aLabel = UILabel(frame: CGRect(x: 0,
                                       y: self.frame.height / 2 + 20,
                                       width: self.frame.size.width,
                                       height: 50))
        aLabel?.textColor = UIColor.white
        aLabel?.text = "0"
        aLabel?.font = UIFont.boldSystemFont(ofSize: 35)
        aLabel?.textAlignment = .center
        self.addSubview(aLabel!)
        
        displayShowLabel(sliderP: 0.5)
    }
    
    func displayShowLabel(sliderP progress: CGFloat) {
        
        let numberS: String = String(format: "%.1f", progress * 100) + "%"
        aLabel?.text = numberS
    }
}
