//
//  MeVC.swift
//  Fii
//
//  Created by Liu Tao on 2019/3/11.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import UIKit
import SnapKit

class MeVC: UIViewController {

    var dataArr = [(img: UIImage(), name: "关于"),
                   (img: UIImage(), name: "帮助"),
                   (img: UIImage(), name: "客服"),
                   (img: UIImage(), name: "收藏"),
                   (img: UIImage(), name: "配置")]
    
    let scrollView = UIScrollView()
    let containerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    func setupView() {
        
        scrollView.added(into: view)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        containerView.added(into: scrollView)
        containerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        setupCells()
    }
    
    func setupCells() {
        
        var prevCell: Cell?
        for (index, item) in dataArr.enumerated() {
            let cell = Cell()
            cell.added(into: containerView)
            cell.image = item.img
            cell.title = item.name
            
            if let prevCell = prevCell {
                cell.snp.makeConstraints { (make) in
                    make.left.right.equalToSuperview()
                    make.height.equalTo(50)
                    make.top.equalTo(prevCell.snp.bottom).offset(2)
                    if index == dataArr.count - 1 {
                        make.bottom.equalToSuperview()
                    }
                }
            } else {
                cell.snp.makeConstraints { (make) in
                    make.left.right.equalToSuperview()
                    make.top.equalToSuperview()
                    make.height.equalTo(50)
                }
            }
            
            prevCell = cell
        }
    }
    
}

class Cell: UIView {
    
    var image: UIImage? {
        didSet {
            imageV.image = image
        }
    }
    
    var title: String? {
        didSet {
            titleLbl.text = title
        }
    }
    
    private let imageV = UIImageView()
    private let titleLbl = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    func setupView() {
        
        backgroundColor = UIColor.cyan
        
        imageV.added(into: self)
        imageV.snp.makeConstraints { (make) in
            make.width.height.equalTo(50)
            make.left.equalTo(50)
            make.centerY.equalToSuperview()
        }
        
        titleLbl.added(into: self)
        titleLbl.snp.makeConstraints { (make) in
            make.left.equalTo(imageV.snp.right).offset(30)
            make.right.equalTo(-50)
            make.height.equalTo(50)
            make.centerY.equalToSuperview()
        }
    }
}
