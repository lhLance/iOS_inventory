//
//  LanguageVC.swift
//  Fii
//
//  Created by Liu Tao on 2019/3/26.
//  Copyright © 2019 Liu Tao. All rights reserved.
//

import UIKit
import SnapKit

class LanguageVC: UIViewController {

    var tableView: UITableView?
    var dataArr: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        reloadData()
    }
    
    func setupView() {
        
        tableView = UITableView(frame: CGRect.zero, style: UITableView.Style.plain)
        tableView?.added(into: view)
        tableView?.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(MeLanguageCell.self, forCellReuseIdentifier: MeLanguageCell.identifier)
        tableView?.separatorStyle = .none
        tableView?.backgroundColor = UIColor.groupTableViewBackground
    }
    
    func reloadData() {
        
        dataArr = ["简体中文", "繁体中文", "English"]
    }

}

extension LanguageVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let temp = tableView.dequeueReusableCell(withIdentifier: MeLanguageCell.identifier),
            let cell = temp as? MeLanguageCell else {
                return UITableViewCell()
        }
        
        cell.title = dataArr?[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            LanguageHelper.shareInstance.setLanguage(language: "zh-Hans")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LanguageChanged"), object: nil)
            navigationController?.popViewController(animated: true)
        case 1:
            LanguageHelper.shareInstance.setLanguage(language: "zh-Hant")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LanguageChanged"), object: nil)
            navigationController?.popViewController(animated: true)
        case 2:
            LanguageHelper.shareInstance.setLanguage(language: "en")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LanguageChanged"), object: nil)
            navigationController?.popViewController(animated: true)
        default:
            break
        }
        
    }
    
    
}
