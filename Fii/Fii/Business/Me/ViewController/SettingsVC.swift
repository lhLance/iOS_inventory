//
//  SettingsVC.swift
//  Fii
//
//  Created by Liu Tao on 2019/3/23.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    
    let avatar = UIImageView()
    let infoLabel = UILabel()
    let cacheCell = MeSettingCell()
    let checkUpdateCell = MeSettingCell()
    
    var cellArr = [MeSettingCell()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "设置"
        setupSubviews()
    }
    
    func setupSubviews() {
        let header = UIView.init().setup { (v) in
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(gotoUserInfoVC))
            v.addGestureRecognizer(tap)
            v.backgroundColor = UIColor.white
            v.becomeSubviewIn(view)
            v.snp.makeConstraints {
                $0.top.equalTo(0)
                $0.left.right.equalTo(0)
                $0.height.equalTo(96)
            }
            
            _ = UIView.init().setup({ (line) in
                line.backgroundColor = UIColor.hex(0xE3E6F4)
                line.becomeSubviewIn(v).snp.makeConstraints {
                    $0.left.right.bottom.equalTo(0)
                    $0.height.equalTo(0.5)
                }
            })
            
            let _ = UIButton.init(type: .custom).setup({ (btn) in
                btn.addTarget(self, action: #selector(gotoSetMeInfo), for: .touchUpInside)
                btn.backgroundColor = UIColor.green
                btn.becomeSubviewIn(v)
                btn.snp.makeConstraints {
                    $0.centerY.equalToSuperview()
                    $0.right.equalTo(-15)
                }
            })
        }
        
        
        _ = UIStackView.init().setup({ (stack) in
            stack.distribution = .fillEqually
            stack.axis = .vertical
            stack.becomeSubviewIn(self.view).snp.makeConstraints {
                $0.left.right.equalTo(0)
                $0.top.equalTo(header.snp.bottom)
            }
            
            let datas = [
                (img: #imageLiteral(resourceName: "set_clear"), name: "清理缓存"),
                (img: #imageLiteral(resourceName: "set_update"), name: "检查更新")
                ]
            cellArr.append(cacheCell)
            cellArr.append(checkUpdateCell)
            
            for (i, data) in datas.enumerated() {
                cellArr[i] = MeSettingCell.init(img: data.img, title: data.name)
                if i == 0 {
                    let size = FileCache.fileSizeOfCache()
                    cellArr[i].detailText = "缓存大小: \(size)MB"
                }
                cellArr[i].tag = i
                cellArr[i].tap.addTarget(self, action: #selector(handleUserAction(_:)))
                stack.addArrangedSubview(cellArr[i])
            }
        })
    }
}

extension SettingsVC {
    
    @objc func gotoUserInfoVC() {
        
    }
    
    @objc func gotoSetMeInfo() {
        
    }
    
    enum UserAction: Int {
        case cleanCache = 0
        case checkVersion = 1
    }
    
    @objc func handleUserAction(_ ges: UITapGestureRecognizer) {
    let action = UserAction(rawValue: ges.view!.tag)!
        switch action {
        case .cleanCache:
            Alert.show(title: "点击清除", message: nil) {
                FileCache.clearCache()
                let size = FileCache.fileSizeOfCache()
                self.cellArr[0].detailText = "缓存大小: \(size)MB"
            }
        case .checkVersion:
            break
        }
    }
}
