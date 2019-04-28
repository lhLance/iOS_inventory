//
//  VoiceCurveSwiftView.swift
//  Fii
//
//  Created by yetao on 2019/3/30.
//  Copyright © 2019 Liu Tao. All rights reserved.
//

import UIKit

//class VoiceCurveSwiftView: UIView {
//    var superView:UIView?
//    var recordSettings:NSDictionary?
//    var recorder:AVAudioRecorder?
//    var displayLink:CADisplayLink?
//    var blurView:UIVisualEffectView?
//
//    var  layer1:CAShapeLayer? 
//    var  layer2:CAShapeLayer? 
//    var  layer3:CAShapeLayer? 
//    var  layer4:CAShapeLayer? 
//    var  layer5:CAShapeLayer? 
//
//    init(frame: CGRect,superV:UIView) {
//        super.init(frame: frame)
//        superView = superV
//        setUp()
//        self.added(into: superView!)
//
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//
//
//
//}
//
//extension VoiceCurveSwiftView{
//
//    private func setUp(){
//
//        setAudioProperties()
//        self.backgroundColor = UIColor.clear
//        blurView = UIVisualEffectView.init(effect: UIBlurEffect(style: UIBlurEffect.Style.dark))
//        blurView?.frame = self.frame
//        let tagGes = UITapGestureRecognizer(target: self, action: #selector(dismiss))
//        blurView?.addGestureRecognizer(tagGes)
//        blurView?.alpha = 0.0
//        blurView?.tag = 101
//        blurView?.added(into: self)
//
//        //layer1
//        layer1 = CAShapeLayer()
//        layer1?.fillColor = UIColor.yellow.cgColor 
//        layer1?.opacity = 0.7
//        blurView?.layer.addSublayer(layer1!)
//
//        //layer2
//        layer2 = CAShapeLayer()
//        layer2?.fillColor = UIColor.magenta.cgColor 
//        layer2?.opacity = 0.7
//        blurView?.layer.addSublayer(layer2!)
//
//        //layer3
//        layer3 = CAShapeLayer()
//        layer3?.fillColor = UIColor.orange.cgColor 
//        layer3?.opacity = 0.7
//        blurView?.layer.addSublayer(layer3!)
//
//        //layer4
//        layer4 = CAShapeLayer()
//        layer4?.fillColor = UIColor.red.cgColor 
//        layer4?.opacity = 0.7
//        blurView?.layer.addSublayer(layer4!)
//
//        //layer5
//        layer5 = CAShapeLayer()
//        layer5?.fillColor = colorWithRGBA(red: 0, green: 184, blue: 255, alpha: 1).cgColor 
//        layer5?.opacity = 0.7
//        blurView?.layer.addSublayer(layer5!)
//
//        //the label -- 正在聆听
//        let listeningLabel = UILabel() 
//        listeningLabel.frame = CGRect(x: UIScreen.width/2 - 320/2, y: 100, width: 320, height: 30)
//        listeningLabel.textAlignment = NSTextAlignment.center
//        listeningLabel.font = UIFont.PFRegular(30)
//        listeningLabel.textColor = UIColor.white
//        listeningLabel.text = "正在聆听..."
//        listeningLabel.addSubview((blurView?.contentView)!)
//
//    }
//
//    private func setAudioProperties(){
//        recordSettings = [
//            AVFormatIDKey : kAudioFormatLinearPCM,
//            AVEncoderBitRateKey:16,
//            AVEncoderAudioQualityKey : AVAudioQuality.max,
//            AVSampleRateKey : 8000.0,
//            AVNumberOfChannelsKey : 1]
//
//        if (recorder == nil) {
//            return 
//        }
//
//        if (recorder?.isRecording)!{
//            return
//        }
//
//        let audioSession:AVAudioSession = AVAudioSession.sharedInstance()
//        do {
//            if #available(iOS 10.0, *) {
//                try audioSession.setCategory(.playAndRecord, mode: .default)
//            } else {
//                // Fallback on earlier versions
//            }
//            try audioSession.setActive(true)
//        } catch {
//            print(error)
//        }
//        let url:NSURL = NSURL(fileURLWithPath: fullPathAtCache(flieName:"record.wav")!) 
//        let existedData:NSData?
//        do{
//            try existedData = NSData(contentsOf: url as URL, options: NSData.ReadingOptions.mappedRead)
//            if (existedData != nil){
//                let tempFm:FileManager = FileManager.default
//                do{
//                    try tempFm.removeItem(atPath: url.path!)
//                }catch{
//                    print(error) 
//                }
//            }
//        }catch{
//            print(error) 
//        }
//        do{
//            try recorder = AVAudioRecorder.init(url: url as URL, settings: recordSettings as! [String : Any])
//            recorder?.isMeteringEnabled = true
//            recorder?.delegate = (self as AVAudioRecorderDelegate)
//            recorder?.record() 
//            recorder?.prepareToRecord() 
//        }catch{
//
//        }
//        displayLink = CADisplayLink(target: self, selector: #selector(drawRealTimeCurve(dis:)))
//        displayLink?.add(to: RunLoop.main, forMode: RunLoop.Mode.common)
//    }
//
//
//    @objc func drawRealTimeCurve(dis:CADisplayLink){
//        recorder?.updateMeters() 
//        print("volume:\(String(describing: recorder?.averagePower(forChannel:0)))")
//        //------重绘函数-------
//        let volume:CGFloat =  CGFloat((recorder?.averagePower(forChannel: 0))!)
//        let controlY1:CGFloat = UIScreen.height - (volume+60)
//        let controlY2:CGFloat = UIScreen.height - ((volume+60) + 10) * 1.5
//        let controlY3:CGFloat = UIScreen.height - ((volume+60) + 15) * 2.3
//        let controlY4:CGFloat = UIScreen.height - ((volume+60) + 12) * 5
//        let controlY5:CGFloat = UIScreen.height - ((volume+60) + 5) * 1.5
//
//        layer1?.path = createBezierPathWithStartPoint(startPoint: CGPoint(30, UIScreen.height),
//                                                      endPoint: CGPoint(UIScreen.width/2-10, UIScreen.height),
//                                                      controlPoint: CGPoint((UIScreen.width/2-10-30)/2+30, controlY1)).cgPath
//        layer2?.path = createBezierPathWithStartPoint(startPoint: CGPoint(50, UIScreen.height),
//                                                      endPoint: CGPoint(UIScreen.width*5/8, UIScreen.height),
//                                                      controlPoint: CGPoint((UIScreen.width*5/8)/2+35, controlY2)).cgPath
//        layer3?.path = createBezierPathWithStartPoint(startPoint: CGPoint( (UIScreen.width/2-10-30)/2+30, UIScreen.height),
//                                                      endPoint: CGPoint((UIScreen.width-20-UIScreen.width*5/8)/2+UIScreen.width*5/8, UIScreen.height),
//                                                      controlPoint: CGPoint(((UIScreen.width-20-UIScreen.width*5/8)/2+UIScreen.width*5/8-20-((UIScreen.width/2-10-30)/2+30))/2+(UIScreen.width/2-10-30)/2+30,controlY3)).cgPath
//        layer4?.path = createBezierPathWithStartPoint(startPoint: CGPoint((UIScreen.width/2)-20, UIScreen.height),
//                                                      endPoint: CGPoint(UIScreen.width*7/8, UIScreen.height),
//                                                      controlPoint:CGPoint((UIScreen.width*7/8-UIScreen.width/2+20)/2+UIScreen.width/2-20, controlY4)).cgPath
//        layer5?.path = createBezierPathWithStartPoint(startPoint: CGPoint(UIScreen.width*5/8-20, UIScreen.height),
//                                                      endPoint: CGPoint(UIScreen.width-20, UIScreen.height),
//                                                      controlPoint:CGPoint((UIScreen.width-20-(UIScreen.width*5/8-20))/2+UIScreen.width*5/8-20, controlY5)).cgPath
//
//    }
//
//    private func fullPathAtCache(flieName:String)->String?{
//        let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
//        let fm:FileManager = FileManager.default 
//        if !fm.fileExists(atPath: path!)
//        {
//            do{
//            try fm.createDirectory(atPath: path!, withIntermediateDirectories: true, attributes: nil)
//            }
//            catch{
//                print(error)
//            }
//        }
//        return path?.appending(flieName)
//    }
//
//
//
//
//}
//
////-------------根据返回音量返回实时的曲线----------------------
//extension VoiceCurveSwiftView:AVAudioRecorderDelegate{
//
//    private func createBezierPathWithStartPoint(startPoint:CGPoint,endPoint:CGPoint,controlPoint:CGPoint) -> UIBezierPath{
//        let BezierPath = UIBezierPath()
//        BezierPath.move(to: startPoint)
//        BezierPath.addQuadCurve(to: endPoint, controlPoint: controlPoint)
//        return BezierPath
//    }
//
//    func present(){
//
//        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0,
//                       options:UIView.AnimationOptions(rawValue: UIView.KeyframeAnimationOptions.beginFromCurrentState.rawValue|UIView.KeyframeAnimationOptions.allowUserInteraction.rawValue|UIView.KeyframeAnimationOptions.calculationModeLinear.rawValue) ,
//                       animations: {
//                        let bv = self.superView?.viewWithTag(101)
//                        bv?.alpha = 1.0
//        }, completion: nil)
//
//
//
//    }
//
//    @objc private func dismiss(){
//
//
//
//        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0,
//                                options: UIView.AnimationOptions(rawValue: UIView.KeyframeAnimationOptions.beginFromCurrentState.rawValue|UIView.KeyframeAnimationOptions.allowUserInteraction.rawValue|UIView.KeyframeAnimationOptions.calculationModeLinear.rawValue),
//                                animations: {
//            let bv = self.superView?.viewWithTag(101)
//            bv?.alpha = 0
//        }) { (true) in
//            self.removeFromSuperview()
//            self.displayLink?.invalidate()
//            self.displayLink = nil 
//        }
//    }
//
//
//
//
//
//}



