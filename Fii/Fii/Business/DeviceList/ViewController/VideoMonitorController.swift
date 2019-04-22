//
//  VideoMonitorController.swift
//  Fii
//
//  Created by yetao on 2019/4/9.
//  Copyright © 2019 Liu Tao. All rights reserved.
//

import UIKit

private let margin_x:CGFloat = 10.0
private let titleColor = colorWithRGBA(red: 55, green: 86, blue: 169, alpha: 1.0)
/**
 选中label的背景颜色（默认灰色）
 */
private let  selectedViewColor: UIColor? = colorWithRGBA(red: 235, green: 235, blue: 235, alpha: 1.0)
/**
 未选中label的背景颜色（默认白色）
 */
private let normalLabelColor: UIColor? = colorWithRGBA(red: 255, green: 255, blue: 255, alpha: 1.0)

/**
 未选中label字体颜色（默认白色）
 */
private let normalLabelTextColor: UIColor? = colorWithRGBA(red: 55, green: 86, blue: 169, alpha: 1.0)
/**
 未选中label字体颜色（默认白色）
 */
private let selectedLabelTextColor: UIColor? = colorWithRGBA(red: 255, green: 255, blue: 255, alpha: 1.0)


class VideoMonitorController: UIViewController {
//    var progressV:YTProgressLineView!
    @IBOutlet weak var navControlBtn: UIButton!
    @IBOutlet weak var monitorControlBtn: UIButton!
    @IBOutlet weak var controlV: UIView!
    var videoCV:VideoControlView? = nil
    var navCV:NavControlView? = nil
    let dataArray:[String]! = ["1","2","3","4","5"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.frame = UIScreen.main.bounds   // 增加这一句 即可
        self.view.backgroundColor = colorWithRGBA(red: 237, green: 237, blue: 242, alpha: 1.0)
        
        setUpNavAndMonitorUI()
//        setupUI()
        
//

        
    }

    func setUpNavAndMonitorUI()
    {
        navCV = NavControlView(frame: CGRect(x: 0, y: navControlBtn.frame.maxY, width: controlV.width  , height: controlV.height - navControlBtn.frame.maxY), dataAry: dataArray)
        navCV!.backgroundColor = UIColor.magenta
        navCV!.added(into: controlV)
        
        navControlBtn.setBackgroundColor(selectedViewColor!, for: UIControl.State.normal)
        monitorControlBtn.setBackgroundColor(normalLabelColor!, for: UIControl.State.normal)
        navControlBtn.setTitleColor(selectedLabelTextColor, for: UIControl.State.normal)
        monitorControlBtn.setTitleColor(normalLabelTextColor, for: UIControl.State.normal)
        
        navCV?.isHidden = false
    }
    
    
    @IBAction func navControlBtnPressend(_ sender: UIButton)
    {
        if navCV == nil{
            
        }
        navCV?.isHidden = false
        videoCV?.isHidden = true
        
        navControlBtn.setBackgroundColor(selectedViewColor!, for: UIControl.State.normal)
        monitorControlBtn.setBackgroundColor(normalLabelColor!, for: UIControl.State.normal)
        navControlBtn.setTitleColor(selectedLabelTextColor, for: UIControl.State.normal)
        monitorControlBtn.setTitleColor(normalLabelTextColor, for: UIControl.State.normal)
    }
    @IBAction func monitorControlBtnPressend(_ sender: UIButton) {
        
        if videoCV == nil{
            videoCV = VideoControlView(frame: CGRect(x: 0, y: navControlBtn.frame.maxY, width: controlV.width  , height: controlV.height - navControlBtn.frame.maxY), dataAry: dataArray)
            videoCV!.backgroundColor = UIColor.magenta
            videoCV!.added(into: controlV)
        }
        videoCV?.isHidden = false
        navCV?.isHidden = true
        
        monitorControlBtn.setBackgroundColor(selectedViewColor!, for: UIControl.State.normal)
        navControlBtn.setBackgroundColor(normalLabelColor!, for: UIControl.State.normal)
        monitorControlBtn.setTitleColor(selectedLabelTextColor, for: UIControl.State.normal)
        navControlBtn.setTitleColor(normalLabelTextColor, for: UIControl.State.normal)
    }
    
}


extension VideoMonitorController{
    
    
    
    
}


