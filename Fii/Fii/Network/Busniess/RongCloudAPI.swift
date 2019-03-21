//
//  RongCloudAPI.swift
//  Fii
//
//  Created by Liu Tao on 2019/3/21.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import Foundation

final class RongCloudAPI {
    
    static func getToken(userId: String,
                         name: String,
                         portraitUri: String,
                         _ callBack:@escaping (FiiRongCloudModel) -> Void)
    {
        let api = "http://api-cn.ronghub.com/user/getToken.[json]"
        let param: [String: Any] = ["userId": userId, "name": name, "portraitUri": portraitUri]
        
        APIManager.post(api: api, params: param, headers: nil) { (true, json, error) in
            if let model = json?.toModel(FiiRongCloudModel.self) {
                callBack(model)
            } else {
                callBack(FiiRongCloudModel())
            }
        }
    }
}
