//
//  ViewController.swift
//  Fii
//
//  Created by Liu Tao on 2019/2/25.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    static let shared = MainViewController()
    
    let btn1 = UIButton()
    let btn2 = UIButton()
    let btn3 = UIButton()
    
    let lbl1 = UILabel()
    let lbl2 = UILabel()
    let lbl3 = UILabel()
    let lbl4 = UILabel()
    
    var fiiServiceModel = FIIServiceModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    

    func setupView() {
        
        view.backgroundColor = UIColor.cyan
        
        btn1.backgroundColor = UIColor.red
        btn1.addTarget(self, action: #selector(btn1Tapped), for: UIControl.Event.touchUpInside)
        view.addSubview(btn1)
        btn1.snp.makeConstraints { (make) in
            make.width.equalTo(60)
            make.height.equalTo(30)
            make.left.equalTo(10)
            make.centerY.equalToSuperview()
        }
        
        btn2.backgroundColor = UIColor.red
        btn2.addTarget(self, action: #selector(btn2Tapped), for: UIControl.Event.touchUpInside)
        view.addSubview(btn2)
        btn2.snp.makeConstraints { (make) in
            make.width.equalTo(60)
            make.height.equalTo(30)
            make.center.equalToSuperview()
        }
        
        btn3.backgroundColor = UIColor.red
        btn3.addTarget(self, action: #selector(btn3Tapped), for: UIControl.Event.touchUpInside)
        view.addSubview(btn3)
        btn3.snp.makeConstraints { (make) in
            make.width.equalTo(60)
            make.height.equalTo(30)
            make.right.equalTo(-10)
            make.centerY.equalToSuperview()
        }
        
        lbl1.backgroundColor = UIColor.lightText
        view.addSubview(lbl1)
        lbl1.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(90)
        }
        
        lbl2.backgroundColor = UIColor.lightText
        view.addSubview(lbl2)
        lbl2.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(lbl1.snp.bottom).offset(10)
        }
        
        lbl3.backgroundColor = UIColor.lightText
        view.addSubview(lbl3)
        lbl3.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(lbl2.snp.bottom).offset(10)
        }
        
        lbl4.backgroundColor = UIColor.lightText
        view.addSubview(lbl4)
        lbl4.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(lbl3.snp.bottom).offset(10)
        }
        
    }
    
    @objc func btn1Tapped() {
 
        AlarmCenterAPI.GetAPPKey(userName: "管理员", password: "gw8888@") { [weak self] model in
            print("appkey = \(String(describing: model.appkey)), infoKey = \(String(describing: model.infokey))")
            
            if let appKey = model.appkey, let infoKey = model.infokey {
                
                self?.fiiServiceModel.appkey = appKey
                self?.fiiServiceModel.infokey = infoKey
                
            } else {
                print("no data")
            }
            
            self?.updateData()
        }
    }
    
    
    @objc func btn2Tapped() {
        
        AlarmCenterAPI.GetAuthName(appKey: self.fiiServiceModel.appkey ?? "",
                                   infoKey: self.fiiServiceModel.infokey ?? "", { [weak self] (authName) in
            print("authName = \(authName)")
            
            self?.fiiServiceModel.authName = authName
            self?.updateData()
        })
    }
    
    @objc func btn3Tapped() {
        
        AlarmCenterAPI.GetVersion { [weak self] (version) in
            print("version = \(version)")
            
            self?.fiiServiceModel.version = version
            
            self?.updateData()
        }
    }

    
    func updateData() {
        
        lbl1.text = fiiServiceModel.appkey
        lbl2.text = fiiServiceModel.infokey
        lbl3.text = fiiServiceModel.authName
        lbl4.text = fiiServiceModel.version
    }
    
}

