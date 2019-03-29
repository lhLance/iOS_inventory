//
//  HelpVC.swift
//  Fii
//
//  Created by Liu Tao on 2019/3/20.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import UIKit

class HelpVC: UIViewController {

    var titleStrArr = [String]()
    var dataStrArr = [String]()
    var heightArr = [CGFloat]()
    
    var flags = [Bool]()
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: UIScreen.width,
                                              height: UIScreen.height),
                                style: .plain)
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = UIColor.groupTableViewBackground
        table.register(FAQTableViewCell.self, forCellReuseIdentifier: FAQTableViewCell.identifier)
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setupView() {
        
        view.backgroundColor = UIColor.white
        tableView.added(into: view)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateData),
                                               name: NSNotification.Name(rawValue: "LanguageChanged"),
                                               object: nil)
    }
    
    @objc func updateData() {
        
        let testStr = [
            
            [LanguageHelper.getString(key: "me_help_question1_title"), LanguageHelper.getString(key: "me_help_question1_text")],
            [LanguageHelper.getString(key: "me_help_question2_title"), LanguageHelper.getString(key: "me_help_question2_text")],
            [LanguageHelper.getString(key: "me_help_question3_title"), LanguageHelper.getString(key: "me_help_question3_text")],
            [LanguageHelper.getString(key: "me_help_question4_title"), LanguageHelper.getString(key: "me_help_question4_text")],
            [LanguageHelper.getString(key: "me_help_question5_title"), LanguageHelper.getString(key: "me_help_question5_text")]
        ]
        
        titleStrArr.removeAll()
        dataStrArr.removeAll()
        heightArr.removeAll()
        flags.removeAll()
        
        for item in testStr {
            titleStrArr.append(item[0])
        }

        for item in testStr {
            dataStrArr.append(item[1])
        }
        
        for item in testStr {
            heightArr.append(item[1].ga_heightForComment(fontSize: 17, width: UIScreen.width - 52))
        }
        
        (0 ..< testStr.count).forEach { _ in
            flags.append(false)
        }
        
        tableView.reloadData()
    }
}

extension HelpVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataStrArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if flags[indexPath.row] {
            return 110 + heightArr[indexPath.row]
        }
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let temp = tableView.dequeueReusableCell(withIdentifier: FAQTableViewCell.identifier),
            let cell = temp as? FAQTableViewCell else {
                return UITableViewCell()
            }
        cell.selectionStyle = .none
        cell.questionStr = titleStrArr[indexPath.row]
        cell.contentStr = dataStrArr[indexPath.row]
        cell.openButton.isSelected = flags[indexPath.row]
        
        cell.clickOpenAction = { [unowned self] isSelected in
            cell.openButton.isSelected = isSelected
            self.flags[indexPath.row] = isSelected

            tableView.reloadRows(at: [indexPath], with: .fade)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! FAQTableViewCell
        
        cell.openButton.isSelected = !cell.openButton.isSelected
        flags[indexPath.row] = cell.openButton.isSelected
        
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.001
    }
    
}
