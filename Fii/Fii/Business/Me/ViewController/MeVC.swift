//
//  MeVC.swift
//  Fii
//
//  Created by Liu Tao on 2019/3/11.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import UIKit
import Then
import SnapKit

class MeVC: UIViewController {

    var dataArr = [(img: UIImage("about"), name: "关于"),
                   (img: UIImage("help"), name: "帮助"),
                   (img: UIImage("customer_service"), name: "客服"),
                   (img: UIImage("like"), name: "收藏"),
                   (img: UIImage("settings"), name: "配置")]
    
    let scrollView = UIScrollView()
    let containerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    func setupView() {
        
        view.backgroundColor = UIColor.groupTableViewBackground
        
        scrollView.alwaysBounceVertical = true
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
        
        let topView = UIImageView().then({ (v) in
            v.isUserInteractionEnabled = true
            v.added(into: containerView)
            v.snp.makeConstraints({ (make) in
                make.left.right.top.equalToSuperview()
                make.height.equalTo(150)
            })
            
            _ = UIView().then({ (line) in
                line.backgroundColor = UIColor.gray
                line.added(into: v)
                line.snp.makeConstraints({ (make) in
                    make.left.equalTo(30)
                    make.right.equalTo(-30)
                    make.bottom.equalToSuperview()
                    make.height.equalTo(0.5)
                })
            })
        })
        
        let quitView = UIButton().then { (v) in
            v.backgroundColor = UIColor.white
            v.added(into: containerView)
            v.snp.makeConstraints({ (make) in
                make.left.right.equalToSuperview()
                make.height.equalTo(50)
            })
            
            v.Text("退出登录").TitleColor(UIColor.red).Font(.MILanTing(16))
            v.addTarget(self, action: #selector(quitBtnTapped), for: .touchUpInside)
        }
        
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
                    make.top.equalTo(prevCell.snp.bottom).offset(1)
                    if index == dataArr.count - 1 {
                        make.bottom.equalTo(quitView.snp.top).offset(-15)
                    }
                }
            } else {
                cell.snp.makeConstraints { (make) in
                    make.left.right.equalToSuperview()
                    make.top.equalTo(topView.snp.bottom)
                    make.height.equalTo(50)
                }
            }
            
            prevCell = cell
        }
    }
    
    @objc func quitBtnTapped() {
        print("quit btn tapped...")
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
    private let arrowImgV = UIImageView()
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
        
        backgroundColor = UIColor.white
        
        imageV.added(into: self)
        imageV.snp.makeConstraints { (make) in
            make.width.height.equalTo(20)
            make.left.equalTo(15)
            make.centerY.equalToSuperview()
        }
        
        arrowImgV.ImageName("arrow")
        arrowImgV.added(into: self)
        arrowImgV.snp.makeConstraints { (make) in
            make.width.height.equalTo(20)
            make.centerY.equalToSuperview()
            make.right.equalTo(-10)
        }
        
        titleLbl.FontColor(UIFont.MILanTing(16), UIColor.gray)
        titleLbl.added(into: self)
        titleLbl.snp.makeConstraints { (make) in
            make.left.equalTo(imageV.snp.right).offset(10)
            make.right.equalTo(-50)
            make.height.equalTo(50)
            make.centerY.equalToSuperview()
        }
    }
}
