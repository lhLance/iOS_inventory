//
//  UserInfoVC.swift
//  Fii
//
//  Created by mac on 2019/4/2.
//  Copyright © 2019 Liu Tao. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class UserInfoVC: UIViewController {
    
    fileprivate let alertWindow = UIWindow(frame: UIScreen.main.bounds)
    fileprivate let nickNameLabel = UILabel()
    fileprivate let phoneNumLabel = UILabel()
    fileprivate let genderLabel = UILabel()
    fileprivate let cityLabel = UILabel()
    fileprivate let briefLabel = UILabel()
    
    fileprivate var avatarImageView = UIImageView()
    fileprivate var labelArr = [UILabel()]
    fileprivate var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "个人信息"
        setupSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadData()
    }
    
    func reloadData() {

    }
    
    func setupSubviews() {
        
        view.backgroundColor = UIColor.white
        labelArr.removeAll()
        labelArr.append(nickNameLabel)
        labelArr.append(phoneNumLabel)
        
        let avatarCell = UIView.init()
        avatarCell.setup { (v) in
            v.becomeSubviewIn(self.view).snp.makeConstraints {
                $0.top.equalTo(0)
                $0.left.right.equalTo(0)
                $0.height.equalTo(89)
            }
            v.backgroundColor = UIColor.white
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(resetAvatar))
            v.addGestureRecognizer(tapGesture)
            _ = UILabel("头像", color: UIColor.hex(0x414141), align: .left, font: UIFont.PFRegular(14)).setup({ (l) in
                l.becomeSubviewIn(v).snp.makeConstraints {
                    $0.left.equalTo(14)
                    $0.centerY.equalToSuperview()
                }
            })
            avatarImageView = UIImageView.init().setup({ (img) in
                img.loadImage(path: UserInfo.shared.avatar, placeImage: UIImage("avatar"))
                img.becomeSubviewIn(v).snp.makeConstraints {
                    $0.right.equalTo(-14)
                    $0.centerY.equalToSuperview()
                    $0.size.equalTo(CGSize.init(width: 68, height: 68))
                }
            })
            _ = UIView.init().setup({ (line) in
                line.backgroundColor = UIColor.hex(0xE3E6F4)
                line.becomeSubviewIn(v).snp.makeConstraints {
                    $0.bottom.equalToSuperview()
                    $0.left.equalTo(14)
                    $0.right.equalTo(13)
                    $0.height.equalTo(1)
                }
            })
        }
        
        let titles = ["昵称", "邮箱"]
        let values = [UserInfo.shared.userName,
                      UserInfo.shared.userEmail] as [Any]
        
        for i in 0...1 {
            _ = UIView().setup({ (cell) in
                cell.backgroundColor = UIColor.white
                cell.becomeSubviewIn(self.view).snp.makeConstraints {
                    $0.top.equalTo(avatarCell.snp.bottom).offset(i * 52)
                    $0.left.right.equalTo(0)
                    $0.height.equalTo(52)
                }
                if i == 0 {
                    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(resetNickName))
                    cell.addGestureRecognizer(tapGesture)
                } else {
                    
                }
                
                let titleLabel = UILabel().setup({ (title) in
                    title.text = titles[i]
                    title.textColor = UIColor.hex(0x414141)
                    title.font = .PFRegular(14)
                    title.becomeSubviewIn(cell).snp.makeConstraints {
                        $0.left.equalTo(14)
                        $0.centerY.equalToSuperview()
                    }
                    if i == 4 {
                        title.setContentHuggingPriority(.required, for: .horizontal)
                    }
                })
                
                labelArr[i].setup({ (value) in
                    value.text = values[i] as? String
                    value.textColor = UIColor.hex(0x888888)
                    value.font = .PFRegular(14)
                    value.becomeSubviewIn(cell).snp.makeConstraints {
                        $0.right.equalTo(-14)
                        $0.centerY.equalToSuperview()
                        if i == 4 {
                            $0.left.equalTo(titleLabel.snp.right).offset(10)
                            value.setContentHuggingPriority(.defaultLow, for: .horizontal)
                            value.textAlignment = .right
                        }
                    }
                })
                
                if i != 4 {
                    _ = UIView().setup({ (line) in
                        line.backgroundColor = UIColor.hex(0xE3E6F4)
                        line.becomeSubviewIn(cell).snp.makeConstraints {
                            $0.bottom.equalToSuperview()
                            $0.left.equalTo(14)
                            $0.right.equalTo(13)
                            $0.height.equalTo(1)
                        }
                    })
                    
                }
            })
        }
    }
    
    @objc private func resetNickName() {

    }
    
    @objc private func resetAvatar() {
//        let vc = MeSelectPhotoVC()
//        vc.showOnVC(self)
//        vc.onDidSelectImage = { img in
//
//        }
//        vc.onDidUploadImage = { [unowned self] url in
//            MeAPI.setUserPersonalInfo(avatar: url,
//                                      nickName: PersonalInfo.shared.info?.nick_name,
//                                      desc: PersonalInfo.shared.info?.desc,
//                                      sex: PersonalInfo.shared.info?.sex)
//                .subscribe(onNext: { result in
//                    switch result {
//                    case .success(_):
//                        Toast.show(message: "上传头像成功")
//                        self.reloadData()
//                    case .fail(let error):
//                        print("upload avatar fail: \(error)")
//                        Toast.show(message: "上传头像失败")
//                    }
//                }).disposed(by: self.bag)
//        }
    }
}
