//
//  NavControlView.swift
//  Fii
//
//  Created by yetao on 2019/4/22.
//  Copyright © 2019 Ye Tao. All rights reserved.
//


private let margin_x:CGFloat = 10.0

import UIKit

class NavControlView: UIView {

    var  dataArray:[String]! = ["1","2","3","4","5"]
    var myframe:CGRect = CGRect.zero
    public let btn_height:CGFloat = 66
    public let progressOrigit_h:CGFloat = 33
    let margin_x:CGFloat = 5
    let buttonW:CGFloat = 33
    public let titleColor = colorWithRGBA(red: 55, green: 86, blue: 169, alpha: 1.0)

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    init(frame: CGRect ,dataAry:[String]) {
        
        super.init(frame: frame)
        self.dataArray = dataAry
        
//        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
            setupUI()
    }
    
}


extension NavControlView{
    
   @objc public func setupUI()
    {
        progressView()
        var titleArray  = [" "]
        for i in 0..<1 {
            //            1-5分别为 圆形五个按钮，单个圆形按钮，圆角按钮，竖加减，横加减
            let buttonView = MonitorShapeButton(frame: CGRect(x: 0, y: 50, width: 50, height: 50), buttonType: ButtonType(rawValue: UInt32(i)))
            buttonView.addTarget(self, action: #selector(self.buttonClick(_:)), forResponseState: ButtonClickTypeTouchUpInside)
            buttonView.addTarget(self, action: #selector(self.longPressButtonClick(_:)), forResponseState: ButtonClickTypeLongPress)
            self.addSubview(buttonView)
            
            var center = CGPoint.zero
            var image: UIImage?
            switch i {
            case 0:
                //  圆形五个按钮 上下左右 中心
                center = CGPoint(x: self.frame.midX, y: self.height - buttonView.frame.height / 2 - 45)
            default: break
                
            }
            if image != nil {
                
                buttonView.image = image
            }
            buttonView.setTitle(titleArray[i])
            buttonView.center = center
            buttonView.tag = i
        }
        
    }
    
    
    
    
    @objc func buttonClick(_ button: MonitorShapeButton?) {
        
        print("单击事件,按钮 tag 值 ‘%zd’  点击位置 ‘%@’", tag, getSelectPartString(withButtonView: button)!)
        
//        var string: String? = nil
//        if let tag = button?.tag {
//            string = String(format: "单击事件,按钮 tag 值 ‘%zd’  点击位置 ‘%@’", tag, getSelectPartString(withButtonView: button)!)
//        }
//        // 建立一個提示框
//        let alertController = UIAlertController(
//            title: "提示",
//            message: string!,
//            preferredStyle: .alert)
//        // 建立[確認]按鈕
//        let okAction = UIAlertAction(
//            title: "确定",
//            style: .default,
//            handler: {
//                (action: UIAlertAction!) -> Void in
//
//        })
//        alertController.addAction(okAction)
//        // 顯示提示框
//        self.present(alertController, animated: true, completion: nil)
        
    }
    
    @objc func longPressButtonClick(_ button: MonitorShapeButton?) {
        
        print("\(#file) ----\(#function) 单击事件,按钮 tag 值 ‘%zd’  点击位置 ‘%@’", tag, getSelectPartString(withButtonView: button)!)

//        var string: String? = nil
//        if let tag = button?.tag {
//            string = String(format: "长按事件,按钮 tag 值 ‘%zd’  点击位置 ‘%@’", tag, getSelectPartString(withButtonView: button)!)
//        }
//        // 建立一個提示框
//        let alertController = UIAlertController(
//            title: "提示",
//            message: string!,
//            preferredStyle: .alert)
//        // 建立[確認]按鈕
//        let okAction = UIAlertAction(
//            title: "确定",
//            style: .default,
//            handler: {
//                (action: UIAlertAction!) -> Void in
//                
//        })
//        alertController.addAction(okAction)
//        // 顯示提示框
//        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    func getSelectPartString(withButtonView button: MonitorShapeButton?) -> String? {
        var partString: String = ""
        switch button?.selectButtonPosition {
        case SelectButtonPositionTop?:
            partString = "上"
        case SelectButtonPositionButtom?:
            partString = "下"
        case SelectButtonPositionCenter?:
            partString = "中"
        case SelectButtonPositionLeft?:
            partString = "左"
        case SelectButtonPositionRight?:
            partString = "右"
        default:
            break
        }
        return partString
    }
}

extension NavControlView:YTSegmentControlDelegate{
    
    func progressView(){
        
        
        var titleAry:[String] = ["光圈","倍速","焦点"]

        
        for i in 0..<titleAry.count
        {
            let progressOrigitH = progressOrigit_h + btn_height * CGFloat(i)
            let label = UILabel()
            label.frame = CGRect(x:margin_x + 10.0, y: progressOrigitH, width: 40, height: 33)
            label.text = titleAry[i]
            label.FontColor(UIFont.PFRegular(14), titleColor).TextAlignment(.center)
//            label.added(into: self)
            self.addSubview(label)
            
            
            if i == 0
            {
                let itles  = [" ", " "]
                let selegmentV = YTSegmentControl(frame: CGRect(x: label.frame.maxX + margin_x, y: progressOrigitH, width: self.frame.size.width - label.frame.maxX - 20 - margin_x*2, height: 33), titles: itles)
                selegmentV.delegate = self as YTSegmentControlDelegate
                selegmentV.added(into: self)
            }
            else
            {
                let progressV = YTProgressLineView.init(frame: CGRect.init(x: label.frame.maxX + margin_x, y: progressOrigitH, width: self.frame.size.width - label.frame.maxX*2 - buttonW*2, height: 33), dataArr: dataArray)
                progressV.tag = 100+i
                self.addSubview(progressV)
                
                let preStepBtn = UIButton()
                preStepBtn.tag = 200+i
                preStepBtn.setBackgroundImage(UIImage(named: "virtual_btn_jian"), for: UIControl.State.normal)
                preStepBtn.frame = CGRect(x: progressV.frame.maxX + 15, y: progressOrigitH, width: buttonW, height: 33)
                preStepBtn.addTarget(self, action: #selector(preStep), for: .touchUpInside);
                self.addSubview(preStepBtn)
                
                let nextStepBtn = UIButton()
                nextStepBtn.tag = 300+i
                nextStepBtn.setBackgroundImage(UIImage(named: "virtual_btn_yinliangjia"), for: UIControl.State.normal)
                nextStepBtn.frame = CGRect(x: preStepBtn.frame.maxX + 10, y: progressOrigitH, width: buttonW, height: 33)
                nextStepBtn.addTarget(self, action: #selector(nextStep), for: .touchUpInside);
                self.addSubview(nextStepBtn)
            }
        }
        
        
    }
    
    
    
    //1、没有标签的进度条 上一步
    @objc func preStep(_ sender: UIButton) {
        
        let tag = sender.tag - 100;
        let progressV:YTProgressLineView = self.TagView(tag)  as! YTProgressLineView
        guard progressV.index! >  0  else {
            return
        }
        progressV.index = progressV.index - 1
    }
    
    //1、没有标签的进度条 下一步
    @objc func nextStep(_ sender: UIButton)
    {
        let tag = sender.tag - 200;
        let progressV:YTProgressLineView = self.TagView(tag)  as! YTProgressLineView
        guard  progressV.index! < self.dataArray.count else {
            return
        }
        progressV.index = progressV.index + 1
    }
    
    //    func setUpYtSelegement(){
    //        let itles  = [" ", " "]
    //        let test = YTSegmentControl(frame: CGRect(x: 5, y: 150, width: view.frame.size.width - 5, height: 30), titles: itles)
    //        test.delegate = self as YTSegmentControlDelegate
    //        view.addSubview(test)
    //    }
    
    func ytsegmentedControl(_ control: YTSegmentControl?, didSeletRow row: Int) {
        print("点击是:\(row)")
    }
    
}


/*
 extension VideoMonitorController{
 
 
 func setAdd(){
 //        let buttonView = MonitorShapeButton(frame: CGRect(x: progressV.frame.maxX, y: 100, width: 100, height: 50), buttonType: ButtonType(rawValue: UInt32(4)))
 //        buttonView.addTarget(self, action: #selector(self.buttonClick(_:)), forResponseState: ButtonClickTypeTouchUpInside)
 //        buttonView.addTarget(self, action: #selector(self.longPressButtonClick(_:)), forResponseState: ButtonClickTypeLongPress)
 //        view.addSubview(buttonView)
 //        var image: UIImage?
 //        if image != nil {
 //            buttonView.image = image
 //        }
 //        buttonView.setTitle("")
 //        buttonView.tag = 4
 
 
 //        let label = UILabel().then({ (lab) in
 //            lab.FontColor(UIFont.PFRegular(14), titleColor).TextAlignment(.center)
 //            lab.added(into: view)
 //            lab.snp.makeConstraints({ (make) in
 //                make.left.equalTo(view.snp_leftMargin).offset(5)
 //                make.centerY.equalTo(progressV.centerY)
 //                make.width.equalTo(40)
 //                make.height.equalTo(30)
 //            })
 //        })
 
 
 let img =  UIImage.drawLeftToRightImg(colorLeft: UIColor(red: 51.0 / 255.0, green: 87.0 / 255.0, blue: 171.0 / 255.0, alpha: 1.0), colorRight: UIColor(red: 212.0 / 255.0, green: 22.0 / 255.0, blue: 62.0 / 255.0, alpha: 1.0), size: CGSize(width: 40, height: 40))
 
 }
 
 
 func setupUI()
 {
 
 var titleArray = ["OK", "", "", "音量", "音量"]
 var height: CGFloat = 64 + 20
 
 for i in 0..<5 {
 //1-5分别为 圆形五个按钮，单个圆形按钮，圆角按钮，竖加减，横加减
 let buttonView = MonitorShapeButton(frame: CGRect(x: 0, y: 150, width: 50, height: 50), buttonType: ButtonType(rawValue: UInt32(i)))
 buttonView.addTarget(self, action: #selector(self.buttonClick(_:)), forResponseState: ButtonClickType.touchUpInside)
 buttonView.addTarget(self, action: #selector(self.longPressButtonClick(_:)), forResponseState: ButtonClickType.longPress)
 view.addSubview(buttonView)
 
 var center = CGPoint.zero
 var image: UIImage?
 switch i {
 case 0:
 //  圆形五个按钮 上下左右 中心
 center = CGPoint(x: view.frame.midX, y: height + buttonView.frame.height / 2)
 case 1:
 //  单个圆形按钮  只响应 SelectButtonPosition_Center
 image = UIImage(named: "virtual_control_switch")
 center = CGPoint(x: view.frame.midX / 2.0, y: height + image!.size.width / 2)
 case 2:
 // 圆角按钮 只响应 SelectButtonPosition_Center
 image = UIImage(named: "virtual_control_number")
 center = CGPoint(x: view.frame.midX / 2.0, y: height + image!.size.height / 2)
 case 3:
 // 竖加减  只响应 SelectButtonPosition_Buttom  SelectButtonPosition_Top，
 center = CGPoint(x: view.frame.midX / 2.0 * 3, y: height - buttonView.frame.height / 2 - 30)
 case 4:
 // 横加减   只响应 SelectButtonPosition_Right  SelectButtonPosition_Left，
 center = CGPoint(x: view.frame.midX, y: height + buttonView.frame.height / 2)
 
 default: break
 
 }
 if image != nil {
 
 buttonView.image = image
 }
 buttonView.titleLabel.text = titleArray[i]
 buttonView.center = center
 buttonView.tag = i
 height = buttonView.frame.maxY + 30
 }
 }
 
 @objc func buttonClick(_ button: MonitorShapeButton?) {
 
 
 var string: String? = nil
 if let tag = button?.tag {
 string = String(format: "单击事件,按钮 tag 值 ‘%zd’  点击位置 ‘%@’", tag, getSelectPartString(withButtonView: button)!)
 }
 let alert = UIAlertView(title: "提示", message: string!, delegate: nil, cancelButtonTitle: "确定", otherButtonTitles: "")
 alert.show()
 
 
 }
 
 @objc func longPressButtonClick(_ button: MonitorShapeButton?) {
 
 
 var string: String? = nil
 if let tag = button?.tag {
 string = String(format: "长按事件,按钮 tag 值 ‘%zd’  点击位置 ‘%@’", tag, getSelectPartString(withButtonView: button)!)
 }
 let alert = UIAlertView(title: "提示", message: string!, delegate: nil, cancelButtonTitle: "确定", otherButtonTitles: "")
 alert.show()
 
 
 }
 
 func getSelectPartString(withButtonView button: MonitorShapeButton?) -> String? {
 var partString: String = ""
 switch button?.selectButtonPosition{
 case .top?:
 partString = "上"
 case .buttom?:
 partString = "下"
 case .center?:
 partString = "中"
 case .left?:
 partString = "左"
 case .right?:
 partString = "右"
 default:
 break
 }
 return partString
 }
 
 }
 */

