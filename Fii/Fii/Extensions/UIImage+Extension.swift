//
//  UIImage+Extension.swift
//  MVVMDemo
//
//  Created by Liu Tao on 2018/12/3.
//  Copyright © 2018年 Liu Tao. All rights reserved.
//

import UIKit

extension UIImage {
    
    /// 绘制导航栏渐变色背景
    static func drawNavBarImg(colorTop: UIColor, colorBottom: UIColor) -> UIImage {
        
        let height: CGFloat = UIDevice.isPhoneXorMore ? 88 : 64
        let rect = CGRect(x: 0, y: 0, width: 100, height: height)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        let ctx = UIGraphicsGetCurrentContext()!
        let colorSpace = CGColorSpace.init(name: CGColorSpace.sRGB)
        let colors = [colorTop.cgColor,
                      colorBottom.cgColor]
        let gradient = CGGradient.init(colorsSpace: colorSpace, colors: colors as CFArray, locations: nil)
        ctx.drawLinearGradient(gradient!,
                               start: CGPoint.init(x: 0, y: 0),
                               end: CGPoint.init(x: 0, y: height),
                               options: .drawsAfterEndLocation)
        let img = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return img
    }
    
    static func drawLeftToRightImg(colorLeft: UIColor, colorRight: UIColor ,size:CGSize) -> UIImage {
        
        let height: CGFloat = UIDevice.isPhoneXorMore ? 88 : 64
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        let ctx = UIGraphicsGetCurrentContext()!
        let colorSpace = CGColorSpace.init(name: CGColorSpace.sRGB)
        let colors = [colorLeft.cgColor,
                      colorRight.cgColor]
        let gradient = CGGradient.init(colorsSpace: colorSpace, colors: colors as CFArray, locations: nil)
        ctx.drawLinearGradient(gradient!,
                               start: CGPoint.init(x: 0, y: 0),
                               end: CGPoint.init(x: size.width, y: size.height),
                               options: .drawsAfterEndLocation)
        let img = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return img
    }
    
    
    /// 根据颜色生成图片
    static func createImgForColor(_ color: UIColor, rect: CGRect = CGRect.init(x: 0, y: 0, width: 1, height: 1)) -> UIImage {
        let rect = rect
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        let ctx = UIGraphicsGetCurrentContext()!
        color.setFill()
        ctx.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return img
    }
    
    /// 重设图片大小
    func resizeImage(size: CGSize, fromY: CGFloat) -> UIImage {

        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        self.draw(in: CGRect(x: 0, y: 480, width: size.width, height: size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? UIImage()
    }
    
    /// 裁剪边框
    func clipRect(_ rect: CGRect) -> UIImage? {
        
        guard let cgImg = self.cgImage else { return nil }
        guard let part = cgImg.cropping(to: rect) else { return nil }
        
        let newImage = UIImage(cgImage: part)
        
        return newImage
    }
}

extension UIImage{
    convenience init(view: UIView) {
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: false)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage)!)
        
    }
}


extension UIImage {
    
    ///用颜色创建一张图片
    static func createImageWithColor(color:UIColor) -> UIImage {
        
        let rect:CGRect = CGRect.init(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        
        UIGraphicsBeginImageContext(rect.size)
        
        let context:CGContext = UIGraphicsGetCurrentContext()!
        
        context.setFillColor(color.cgColor)
        
        context.fill(rect)
        
        let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        return image
    }
    //拉伸一张图片
    static func resizebleImage(imageName:String) -> UIImage {
        
        var imageNor = UIImage.init(named: imageName)
        
        let w = imageNor?.size.width
        
        let h = imageNor?.size.height
        
        imageNor = imageNor?.resizableImage(withCapInsets: UIEdgeInsets(top: w! * 0.5, left: h! * 0.5, bottom: w! * 0.5, right: h! * 0.5), resizingMode: UIImage.ResizingMode.stretch)
        
        return imageNor!
    }
    
    //gif图片解析
    static func animationImageWithData(data:NSData?) -> UIImage {
        
        if data != nil {
            
            let source:CGImageSource = CGImageSourceCreateWithData(data!, nil)!
            
            let count:size_t = CGImageSourceGetCount(source)
            
            var animatedImage:UIImage?
            
            if count <= 1 {
                
                animatedImage = UIImage.init(data: data! as Data)
                
            }else {
                
                var images = [UIImage]()
                
                var duration:TimeInterval = 0.0;
                
                for i:size_t in size_t(0.0) ..< count {
                    
                    let image:CGImage? = CGImageSourceCreateImageAtIndex(source, i, nil)!
                    
                    if image == nil {
                        
                        continue
                    }
                    duration = TimeInterval(frameDuration(index: i, source: source)) + duration;
                    
                    images.append(UIImage.init(cgImage: image!))
                }
                if (duration == 0.0) {
                    
                    duration = Double(1.0 / 10.0) * Double(count);
                }
                animatedImage = UIImage.animatedImage(with: images, duration: 2.0);
            }
            
            return animatedImage!
        }else {
            
            return UIImage()
        }
        
    }
    
    static func frameDuration(index:Int,source:CGImageSource) -> Float {
        
        
        var frameDuration:Float = 0.1;
        
        let cfFrameProperties:CFDictionary = CGImageSourceCopyPropertiesAtIndex(source, index, nil)!
        
        let frameProperties:NSDictionary = cfFrameProperties as CFDictionary
        
        let gifProperties:NSDictionary = frameProperties.object(forKey: kCGImagePropertyGIFDictionary as NSString) as! NSDictionary
        
        let delayTimeUnclampedProp:NSNumber? = gifProperties.object(forKey: kCGImagePropertyGIFUnclampedDelayTime as NSString) as? NSNumber
        
        if delayTimeUnclampedProp != nil {
            
            frameDuration = (delayTimeUnclampedProp?.floatValue)!
        }else {
            
            let delayTimeProp:NSNumber? = gifProperties.object(forKey: kCGImagePropertyGIFDelayTime as NSString) as? NSNumber
            
            if delayTimeProp != nil {
                
                frameDuration = (delayTimeProp?.floatValue)!
            }
            
            if frameDuration < 0.011{
                
                frameDuration = 0.100;
            }
        }
        return frameDuration
    }
}

