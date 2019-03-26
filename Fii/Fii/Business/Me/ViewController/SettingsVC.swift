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
    var datas = [(img: UIImage, name: String)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reloadData()
        setupSubviews()
    }
    
    @objc func reloadData() {
        
        datas = [
            (img: #imageLiteral(resourceName: "set_clear"), name: LanguageHelper.getString(key: "set_clearCache")),
            (img: #imageLiteral(resourceName: "set_update"), name: "检查更新"),
            (img: #imageLiteral(resourceName: "set_language"), name: "语言")
        ]
    }
    
    func setupSubviews() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadData),
                                               name: NSNotification.Name(rawValue: "LanguageChanged"),
                                               object: nil)
        
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
                LanguageHelper.shareInstance.setLanguage(langeuage: "zh-Hans")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LanguageChanged"), object: nil)
            case "Ch":
                APP.currentLanguage = .En
                cellArr[2].detailText = "English"
                LanguageHelper.shareInstance.setLanguage(langeuage: "en")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LanguageChanged"), object: nil)
            default:
                break
            }
        }
    }
}
