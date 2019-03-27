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
    
    var titleOne: String? {
        didSet {
            self.topLabel?.Text(titleOne)
        }
    }
    
    var titleTwo: String? {
        didSet {
            self.bottomLabel?.Text(titleTwo)
        }
    }
    
    private var titleView: UIView?
    private var topLabel: UILabel?
    private var bottomLabel: UILabel?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }

    func setupView() {
        
        backgroundColor = UIColor(white: 0.5, alpha: 0.6)
        
        titleView = UIView().then({ (t) in
            t.backgroundColor = UIColor.white
            t.cornerRadius = 2.0
            t.added(into: self)
            t.snp.makeConstraints({ (make) in
                make.width.equalTo(0.7 * UIScreen.width)
                make.height.equalTo(0.5 * UIScreen.width)
                make.center.equalToSuperview()
            })
            
            topLabel = UILabel().then({ (l) in
                l.FontColor(UIFont.PFRegular(16), UIColor.black).TextAlignment(.center)
                l.added(into: t)
                l.snp.makeConstraints({ (make) in
                    make.top.equalTo(0.05 * UIScreen.height)
                    make.centerX.equalToSuperview()
                    make.width.equalToSuperview()
                    make.height.equalTo(15)
                })
            })
            
            bottomLabel = UILabel().then({ (l) in
                l.FontColor(UIFont.PFRegular(16), UIColor.lightGray).TextAlignment(.center)
                l.added(into: t)
                l.snp.makeConstraints({ (make) in
                    make.top.equalTo(topLabel?.snp.bottom ?? (0.05 * UIScreen.height + 15)).offset(15)
                    make.centerX.equalToSuperview()
                    make.width.equalToSuperview()
                    make.height.equalTo(15)
                })
            })
            
            let lineView = UIView().then({ (l) in
                l.backgroundColor = UIColor.hex(0xCCCCCC)
                l.added(into: t)
                l.snp.makeConstraints({ (make) in
                    make.bottom.equalTo(-50)
                    make.centerX.equalToSuperview()
                    make.width.equalToSuperview()
                    make.height.equalTo(3)
                })
            })
            
            _ = UIButton().then({ (b) in
                b.cornerRadius = 2.0
                b.Text("确定").TitleColor(UIColor.hex(0x2C7CFD)).Font(UIFont.PFRegular(16))
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
    }
}
