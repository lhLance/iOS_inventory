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

    var dataArr = [(img: UIImage?, name: String?)]()
    var quitView: UIButton?
    
    let scrollView = UIScrollView()
    let containerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if APP.isLogin {
            quitView?.isHidden = true
        } else {
            quitView?.isHidden = false
        }
        
        reloadData()
        setupCells()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func reloadData() {
        
       dataArr = [(img: UIImage("about"), name: LanguageHelper.getString(key: "me_about")),
         (img: UIImage("help"), name: LanguageHelper.getString(key: "me_help")),
         (img: UIImage("customer_service"), name: LanguageHelper.getString(key: "me_customer_service")),
         (img: UIImage("like"), name: LanguageHelper.getString(key: "me_like")),
         (img: UIImage("settings"), name: LanguageHelper.getString(key: "me_settings"))]
        
        quitView?.Text(LanguageHelper.getString(key: "me_log_out"))
    }
    
    func setupView() {
        
        view.backgroundColor = UIColor.groupTableViewBackground
        
        scrollView.alwaysBounceVertical = true
        scrollView.added(into: view)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadData),
                                               name: NSNotification.Name(rawValue: "LanguageChanged"),
                                               object: nil)
    }
    
    func setupCells() {
        
        scrollView.removeAllSubviews()
        
        containerView.added(into: scrollView)
        containerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        let topView = UIImageView().then({ (v) in
            v.ImageName("me_back")
            v.isUserInteractionEnabled = true
            v.added(into: scrollView)
            v.snp.makeConstraints({ (make) in
                make.left.right.top.equalToSuperview()
                make.height.equalTo(150)
            })
            
            let avatar = UIButton().then({ (btn) in
                btn.added(into: v)
                btn.backgroundColor = UIColor.white
                btn.cornerRadius = 30
                btn.snp.makeConstraints({ (make) in
                    make.width.height.equalTo(60)
                    make.centerY.equalToSuperview()
                    make.left.equalTo(30)
                })
                btn.setBackgroundImage(UIImage("\(UserInfo.shared.avatar)"), for: .normal)
                btn.addTarget(self, action: #selector(avatarBtnTapped), for: .touchUpInside)
            })
            
            _ = UILabel().then({ (lbl) in
                lbl.added(into: v)
                lbl.snp.makeConstraints({ (make) in
                    make.left.equalTo(avatar.snp.right).offset(10)
                    make.right.equalTo(-50)
                    make.height.equalTo(20)
                    make.top.equalTo(avatar.snp.top).offset(8)
                })
                lbl.Text(UserInfo.shared.userName).TextColor(UIColor.white).Font(UIFont.PFRegular(15))
            })

            _ = UILabel().then({ (lbl) in
                lbl.added(into: v)
                lbl.snp.makeConstraints({ (make) in
                    make.left.equalTo(avatar.snp.right).offset(10)
                    make.right.equalTo(-50)
                    make.height.equalTo(20)
                    make.bottom.equalTo(avatar.snp.bottom).offset(-8)
                })
                lbl.Text(UserInfo.shared.userEmail).TextColor(UIColor.white).Font(UIFont.PFRegular(14))
            })
        })
        
        quitView = UIButton().then { (v) in
            v.backgroundColor = UIColor.white
            v.added(into: scrollView)
            v.snp.makeConstraints({ (make) in
                make.left.right.equalToSuperview()
                make.height.equalTo(50)
            })
            
            v.Text(LanguageHelper.getString(key: "me_log_out")).TitleColor(UIColor.red).Font(.PFRegular(16))
            v.addTarget(self, action: #selector(quitBtnTapped), for: .touchUpInside)
        }
        
        var prevCell: Cell?
        for (index, item) in dataArr.enumerated() {
            let cell = Cell()
            cell.added(into: scrollView)
            cell.image = item.img
            cell.title = item.name
            
            if let prevCell = prevCell {
                cell.snp.makeConstraints { (make) in
                    make.left.right.equalToSuperview()
                    make.height.equalTo(50)
                    make.top.equalTo(prevCell.snp.bottom).offset(1)
                    if index == dataArr.count - 1 {
                        make.bottom.equalTo(quitView?.snp.top ?? 0).offset(-15)
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
            
            cell.cellTap = { [unowned self] in
                switch index {
                case 0:
                    let vc = AboutVC()
                    vc.title = LanguageHelper.getString(key: "me_about_us")
                    self.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(vc, animated: true)
                    self.hidesBottomBarWhenPushed = false
                case 1:
                    let vc = HelpVC()
                    vc.title = LanguageHelper.getString(key: "me_help_title")
                    self.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(vc, animated: true)
                    self.hidesBottomBarWhenPushed = false
                case 2:
                    let vc = CustomerServiceVC()
                    vc.title = LanguageHelper.getString(key: "me_customer_service")
                    self.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(vc, animated: true)
                    self.hidesBottomBarWhenPushed = false
                case 3:
                    Alert.show(title: LanguageHelper.getString(key: "me_like_not"))
                case 4:
                    let vc = SettingsVC()
                    vc.title = LanguageHelper.getString(key: "me_settings")
                    self.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(vc, animated: true)
                    self.hidesBottomBarWhenPushed = false
                default:
                    break
                }
            }
        }
    }
    
    @objc func avatarBtnTapped() {
        print("avatar image tapped...")
        
        let vc = UserInfoVC()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func quitBtnTapped() {
        print("quit btn tapped...")
        
        let vc = LoginRegsVC()
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true, completion: nil)
    }
    
}

class Cell: UIView {
    
    var cellTap: (() -> Void)?
    
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
        
        let tapGesture = UITapGestureRecognizer.init()
        tapGesture.numberOfTapsRequired = 1
        tapGesture.addTarget(self, action: #selector(tapGestureBtnTapped))
        
        self.addGestureRecognizer(tapGesture)
        
        imageV.added(into: self)
        imageV.snp.makeConstraints { (make) in
            make.width.height.equalTo(20)
            make.left.equalTo(15)
            make.centerY.equalToSuperview()
        }
        
        arrowImgV.ImageName("arrow")
        arrowImgV.added(into: self)
        arrowImgV.snp.makeConstraints { (make) in
            make.right.equalTo(-14)
            make.centerY.equalToSuperview()
            make.right.equalTo(-10)
        }
        
        titleLbl.FontColor(.PFMedium(16), UIColor.gray)
        titleLbl.added(into: self)
        titleLbl.snp.makeConstraints { (make) in
            make.left.equalTo(imageV.snp.right).offset(10)
            make.right.equalTo(-50)
            make.height.equalTo(50)
            make.centerY.equalToSuperview()
        }
    }
    
    @objc func tapGestureBtnTapped() {
        print("tapGestureBtnTapped...")
        
        cellTap?()
    }
}
