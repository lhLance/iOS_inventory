//
//  LoginVC.swift
//  Fii
//
//  Created by mac on 2019/3/14.
//  Copyright © 2019 Liu Tao. All rights reserved.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class LoginVC: UIViewController {

    let logInLbl = UILabel()
    let userNameTf = UITextField()
    let passwordTf = UITextField()
    let loginBtn = UIButton()
    let regisBtn = UIButton()
    let bag = DisposeBag()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        bindUI()
    }

    func setupView() {
        
        view.backgroundColor = UIColor.white
        
        logInLbl.TextColor(UIColor.black).TextFont("登录", UIFont.MILanTing(16))
        logInLbl.added(into: view)
        logInLbl.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(UIScreen.navBarHeight + 30)
            make.width.equalTo(60)
            make.height.equalTo(25)
        }
        
        userNameTf.borderStyle = .none
        userNameTf.keyboardType = .asciiCapable
        userNameTf.attributedPlaceholder = NSAttributedString(string: "请输入账号",
                                                              attributes: [NSAttributedString.Key.font : UIFont.MILanTing(14), NSAttributedString.Key.foregroundColor: UIColor.hex(0x9a9a9a)])
        userNameTf.added(into: view)
        userNameTf.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(20)
            make.top.equalTo(logInLbl.snp.bottom).offset(30)
        }

        _ = UIButton().then({ (b) in
            b.setBackgroundImage(UIImage("clear"), for: .normal)
            b.added(into: view)
            b.snp.makeConstraints({ (make) in
                make.width.height.equalTo(20)
                make.right.equalTo(userNameTf.snp.right).offset(-5)
                make.centerY.equalTo(userNameTf.snp.centerY)
            })
            b.addTarget(self, action: #selector(clearBtnTapped), for: .touchUpInside)
        })
        
        let line1 = UIView().then { (line) in
            line.added(into: userNameTf)
            line.snp.makeConstraints({ (make) in
                make.width.equalTo(userNameTf.snp.width)
                make.top.equalTo(userNameTf.snp.bottom).offset(5)
                make.height.equalTo(1)
            })
            line.backgroundColor = UIColor.groupTableViewBackground
        }
        
        passwordTf.isSecureTextEntry = true
        passwordTf.borderStyle = .none
        passwordTf.keyboardType = .asciiCapable
        passwordTf.attributedPlaceholder = NSAttributedString(string: "请输入密码",
                                                              attributes: [NSAttributedString.Key.font : UIFont.MILanTing(14), NSAttributedString.Key.foregroundColor: UIColor.hex(0x9a9a9a)])
        passwordTf.added(into: view)
        passwordTf.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(20)
            make.top.equalTo(line1.snp.bottom).offset(20)
        }
        
        _ = UIButton().then({ (b) in
            b.setBackgroundImage(UIImage("lock"), for: .normal)
            b.added(into: view)
            b.snp.makeConstraints({ (make) in
                make.width.height.equalTo(20)
                make.right.equalTo(passwordTf.snp.right).offset(-5)
                make.centerY.equalTo(passwordTf.snp.centerY)
            })
            b.addTarget(self, action: #selector(passwordBtnTapped), for: .touchUpInside)
        })
        
        let line2 = UIView().then { (line) in
            line.added(into: view)
            line.snp.makeConstraints({ (make) in
                make.left.equalTo(15)
                make.width.equalTo(passwordTf.snp.width)
                make.top.equalTo(passwordTf.snp.bottom).offset(5)
                make.height.equalTo(1)
            })
            line.backgroundColor = UIColor.groupTableViewBackground
        }
        
        loginBtn.cornerRadius = 5
        loginBtn.backgroundColor = UIColor.hex(0x9DCCFF)
        loginBtn.Text("登录").Font(UIFont.MILanTing(16)).TitleColor(UIColor.white)
        loginBtn.added(into: view)
        loginBtn.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(50)
            make.top.equalTo(line2.snp.bottom).offset(50)
        }
        loginBtn.addTarget(self, action: #selector(loginBtnTapped), for: .touchUpInside)
        
        regisBtn.Text("注册新账号").TitleColor(UIColor.hex(0x9DCCFF)).Font(UIFont.MILanTing(14))
        regisBtn.added(into: view)
        regisBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(loginBtn.snp.bottom).offset(10)
        }
        regisBtn.addTarget(self, action: #selector(registerBtnTapped), for: .touchUpInside)
    }
    
    @objc func clearBtnTapped() {
        userNameTf.text = ""
    }
    
    @objc func passwordBtnTapped() {
        passwordTf.isSecureTextEntry = !passwordTf.isSecureTextEntry
    }
    
    @objc func loginBtnTapped() {
        print("loginBtnTapped...")
        AlarmCenterAPI.GetAPPKey(userName: "aaa",
                                 password: "000") { (model) in
                UserInfo.shared.appKey = model.appkey ?? ""
                UserInfo.shared.infoKey = model.infokey ?? ""
        }
    }
    
    @objc func registerBtnTapped() {
        let vc = RegisterVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func bindUI() {
        
        Observable.combineLatest(userNameTf.rx.text.orEmpty,
                                 passwordTf.rx.text.orEmpty) { [weak self] phoneNumber, password in
                                    if phoneNumber.count > 0
                                        && password.count > 0
                                    {
                                        self?.loginBtn.isEnabled = true
                                        self?.loginBtn.backgroundColor = UIColor.hex(0x2C7CFD)
                                    } else {
                                        self?.loginBtn.isEnabled = false
                                        self?.loginBtn.backgroundColor = UIColor.hex(0x9DCCFF)
                                    }
            }.subscribe().disposed(by: bag)
        
    }
    
}
