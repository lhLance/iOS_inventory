//
//  AlarmCenterAPI.swift
//  Fii
//
//  Created by Liu Tao on 2019/2/26.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import Foundation

final class AlarmCenterAPI {
    
    static func GetAPPKey(userName: String, password: String, _ callBack: @escaping (FIIServiceModel) -> Void) {
        
        let api = "/api/server/getkey"
        let param: [String: Any] = ["username": userName, "userpwd": password]
        
        APIManager.post(api: api, params: param) { (value, json, error) in
            if value {
                if let model = json?.toModel(FIIServiceModel.self) {
                    callBack(model)
                }
            } else {
                print(error ?? "error")
            }
        }
    }
    
    static func GetVersion(_ callBack: @escaping (String) -> Void) {
        
        let api = "/api/server/version"
        
        APIManager.get(api: api) { (value, json, error) in
            if value {
                if let model = json?.toModel(String.self) {
                    callBack(model)
                }
            } else {
                print(error ?? "error")
            }
        }
    }
    
    static func GetAuthName(appKey: String, infoKey: String, _ callBack: @escaping (String) -> Void) {
        
        let api = "/api/server/auth_name"
        let headers: [String: String] = ["Authorization": "\(appKey)-\(infoKey)"]
        
        APIManager.get(api: api, params: nil, headers: headers) { (value, json, error) in
            if value {
                if let model = json?.toModel(String.self) {
                    callBack(model)
                }
            } else {
                print(error ?? "error")
            }
        }
    }
    
}
