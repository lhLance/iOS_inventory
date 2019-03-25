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
        
        setupSubviews()
    }
    
    func setupSubviews() {
        
        view.backgroundColor = UIColor.white
        
        _ = UIStackView.init().setup({ (stack) in
            stack.distribution = .fillEqually
            stack.axis = .vertical
            stack.becomeSubviewIn(self.view).snp.makeConstraints {
                $0.left.right.equalTo(0)
                $0.top.equalTo(UIScreen.navBarHeight)
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
            // 本地版本 vs 服务器版本
            if APP.version >= 1 {
                Alert.show(title: "当前已是最新版本")
            } else {
                Alert.show(title: "版本较低，请更新")
            }
            break
        }
    }
}
