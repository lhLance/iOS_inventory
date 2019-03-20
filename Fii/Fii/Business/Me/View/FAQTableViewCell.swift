
//
//  FAQTableViewCell.swift
//  Fii
//
//  Created by Liu Tao on 2019/3/20.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import UIKit

class FAQTableViewCell: UITableViewCell {
    
    static let identifier = "FAQTableViewCell"
    
    var contentStr: String? {
        didSet {
            contentLabel.Text(contentStr)
        }
    }

    var clickOpenAction: ((Bool) -> Void)?
    
    private var titleLabel = UILabel()
    private var contentLabel = UILabel()
    var openButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    func setupView() {
        
        openButton.added(into: contentView)
        openButton.snp.makeConstraints({ (make) in
            make.width.height.equalTo(60)
            make.right.equalTo(-5)
            make.top.equalTo(5)
        })
        openButton.backgroundColor = UIColor.cyan
        openButton.setTitle("展开", for: .normal)
        openButton.setTitle("收起", for: .selected)
        openButton.addTarget(self, action: #selector(clickOpenBtn(_:)), for: .touchUpInside)
        
        titleLabel.added(into: contentView)
        titleLabel.snp.makeConstraints({ (make) in
            make.left.equalTo(5)
            make.right.equalTo(openButton.snp.left).offset(5)
            make.top.equalTo(5)
            make.height.equalTo(80)
        })
        titleLabel.TextFontColor("title", UIFont.MILanTing(16.0), UIColor.black)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        
        contentLabel.added(into: contentView)
        contentLabel.snp.makeConstraints({ (make) in
            make.left.equalTo(5)
            make.right.equalTo(-5)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.bottom.equalTo(-5)
        })
        contentLabel.TextFontColor("", UIFont.MILanTing(16.0), UIColor.lightGray)
        contentLabel.numberOfLines = 0
        contentLabel.lineBreakMode = .byWordWrapping
    }
    
    @objc func clickOpenBtn(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        clickOpenAction?(sender.isSelected)
    }
}
