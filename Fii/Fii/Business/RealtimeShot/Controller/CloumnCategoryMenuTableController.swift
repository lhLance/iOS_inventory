//
//  CloumnCategoryMenuTableController.swift
//  Fii
//
//  Created by yetao on 2019/3/13.
//  Copyright © 2019 Liu Tao. All rights reserved.
//

//#define LQColorA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
//
//private #define LQGlobalColor LQColorA(242, 248, 250, 1);


public let  kCategoryNotification  = "kCategoryNotification";

private let cellId = "cellId";
private let GlobalColor = colorWithRGBA(red: 242, green: 248, blue: 250, alpha: 1.0)

import UIKit
class CloumnCategoryMenuTableController:UITableViewController{

    private var firstCategoryTitleMArr = [String]();
    private var catelogyList = [String]();
    private var selectedIndexPath = NSIndexPath();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = GlobalColor;
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none;
        self.tableView.showsVerticalScrollIndicator = false;
        self.tableView.bounces = false;
        self.tableView.register(CloumnFirstCategorTableViewCell.self, forCellReuseIdentifier: cellId);
        for index in 0...30
        {
            catelogyList.append(String(index));
        }
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.reloadData();
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return catelogyList.count;
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55;
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CloumnFirstCategorTableViewCell
        cell.detailLab.text = String(indexPath.row)
        cell.detailLab.textColor = UIColor.orange;
        cell.cellView.backgroundColor = UIColor.purple;
        // Configure the cell...
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.scrollToNearestSelectedRow(at: UITableView.ScrollPosition.top, animated: false);
        NotificationCenter.default.post(name: NSNotification.Name(rawValue:"s"), object:nil, userInfo:["one":String(indexPath.section), "two":String(indexPath.row)])
    }
    
}

//NotificationCenter.default.addObserver(self, selector: #selector(testNotice), name: NSNotification.Name(), object: nil);
