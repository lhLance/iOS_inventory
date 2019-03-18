//
//  AlertView.swift
//  Fii
//
//  Created by Liu Tao on 2019/3/18.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import UIKit
import SnapKit

class AlertView: UIView {
    
    var confirmBtnTap: (() -> Void)?
    
    private var titleView: UIView?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }

    func setupView() {
        
        self.backgroundColor = UIColor(white: 0.5, alpha: 0.6)
        
        titleView = UIView().then({ (t) in
            t.backgroundColor = UIColor.white
            t.added(into: self)
            t.snp.makeConstraints({ (make) in
                make.width.equalTo(0.7 * UIScreen.width)
                make.height.equalTo(0.5 * UIScreen.width)
                make.center.equalToSuperview()
            })
            
            let topLbl = UILabel().then({ (l) in
                l.Text("登录失败").FontColor(UIFont.MILanTing(16), UIColor.black).TextAlignment(.center)
                l.added(into: t)
                l.snp.makeConstraints({ (make) in
                    make.top.equalTo(20)
                    make.centerX.equalToSuperview()
                    make.width.equalToSuperview()
                    make.height.equalTo(15)
                })
            })
            
            let bottomLbl = UILabel().then({ (l) in
                l.Text("账号或密码错误, 请重新输入").FontColor(UIFont.MILanTing(16), UIColor.lightGray).TextAlignment(.center)
                l.added(into: t)
                l.snp.makeConstraints({ (make) in
                    make.top.equalTo(topLbl.snp.bottom).offset(6)
                    make.centerX.equalToSuperview()
                    make.width.equalToSuperview()
                    make.height.equalTo(15)
                })
            })
            
            let lineView = UIView().then({ (l) in
                l.backgroundColor = UIColor.lightGray
                l.added(into: t)
                l.snp.makeConstraints({ (make) in
                    make.top.equalTo(bottomLbl.snp.bottom).offset(10)
                    make.centerX.equalToSuperview()
                    make.width.equalToSuperview()
                    make.height.equalTo(3)
                })
            })
            
            _ = UIButton().then({ (b) in
                b.Text("确定").TitleColor(UIColor.blue).Font(UIFont.MILanTing(16))
                b.added(into: t)
                b.snp.makeConstraints({ (make) in
                    make.width.equalToSuperview()
                    make.top.equalTo(lineView.snp.bottom)
                    make.bottom.equalToSuperview()
                })
                b.addTarget(self, action: #selector(confirmBtnTapped), for: .touchUpInside)
            })
            
            
        })
    }
    
    @objc func confirmBtnTapped() {
        print("confirmBtnTapped...")
        confirmBtnTap?()
//        self.removeFromSuperview()
    }
}
