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
    var wechatTitle: UILabel?
    var wechatLine: UIView?
    var wechatName: UILabel?
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
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func reloadData() {
        
        titleBtn?.Text(LanguageHelper.getString(key: "me_about_slogan"))
        middleText?.Text(LanguageHelper.getString(key: "me_about_discription"))
        wechatTitle?.Text(LanguageHelper.getString(key: "me_about_wechat_title"))
        wechatName?.Text(LanguageHelper.getString(key: "me_about_wechat"))
        bussinessTitle?.Text(LanguageHelper.getString(key: "me_about_bussiness_title"))
        bussinessNO?.Text(LanguageHelper.getString(key: "me_about_bussiness_phone"))
        bussinessFax?.Text(LanguageHelper.getString(key: "me_about_bussiness_fax"))
        companyName?.Text(LanguageHelper.getString(key: "me_about_company_name"))
    }
    
    func setupView() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadData),
                                               name: NSNotification.Name(rawValue: "LanguageChanged"),
                                               object: nil)
        
        view.backgroundColor = UIColor.white
        
        titleImg = UIImageView().then({ (img) in
            img.added(into: view)
            img.backgroundColor = UIColor.red
            img.snp.makeConstraints({ (make) in
                make.width.height.equalTo(90)
                make.centerX.equalToSuperview()
                if UIDevice.isPhone5orSE {
                    make.top.equalTo(UIScreen.navBarHeight + 10)
                } else {
                    make.top.equalTo(UIScreen.navBarHeight + 50)
                }
            })
            img.cornerRadius = 45
            img.ImageName("Icon")
        })
        
        titleLabl = UILabel().then({ (lbl) in
            lbl.added(into: view)
            lbl.TextFont("Fii v1.0.1", UIFont.PFRegular(16)).TextColor(UIColor.lightGray).TextAlignment(.center)
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
                if UIDevice.isPhone5orSE {
                    make.top.equalTo(titleLabl?.snp.bottom ?? 0).offset(5)
                } else {
                    make.top.equalTo(titleLabl?.snp.bottom ?? 0).offset(30)
                }
            })
            b.borderColor = UIColor.red
            b.borderWidth = 1.0
            b.cornerRadius = 20
            b.Text(LanguageHelper.getString(key: "me_about_slogan")).TitleColor(UIColor.red).Font(UIFont.PFRegular(16))
        })
        
        middleText = UILabel().then({ (m) in
            m.added(into: view)
            m.snp.makeConstraints({ (make) in
                if UIDevice.isPhone5orSE {
                    make.top.equalTo(titleBtn?.snp.bottom ?? 0).offset(5)
                    make.width.equalTo(0.8 * UIScreen.width)
                    make.height.equalTo(110)
                } else {
                    make.top.equalTo(titleBtn?.snp.bottom ?? 0).offset(20)
                    make.width.equalTo(0.7 * UIScreen.width)
                    make.height.equalTo(120)
                }
                make.centerX.equalToSuperview()
            })
            m.TextColor(UIColor.lightGray).Text(LanguageHelper.getString(key: "me_about_discription")).Font(UIFont.PFRegular(15)).TextAlignment(.center)
            m.lineBreakMode = .byWordWrapping
            m.numberOfLines = 0
        })
        
        wechatTitle = UILabel().then({ (t) in
            t.added(into: view)
            t.snp.makeConstraints({ (make) in
                if UIDevice.isPhoneXorMore || UIDevice.isPhone678Plus {
                    make.top.equalTo(middleText?.snp.bottom ?? 0).offset(20)
                } else {
                    make.top.equalTo(middleText?.snp.bottom ?? 0).offset(5)
                }
                make.height.equalTo(20)
                make.centerX.equalToSuperview()
            })
            t.TextAlignment(.center).TextColor(UIColor.black).Text(LanguageHelper.getString(key: "me_about_wechat_title")).Font(UIFont.PFRegular(16))
        })
        
        wechatLine = UIView().then({ (l) in
            l.added(into: view)
            l.snp.makeConstraints({ (make) in
                make.width.equalTo(0.5 * UIScreen.width)
                make.height.equalTo(APP.SINGLE_LINE_HEIGHT)
                if UIDevice.isPhoneXorMore || UIDevice.isPhone678Plus {
                    make.top.equalTo(wechatTitle?.snp.bottom ?? 0).offset(15 + APP.SINGLE_LINE_ADJUST_OFFSET)
                } else {
                    make.top.equalTo(wechatTitle?.snp.bottom ?? 0).offset(5 + APP.SINGLE_LINE_ADJUST_OFFSET)
                }
                make.centerX.equalToSuperview()
            })
            l.backgroundColor = UIColor.lightGray
        })

        wechatName = UILabel().then({ (lbl) in
            lbl.added(into: view)
            lbl.snp.makeConstraints({ (make) in
                if UIDevice.isPhoneXorMore || UIDevice.isPhone678Plus {
                    make.top.equalTo(wechatLine?.snp.bottom ?? 0).offset(15)
                } else {
                    make.top.equalTo(wechatLine?.snp.bottom ?? 0).offset(5)
                }
                make.centerX.equalToSuperview()
                make.height.equalTo(20)
            })
            lbl.Text(LanguageHelper.getString(key: "me_about_wechat")).Font(UIFont.PFRegular(15)).TextColor(UIColor.lightGray).TextAlignment(.center)
        })
        
        bussinessTitle = UILabel().then({ (t) in
            t.added(into: view)
            t.snp.makeConstraints({ (make) in
                if UIDevice.isPhoneXorMore || UIDevice.isPhone678Plus {
                    make.top.equalTo(wechatName?.snp.bottom ?? 0).offset(25)
                } else {
                    make.top.equalTo(wechatName?.snp.bottom ?? 0).offset(10)
                }
                make.height.equalTo(20)
                make.centerX.equalToSuperview()
            })
            t.TextAlignment(.center).TextColor(UIColor.black).Text(LanguageHelper.getString(key: "me_about_bussiness_title")).Font(UIFont.PFRegular(16))
        })
        
        bussinessLine = UIView().then({ (l) in
            l.added(into: view)
            l.snp.makeConstraints({ (make) in
                make.width.equalTo(0.5 * UIScreen.width)
                make.height.equalTo(APP.SINGLE_LINE_HEIGHT)
                if UIDevice.isPhoneXorMore || UIDevice.isPhone678Plus {
                    make.top.equalTo(bussinessTitle?.snp.bottom ?? 0).offset(15 + APP.SINGLE_LINE_ADJUST_OFFSET)
                } else {
                    make.top.equalTo(bussinessTitle?.snp.bottom ?? 0).offset(5 + APP.SINGLE_LINE_ADJUST_OFFSET)
                }
                make.centerX.equalToSuperview()
            })
            l.backgroundColor = UIColor.lightGray
        })
        
        bussinessNO = UILabel().then({ (lbl) in
            lbl.added(into: view)
            lbl.snp.makeConstraints({ (make) in
                if UIDevice.isPhoneXorMore || UIDevice.isPhone678Plus {
                    make.top.equalTo(bussinessLine?.snp.bottom ?? 0).offset(15)
                } else {
                    make.top.equalTo(bussinessLine?.snp.bottom ?? 0).offset(5)
                }
                make.centerX.equalToSuperview()
                make.height.equalTo(20)
            })
            lbl.Text(LanguageHelper.getString(key: "me_about_bussiness_phone")).Font(UIFont.PFRegular(15)).TextColor(UIColor.lightGray).TextAlignment(.center)
        })
        
        bussinessFax = UILabel().then({ (lbl) in
            lbl.added(into: view)
            lbl.snp.makeConstraints({ (make) in
                make.top.equalTo(bussinessNO?.snp.bottom ?? 0).offset(5)
                make.centerX.equalToSuperview()
                make.height.equalTo(20)
            })
            lbl.TextFont(LanguageHelper.getString(key: "me_about_bussiness_fax"), UIFont.PFRegular(15)).TextColor(UIColor.lightGray).TextAlignment(.center)
        })
        
        companyName = UILabel().then({ (lbl) in
            lbl.added(into: view)
            lbl.snp.makeConstraints({ (make) in
                make.centerX.equalToSuperview()
                make.height.equalTo(20)
                make.bottom.equalTo(-60)
            })
            lbl.TextFont(LanguageHelper.getString(key: "me_about_company_name"), UIFont.PFRegular(15)).TextColor(UIColor.lightGray).TextAlignment(.center)
        })
        
        bottomLbl = UILabel().then({ (lbl) in
            lbl.added(into: view)
            lbl.snp.makeConstraints({ (make) in
                make.width.equalTo(0.9 * UIScreen.width)
                make.centerX.equalToSuperview()
                make.height.equalTo(40)
                make.bottom.equalTo(-15)
            })
            lbl.TextFont("Copyright © 2017 Foxconn Industrial Internet Co., Ltd. All rights reserved.", UIFont.PFRegular(13)).TextColor(UIColor.lightGray).TextAlignment(.center)
            lbl.numberOfLines = 0
            lbl.lineBreakMode = .byWordWrapping
        })
    }
}
