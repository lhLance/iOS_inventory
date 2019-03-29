//
//  CloumnCategoryMenuTableController.swift
//  Fii
//
//  Created by yetao on 2019/3/13.
//  Copyright © 2019 Liu Tao. All rights reserved.
//


public let  kCategoryNotification  = "kCategoryNotification"

private let cellId = "cellId"
private let GlobalColor = colorWithRGBA(red: 242, green: 248, blue: 250, alpha: 1.0)

import UIKit
class CloumnCategoryMenuTableController:UITableViewController{

    private var firstCategoryTitleMArr = [String]()
    private var catelogyList = [String]()
    private var selectedIndexPath = NSIndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitData()
        setUpUI()
    }
}

extension CloumnCategoryMenuTableController{
    private func setInitData()
    {
        for index in 0...30
        {
            catelogyList.append(String(index))
        }
    }
    
    private func setUpUI()
    {
        tableView.backgroundColor = GlobalColor
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.showsVerticalScrollIndicator = false
        tableView.bounces = false
        tableView.register(CloumnFirstCategorTableViewCell.self, forCellReuseIdentifier: cellId)

        tableView.delegate = self
        tableView.dataSource = self
    }

    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return catelogyList.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CloumnFirstCategorTableViewCell
        cell.detailLab.text = String(indexPath.row)
        cell.detailLab.textColor = UIColor.orange
        cell.cellView.backgroundColor = UIColor.purple
        // Configure the cell...
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue:"isTest"),
                                        object:nil,
                                        userInfo:["one":indexPath.section , "two":indexPath.row])
    }
    
}
