//
//  HelpVC.swift
//  Fii
//
//  Created by Liu Tao on 2019/3/20.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import UIKit

class HelpVC: UIViewController {

    var dataStrArr = [String]()
    var heightArr = [CGFloat]()
    
    var flags = [Bool]()
    
    lazy var tableView: UITableView = {
        let table = UITableView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.width, height: UIScreen.height - UIScreen.tabBarHeight), style: .grouped)
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = UIColor.white
        table.register(FAQTableViewCell.self, forCellReuseIdentifier: FAQTableViewCell.identifier)
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    func setupView() {
        
        view.backgroundColor = UIColor.white
        tableView.added(into: view)
        
        updateData()
    }
    
    func updateData() {
        
        let testStr = [
            "第一行",
            "很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行",
            "很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行很多行"
        ]
        dataStrArr.append(testStr[0])
        dataStrArr.append(testStr[1])
        dataStrArr.append(testStr[2])
        
        heightArr.append(testStr[0].ga_heightForComment(fontSize: 17, width: UIScreen.width - 30))
        heightArr.append(testStr[1].ga_heightForComment(fontSize: 17, width: UIScreen.width - 30))
        heightArr.append(testStr[2].ga_heightForComment(fontSize: 17, width: UIScreen.width - 30))
        (0 ..< 3).forEach { _ in
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
            return 100 + heightArr[indexPath.row]
        }
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let temp = tableView.dequeueReusableCell(withIdentifier: FAQTableViewCell.identifier),
            let cell = temp as? FAQTableViewCell else {
                return UITableViewCell()
            }
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.green
        cell.contentStr = dataStrArr[indexPath.row]
        cell.openButton.isSelected = flags[indexPath.row]
        
        cell.clickOpenAction = { [unowned self] isSelected in
            cell.openButton.isSelected = isSelected
            self.flags[indexPath.item] = isSelected
            
            tableView.reloadRows(at: [indexPath], with: .fade)
        }

        return cell
    }
    
}
