//
//  UIColor+Extension.swift
//  MVVMDemo
//
//  Created by Liu Tao on 2018/12/3.
//  Copyright © 2018年 Liu Tao. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func hex(_ rgb: UInt, _ alpha: CGFloat = 1.0) -> UIColor {
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let greed = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat((rgb & 0x0000FF)) / 255.0
        
        return UIColor.init(red: red, green: greed, blue: blue, alpha: alpha)
    }
    
    static var random: UIColor {
        
        let red = CGFloat(arc4random() % 256) / 255.0
        let green = CGFloat(arc4random() % 256) / 255.0
        let blue = CGFloat(arc4random() % 256) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    func alpha(_ value: CGFloat) -> UIColor {
        return self.withAlphaComponent(value)
    }
}

private func colorValue(_ value : CGFloat) -> CGFloat {
    return value / 255.0
}

func colorWithRGBA(red : CGFloat,green : CGFloat ,blue : CGFloat,alpha : CGFloat) -> UIColor{
    
    return UIColor(red: colorValue(red), green: colorValue(green), blue: colorValue(blue), alpha: alpha)
}

//MARK:- 从颜色中获取rgb值
extension UIColor{
    func getRGBValue() -> (CGFloat, CGFloat, CGFloat) {
        guard let cmps = cgColor.components else {
            fatalError("重大错误，请确定颜色为rgb形式！！！")
        }
        return (cmps[0] / 255.0 , cmps[1] / 255.0, cmps[2] / 255.0)
    }
    //hex（16进制）
    
    convenience init(r:CGFloat ,g:CGFloat ,b:CGFloat ,a: CGFloat = 1.0) {
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    convenience init?(hexString: String) {
        // ## # 0x 0X
        //1.判断字符串长度是否大于等于6
        guard hexString.count >= 6 else {
            return nil
        }
        //2.将字符串全部转成大写
        var hexTempString = hexString.uppercased()
        //3.判断前缀是否是“##”或者“0X”
        if hexTempString.hasPrefix("##") || hexTempString.hasPrefix("0X") {
            hexTempString = (hexTempString as NSString).substring(from: 2)
            
        }
        //4.判断前缀是否是“#”
        if hexTempString.hasPrefix("#") {
            hexTempString = (hexTempString as NSString).substring(from: 1)
        }
        
        //5.获取rgb对应的 16进制(r:FF ,g:00 ,b:22)
        var range = NSRange(location: 0, length: 2)
        let rHex = (hexTempString as NSString).substring(with: range)
        range.location = 2
        let gHex = (hexTempString as NSString).substring(with: range)
        range.location = 4
        let bHex = (hexTempString as NSString).substring(with: range)
        
        //6.将16进制转成数值FF 22
        var r : UInt32 = 0
        var g : UInt32 = 0
        var b : UInt32 = 0
        Scanner(string: rHex).scanHexInt32(&r)
        Scanner(string: gHex).scanHexInt32(&g)
        Scanner(string: bHex).scanHexInt32(&b)
        
        self.init(r: CGFloat(r), g: CGFloat(g), b: CGFloat(b))
        
    }
}
