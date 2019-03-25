
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
    
    var questionStr: String? {
        didSet {
            titleLabel.Text(questionStr)
        }
    }
    
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
        
        backgroundColor = UIColor.groupTableViewBackground
        
        contentView.backgroundColor = UIColor.white
        contentView.cornerRadius = 7.0
        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(11)
            make.right.equalTo(-11)
            make.bottom.equalToSuperview()
        }
        
        openButton.added(into: contentView)
        openButton.snp.makeConstraints({ (make) in
            make.width.height.equalTo(20)
            make.right.equalTo(-15)
            make.top.equalTo(35)
        })
        openButton.backgroundColor = UIColor.white
        openButton.setBackgroundImage(UIImage("arrow_down"), for: .normal)
        openButton.setBackgroundImage(UIImage("arrow_up"), for: .selected)
        openButton.addTarget(self, action: #selector(clickOpenBtn(_:)), for: .touchUpInside)
        
        titleLabel.added(into: contentView)
        titleLabel.snp.makeConstraints({ (make) in
            make.left.equalTo(15)
            make.right.equalTo(openButton.snp.left).offset(5)
            make.top.equalTo(5)
            make.height.equalTo(80)
        })
        titleLabel.TextFontColor("title", UIFont.MILanTing(16.0), UIColor.black)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        
        contentLabel.added(into: contentView)
        contentLabel.snp.makeConstraints({ (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
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
