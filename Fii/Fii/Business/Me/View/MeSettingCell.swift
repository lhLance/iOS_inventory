//
//  MeSettingCell.swift
//  Fii
//
//  Created by Liu Tao on 2019/3/23.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import UIKit

class MeSettingCell: UIView {
    
    var detailText = "" {
        didSet {
            detailLbl.isHidden = false
            arrow.isHidden = true
            detailLbl.text = detailText
        }
    }
    var bottomLine = UIView()
    
    let icon = UIImageView.init()
    let titleLbl = UILabel.init("", color: UIColor.hex(0x414141), align: .left, font: UIFont.MILanTing(14))
    let arrow = UIImageView.init("return")
    let detailLbl = UILabel.init("", color: UIColor.hex(0x414141), align: .right, font: UIFont.MILanTing(14))
    
    let tap = UITapGestureRecognizer.init()
    
    convenience init(img: UIImage, title: String) {
        self.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.white
        self.icon.image = img
        self.titleLbl.text = title
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        snpLayout()
    }
    
    func snpLayout() {
        self.addGestureRecognizer(tap)
        
        icon.becomeSubviewIn(self).snp.makeConstraints {
            $0.left.equalTo(14)
            $0.centerY.equalToSuperview()
        }
        titleLbl.becomeSubviewIn(self).snp.makeConstraints {
            $0.left.equalTo(46)
            $0.centerY.equalToSuperview()
        }
        arrow.becomeSubviewIn(self)
        arrow.snp.makeConstraints {
            $0.right.equalTo(-14)
            $0.centerY.equalToSuperview()
        }
        detailLbl.isHidden = true
        detailLbl.becomeSubviewIn(self)
        detailLbl.snp.makeConstraints {
            $0.right.equalTo(-14)
            $0.centerY.equalToSuperview()
        }
        bottomLine = UIView.init().setup({ (line) in
            line.backgroundColor = UIColor.hex(0xE3E6F4)
            line.becomeSubviewIn(self)
            line.snp.makeConstraints {
                $0.left.equalTo(0)
                $0.right.equalTo(0)
                $0.bottom.equalTo(0)
                $0.height.equalTo(0.5)
            }
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize.init(width: UIScreen.width, height: 46)
    }
    
}
