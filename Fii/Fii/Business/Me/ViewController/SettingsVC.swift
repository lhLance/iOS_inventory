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
    let languageCell = MeSettingCell()
    
    var cellArr = [MeSettingCell()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
    }
    
    func setupSubviews() {
        
        view.backgroundColor = UIColor.white
        
        let sView = UIScrollView().then({ (s) in
            s.alwaysBounceVertical = true
            s.added(into: view)
            s.snp.makeConstraints({ (make) in
                make.edges.equalToSuperview()
            })
        })
        
        _ = UIStackView().setup({ (stack) in
            stack.distribution = .fillEqually
            stack.axis = .vertical
            stack.added(into: sView).snp.makeConstraints({
                $0.left.right.equalTo(0)
                $0.top.equalTo(0)
            })
            
            let datas = [
                (img: #imageLiteral(resourceName: "set_clear"), name: "清理缓存"),
                (img: #imageLiteral(resourceName: "set_update"), name: "检查更新"),
                (img: #imageLiteral(resourceName: "set_language"), name: "语言")
                ]
            cellArr.append(cacheCell)
            cellArr.append(checkUpdateCell)
            cellArr.append(languageCell)
            
            for (i, data) in datas.enumerated() {
                cellArr[i] = MeSettingCell(img: data.img, title: data.name)
                if i == 0 {
                    let size = FileCache.fileSizeOfCache()
                    cellArr[i].detailText = "缓存大小: \(size)MB"
                } else if i == 2 {
                    cellArr[i].detailText = APP.currentLanguage.rawValue == "En" ? "English" : "中文"
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
        case language = 2
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
        case .language:
            switch APP.currentLanguage.rawValue {
            case "En":
                APP.currentLanguage = .Ch
                cellArr[2].detailText = "中文"
            case "Ch":
                APP.currentLanguage = .En
                cellArr[2].detailText = "English"
            default:
                break
            }
        }
    }
}
