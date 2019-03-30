//
//  ChatDataSource.swift
//  Fii
//
//  Created by yetao on 2019/3/30.
//  Copyright © 2019 Liu Tao. All rights reserved.
//

import Foundation

/*
 数据提供协议
 */
protocol ChatDataSource
{
    /*返回对话记录中的全部行数*/
    func rowsForChatTable( _ tableView:ChatTableView) -> Int
    /*返回某一行的内容*/
    func chatTableView(_ tableView:ChatTableView, dataForRow:Int)-> MessageItem
}
