//
//  MeLanguageCell.swift
//  Fii
//
//  Created by Liu Tao on 2019/4/22.
//  Copyright © 2019年 Ye Tao. All rights reserved.
//

import UIKit
import Then
import SnapKit

class MeLanguageCell: UITableViewCell {
    
    static let identifier = "MeLanguageCell"
    
    var title: String? {
        didSet {
            titleLbl.Text(title)
        }
    }

    private let titleLbl = UILabel("", color: UIColor.hex(0x414141), align: .left, font: UIFont.PFMedium(14))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        titleLbl.added(into: contentView)
        titleLbl.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.centerY.equalToSuperview()
        }
        
        _ = UIView().then({ (v) in
            v.backgroundColor = UIColor.hex(0xE3E6F4)
            v.added(into: contentView)
            v.snp.makeConstraints({ (make) in
                make.left.equalTo(titleLbl.snp.left)
                make.right.equalToSuperview()
                make.height.equalTo(0.5)
                make.bottom.equalToSuperview()
            })
        })
        
    }
    
}
