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
        let table = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.width, height: UIScreen.height), style: .grouped)
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

    func setupView() {
        
        view.backgroundColor = UIColor.white
        tableView.added(into: view)
        
        updateData()
    }
    
    func updateData() {
        
        let testStr = [
            ["Fii是一家什么样的公司？", "Fii是全球领先的通信网络设备、云服务设备、精密工具及工业机器人专业设计制造服务商，为客户提供以工业互联网平台为核心的新形态电子设备产品智能制造服务。致力于为企业提供以自动化、网络化、平台化、大数据为基础的科技服务综合解决方案，引领传统制造向智能制造的转型;并以此为基础构建云计算、移动终端、物联网、大数据、人工智能、高速网络和机器人为技术平台的“先进制造+工业互联网”新生态。"],
            ["Fii主要从事什么工作？","公司主要从事各类电子设备产品的设计、研发、制造与销售业务，依托于工业互联网为全球知名客户提供智能制造和科技服务解决方案。公司主要产品涵盖通信网络设备、云服务设备、精密工具和工业机器人。相关产品主要应用于智能手机、宽带和无线网络、多媒体服务运营商的基础建设、电信运营商的基础建设、互联网增值服务商所需终端产品、企业网络及数据中心的基础建设以及精密核心零组件的自动化智能制造等。"],
            ["Fii的产品与服务是什么？","公司主要提供5大方向的解决方案服务：工业互联网、工业机器人、精密工具、通讯网络设备、云服务设备"]
        ]
        
        titleStrArr.append(testStr[0][0])
        titleStrArr.append(testStr[1][0])
        titleStrArr.append(testStr[2][0])
        
        dataStrArr.append(testStr[0][1])
        dataStrArr.append(testStr[1][1])
        dataStrArr.append(testStr[2][1])
        
        heightArr.append(testStr[0][1].ga_heightForComment(fontSize: 17, width: UIScreen.width - 30))
        heightArr.append(testStr[1][1].ga_heightForComment(fontSize: 17, width: UIScreen.width - 30))
        heightArr.append(testStr[2][1].ga_heightForComment(fontSize: 17, width: UIScreen.width - 30))
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
        cell.questionStr = titleStrArr[indexPath.row]
        cell.contentStr = dataStrArr[indexPath.row]
        cell.openButton.isSelected = flags[indexPath.row]
        
        cell.clickOpenAction = { [unowned self] isSelected in
            cell.openButton.isSelected = isSelected
            self.flags[indexPath.item] = isSelected
            
            tableView.reloadRows(at: [indexPath], with: .fade)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.001
    }
    
    
}
