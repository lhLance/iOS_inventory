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
    
    var sView: UIScrollView?
    var stack: UIStackView?
    var cellArr = [MeSettingCell()]
    var datas = [(img: UIImage, name: String)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        sView = UIScrollView().then({ (s) in
            s.alwaysBounceVertical = true
            s.added(into: view)
            s.snp.makeConstraints({ (make) in
                make.edges.equalToSuperview()
            })
        })
        
        reloadData()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadData),
                                               name: NSNotification.Name(rawValue: "LanguageChanged"),
                                               object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupSubviews()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func reloadData() {
        
        datas = [
            (img: #imageLiteral(resourceName: "set_clear"), name: LanguageHelper.getString(key: "me_set_clearCache")),
            (img: #imageLiteral(resourceName: "set_update"), name: LanguageHelper.getString(key: "me_set_checkUpdate")),
            (img: #imageLiteral(resourceName: "set_language"), name: LanguageHelper.getString(key: "me_set_language"))
        ]
    }
    
    func setupSubviews() {
        
        stack?.removeFromSuperview()
        stack = UIStackView().setup({ (stack) in
            stack.distribution = .fillEqually
            stack.axis = .vertical
            stack.added(into: sView ?? view).snp.makeConstraints({
                $0.left.right.equalTo(0)
                $0.top.equalTo(0)
            })
            
            cellArr.removeAll()
            cellArr.append(cacheCell)
            cellArr.append(checkUpdateCell)
            cellArr.append(languageCell)
            
            for (i, data) in datas.enumerated() {
                cellArr[i] = MeSettingCell(img: data.img, title: data.name)
                if i == 0 {
                    let size = FileCache.fileSizeOfCache()
                    cellArr[i].detailText = LanguageHelper.getString(key: "me_set_cache_size")  + " \(size)MB"
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
            Alert.show(title: LanguageHelper.getString(key: "me_set_click_clear_cache"), message: nil) {
                FileCache.clearCache()
                let size = FileCache.fileSizeOfCache()
                self.cellArr[0].detailText = "\(LanguageHelper.getString(key: "me_set_cache_size")): \(size)MB"
            }
        case .checkVersion:
            // 本地版本 vs 服务器版本
            if APP.version >= 1 {
                Alert.show(title: LanguageHelper.getString(key: "me_set_newest_version"))
            } else {
                Alert.show(title: LanguageHelper.getString(key: "me_set_update_version"))
            }
        case .language:
            
            let vc = LanguageVC()
            vc.title = LanguageHelper.getString(key: "me_set_language")
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
