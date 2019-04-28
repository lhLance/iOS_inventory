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
private let  selectedViewColor: UIColor? = colorWithRGBA(red: 194, green: 194, blue: 200, alpha: 1.0)
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
    lazy var navControlBtn: UIButton! = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.red
        btn.addTarget(self, action: #selector(navControlBtnPressend), for: UIControl.Event.touchUpInside)
        return btn
    }()
    lazy var monitorControlBtn: UIButton! = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.green
        btn.addTarget(self, action: #selector(monitorControlBtnPressend), for: UIControl.Event.touchUpInside)
        return btn
    }()
    lazy var controlV: UIView = {
        let controlV = UIView()
        controlV.backgroundColor = UIColor.white
        controlV.layer.masksToBounds = true
        controlV.layer.cornerRadius = 10.0
        controlV.layer.borderWidth = 0.5
        controlV.layer.borderColor = colorWithRGBA(red: 196, green: 196, blue: 196, alpha: 1.0).cgColor
        return controlV
    }()
   lazy var videoCV:VideoControlView? = {
    let videoCV = VideoControlView(frame: CGRect.zero , dataAry: dataArray)
    return videoCV
    }()
   lazy var navCV:NavControlView? = {
        let navCV = NavControlView(frame: CGRect.zero, dataAry: dataArray)
        return navCV
    }()
    let dataArray:[String]! = ["1","2","3","4","5"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = colorWithRGBA(red: 237, green: 237, blue: 242, alpha: 1.0)
        setBackVUpUI()
        setUpNavAndMonitorUI()
        

        
    }

 
    

}


extension VideoMonitorController{

    func setBackVUpUI(){
        controlV.added(into: view)
        controlV.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(11)
            make.bottom.equalTo(-11)
        }

        navControlBtn.added(into: controlV)
        navControlBtn.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.height.equalTo(40)
            make.top.equalTo(0)
            make.width.equalToSuperview().dividedBy(2)/*视图宽度为父视图的一半*/
        }
            
        monitorControlBtn.added(into: controlV)
        monitorControlBtn.snp.makeConstraints { (make) in
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(navControlBtn)
            make.width.equalTo(navControlBtn)

        }
        
        let lineV = UIView()
        lineV.backgroundColor = colorWithRGBA(red: 235, green: 235, blue: 235, alpha: 1.0)
        lineV.added(into: controlV)
        lineV.snp.makeConstraints { (make) in
            make.right.equalTo(0)
            make.top.equalTo(monitorControlBtn.snp.bottom).offset(-1)
            make.height.equalTo(1)
            make.left.equalTo(0)
        }
        
    }
    
    func setUpNavAndMonitorUI()
    {
        navCV!.added(into: controlV)
        navCV?.snp.makeConstraints({ (make) in
            make.top.equalTo(navControlBtn.snp.bottom).offset(0)
            make.right.equalTo(0)
            make.left.equalTo(0)
            make.bottom.equalTo(0)
        })
        
        videoCV?.added(into: controlV)
        videoCV?.snp.makeConstraints({ (make) in
            make.top.equalTo(navControlBtn.snp.bottom).offset(0)
            make.right.equalTo(0)
            make.left.equalTo(0)
            make.bottom.equalTo(0)
        })
        
        navCV?.isHidden = false
        videoCV?.isHidden = true

        navControlBtn.setTitle(LanguageHelper.getString(key: "machine_Navigation_console"), for: UIControl.State.normal)
        monitorControlBtn.setTitle(LanguageHelper.getString(key: "machine_Monitoring_console"), for: UIControl.State.normal)

        navControlBtn.setBackgroundColor(selectedViewColor!, for: UIControl.State.normal)
        monitorControlBtn.setBackgroundColor(normalLabelColor!, for: UIControl.State.normal)
        navControlBtn.setTitleColor(selectedLabelTextColor, for: UIControl.State.normal)
        monitorControlBtn.setTitleColor(normalLabelTextColor, for: UIControl.State.normal)
        
    }
    
    
    @objc func navControlBtnPressend(_ sender: UIButton)
    {
        navCV?.isHidden = false
        videoCV?.isHidden = true
        
        navControlBtn.setBackgroundColor(selectedViewColor!, for: UIControl.State.normal)
        monitorControlBtn.setBackgroundColor(normalLabelColor!, for: UIControl.State.normal)
        navControlBtn.setTitleColor(selectedLabelTextColor, for: UIControl.State.normal)
        monitorControlBtn.setTitleColor(normalLabelTextColor, for: UIControl.State.normal)
    }
    @objc func monitorControlBtnPressend(_ sender: UIButton)
    {

        videoCV?.isHidden = false
        navCV?.isHidden = true
        
        monitorControlBtn.setBackgroundColor(selectedViewColor!, for: UIControl.State.normal)
        navControlBtn.setBackgroundColor(normalLabelColor!, for: UIControl.State.normal)
        monitorControlBtn.setTitleColor(selectedLabelTextColor, for: UIControl.State.normal)
        navControlBtn.setTitleColor(normalLabelTextColor, for: UIControl.State.normal)
    }
    

}


