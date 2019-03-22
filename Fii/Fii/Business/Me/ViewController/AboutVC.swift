//
//  AboutVC.swift
//  Fii
//
//  Created by Liu Tao on 2019/3/19.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {

    var titleImg: UIImageView?
    var titleLabl: UILabel?
    var titleBtn: UIButton?
    var middleText: UILabel?
    var bussinessTitle: UILabel?
    var bussinessLine: UIView?
    var bussinessNO: UILabel?
    var bussinessFax: UILabel?
    var companyName: UILabel?
    var bottomLbl: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    func setupView() {
        
        view.backgroundColor = UIColor.white
        
        titleImg = UIImageView().then({ (img) in
            img.added(into: view)
            img.backgroundColor = UIColor.red
            img.snp.makeConstraints({ (make) in
                make.width.height.equalTo(90)
                make.centerX.equalToSuperview()
                make.top.equalTo(UIScreen.navBarHeight + 50)
            })
            img.cornerRadius = 45
            img.ImageName("Icon")
        })
        
        titleLabl = UILabel().then({ (lbl) in
            lbl.added(into: view)
            lbl.TextFont("Fii v1.0.0", UIFont.MILanTing(16)).TextColor(UIColor.lightGray).TextAlignment(.center)
            lbl.snp.makeConstraints({ (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(titleImg?.snp.bottom ?? 0).offset(5)
                make.height.equalTo(12)
            })
        })
        
        titleBtn = UIButton().then({ (b) in
            b.added(into: view)
            b.snp.makeConstraints({ (make) in
                make.width.equalTo(0.7 * UIScreen.width)
                make.height.equalTo(40)
                make.centerX.equalToSuperview()
                make.top.equalTo(titleLabl?.snp.bottom ?? 0).offset(30)
            })
            b.borderColor = UIColor.red
            b.borderWidth = 1.0
            b.cornerRadius = 20
            b.Text("兼善天下企业，赋能全球制造").TitleColor(UIColor.red).Font(UIFont.MILanTing(16))
        })
        
        middleText = UILabel().then({ (m) in
            m.added(into: view)
            m.snp.makeConstraints({ (make) in
                make.top.equalTo(titleBtn?.snp.bottom ?? 0).offset(25)
                make.width.equalTo(0.7 * UIScreen.width)
                make.height.equalTo(120)
                make.centerX.equalToSuperview()
            })
            m.TextColor(UIColor.lightGray).Text("公司是全球领先的通信网络设备、云服务设备、精密工具及工业机器人专业设计制造服务商，为客户提供以工业互联网平台为核心的新形态电子设备产品智能制造服务。").Font(UIFont.MILanTing(15)).TextAlignment(.center)
            m.lineBreakMode = .byWordWrapping
            m.numberOfLines = 0
        })
        
        bussinessTitle = UILabel().then({ (t) in
            t.added(into: view)
            t.snp.makeConstraints({ (make) in
                if UIDevice.isPhoneX || UIDevice.isPhoneXR || UIDevice.isPhoneXMax {
                    make.top.equalTo(middleText?.snp.bottom ?? 0).offset(25)
                } else {
                    make.top.equalTo(middleText?.snp.bottom ?? 0).offset(13)
                }
                make.height.equalTo(20)
                make.centerX.equalToSuperview()
            })
            t.TextAlignment(.center).TextColor(UIColor.black).Text("商务合作").Font(UIFont.MILanTing(16))
        })
        
        bussinessLine = UIView().then({ (l) in
            l.added(into: view)
            l.snp.makeConstraints({ (make) in
                make.width.equalTo(0.5 * UIScreen.width)
                make.height.equalTo(0.5)
                make.top.equalTo(bussinessTitle?.snp.bottom ?? 0).offset(15)
                make.centerX.equalToSuperview()
            })
            l.backgroundColor = UIColor.lightGray
        })
        
        bussinessNO = UILabel().then({ (lbl) in
            lbl.added(into: view)
            lbl.snp.makeConstraints({ (make) in
                make.top.equalTo(bussinessLine?.snp.bottom ?? 0).offset(15)
                make.centerX.equalToSuperview()
                make.height.equalTo(20)
            })
            lbl.Text("官方电话: 0755-33855777").Font(UIFont.MILanTing(15)).TextColor(UIColor.lightGray).TextAlignment(.center)
        })
        
        bussinessFax = UILabel().then({ (lbl) in
            lbl.added(into: view)
            lbl.snp.makeConstraints({ (make) in
                make.top.equalTo(bussinessNO?.snp.bottom ?? 0).offset(5)
                make.centerX.equalToSuperview()
                make.height.equalTo(20)
            })
            lbl.TextFont("官方传真: 0755-33855778", UIFont.MILanTing(15)).TextColor(UIColor.lightGray).TextAlignment(.center)
        })
        
        companyName = UILabel().then({ (lbl) in
            lbl.added(into: view)
            lbl.snp.makeConstraints({ (make) in
                make.centerX.equalToSuperview()
                make.height.equalTo(20)
                make.bottom.equalTo(-50)
            })
            lbl.TextFont("富士康工业互联网股份有限公司", UIFont.MILanTing(15)).TextColor(UIColor.lightGray).TextAlignment(.center)
        })
        
        bottomLbl = UILabel().then({ (lbl) in
            lbl.added(into: view)
            lbl.snp.makeConstraints({ (make) in
                make.width.equalTo(0.9 * UIScreen.width)
                make.centerX.equalToSuperview()
                make.height.equalTo(40)
                make.bottom.equalTo(-5)
            })
            lbl.TextFont("Copyright © 2017 Foxconn Industrial Internet Co., Ltd. All rights reserved.", UIFont.MILanTing(13)).TextColor(UIColor.lightGray).TextAlignment(.center)
            lbl.numberOfLines = 0
            lbl.lineBreakMode = .byWordWrapping
        })
    }
}
