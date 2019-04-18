//
//  VideoMonitorController.swift
//  Fii
//
//  Created by yetao on 2019/4/9.
//  Copyright © 2019 Liu Tao. All rights reserved.
//

import UIKit

class VideoMonitorController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.frame = UIScreen.main.bounds   // 增加这一句 即可

        let gradientLayer0 = CAGradientLayer()
        gradientLayer0.cornerRadius = 10
        gradientLayer0.frame = self.view.bounds
        gradientLayer0.colors = [
            UIColor(red: 51.0 / 255.0, green: 87.0 / 255.0, blue: 171.0 / 255.0, alpha: 1.0).cgColor,
            UIColor(red: 212.0 / 255.0, green: 22.0 / 255.0, blue: 62.0 / 255.0, alpha: 1.0).cgColor]
        gradientLayer0.locations = [0, 1]
        gradientLayer0.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer0.endPoint = CGPoint(x: 1, y: 1)
        self.view.layer.addSublayer(gradientLayer0)
        
        setupUI()
    }



}

extension VideoMonitorController{
    
    func setupUI()
    {

        var height: CGFloat = 64 + 20
        var titleArray = ["倍速调整","关闭光圈","焦点调整"]
        for i in 0..<titleArray.count {
            //1-5分别为 圆形五个按钮，单个圆形按钮，圆角按钮，竖加减，横加减
            let buttonView = MonitorShapeButton(frame: CGRect(x: 0, y: 50, width: 50, height: 50), buttonType: ButtonTypeVPlusAndMin)
            buttonView.addTarget(self, action: #selector(self.buttonClick(_:)), forResponseState: ButtonClickTypeTouchUpInside)
            buttonView.addTarget(self, action: #selector(self.longPressButtonClick(_:)), forResponseState: ButtonClickTypeLongPress)
            view.addSubview(buttonView)
            
            var center = CGPoint.zero
            var image: UIImage?
            switch i {
            case 0:
                //  圆形五个按钮 上下左右 中心
                center = CGPoint(x: view.frame.midX - 100, y:  buttonView.frame.height / 2 + height)
            case 1:
                //  单个圆形按钮  只响应 SelectButtonPosition_Center
                center = CGPoint(x: view.frame.midX , y:  buttonView.frame.height / 2 + height)
            case 2:
                // 圆角按钮 只响应 SelectButtonPosition_Center
                center = CGPoint(x: view.frame.midX + 100, y:  buttonView.frame.height / 2 + height)
            default: break
                
            }
            if image != nil {
                
                buttonView.image = image
            }
            buttonView.setTitle(titleArray[i])
            buttonView.center = center
            buttonView.tag = i
            if i == titleArray.count - 1{
                height = buttonView.frame.maxY + 30
            }
        }

        
        titleArray = ["OK"]
        for i in 0..<1 {
            //1-5分别为 圆形五个按钮，单个圆形按钮，圆角按钮，竖加减，横加减
            let buttonView = MonitorShapeButton(frame: CGRect(x: 0, y: 50, width: 50, height: 50), buttonType: ButtonType(rawValue: UInt32(i)))
            buttonView.addTarget(self, action: #selector(self.buttonClick(_:)), forResponseState: ButtonClickTypeTouchUpInside)
            buttonView.addTarget(self, action: #selector(self.longPressButtonClick(_:)), forResponseState: ButtonClickTypeLongPress)
            view.addSubview(buttonView)
            
            var center = CGPoint.zero
            var image: UIImage?
            switch i {
            case 0:
                //  圆形五个按钮 上下左右 中心
                center = CGPoint(x: view.frame.midX, y: height + buttonView.frame.height / 2)
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
        
        
        var string: String? = nil
        if let tag = button?.tag {
            string = String(format: "单击事件,按钮 tag 值 ‘%zd’  点击位置 ‘%@’", tag, getSelectPartString(withButtonView: button)!)
        }
        // 建立一個提示框
        let alertController = UIAlertController(
            title: "提示",
            message: string!,
            preferredStyle: .alert)
        // 建立[確認]按鈕
        let okAction = UIAlertAction(
            title: "确定",
            style: .default,
            handler: {
                (action: UIAlertAction!) -> Void in
                
        })
        alertController.addAction(okAction)
        // 顯示提示框
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    @objc func longPressButtonClick(_ button: MonitorShapeButton?) {
        
        
        var string: String? = nil
        if let tag = button?.tag {
            string = String(format: "长按事件,按钮 tag 值 ‘%zd’  点击位置 ‘%@’", tag, getSelectPartString(withButtonView: button)!)
        }
        // 建立一個提示框
        let alertController = UIAlertController(
            title: "提示",
            message: string!,
            preferredStyle: .alert)
        // 建立[確認]按鈕
        let okAction = UIAlertAction(
            title: "确定",
            style: .default,
            handler: {
                (action: UIAlertAction!) -> Void in
                
        })
        alertController.addAction(okAction)
        // 顯示提示框
        self.present(alertController, animated: true, completion: nil)
        
        
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


/*
extension VideoMonitorController{
    
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

