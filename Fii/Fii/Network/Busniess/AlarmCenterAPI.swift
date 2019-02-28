//
//  AlarmCenterAPI.swift
//  Fii
//
//  Created by Liu Tao on 2019/2/26.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import Foundation

final class AlarmCenterAPI {
    
    /// 登陆后获取APP key
    static func GetAPPKey(userName: String, password: String, _ callBack: @escaping (FIIServiceModel) -> Void) {
        
        let api = "/api/server/getkey"
        let param: [String: Any] = ["username": userName, "userpwd": password]
        
        APIManager.post(api: api, params: param) { (true, json, error) in
            if let model = json?.toModel(FIIServiceModel.self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 获取 AlarmCenter 版本号
    static func GetVersion(_ callBack: @escaping (String) -> Void) {
        
        let api = "/api/server/version"
        
        APIManager.get(api: api) { (true, json, error) in
            if let model = json?.stringValue {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 获取软件授权程序
    static func GetAuthName(appKey: String, infoKey: String, _ callBack: @escaping (String) -> Void) {
        
        let api = "/api/server/auth_name"
        let headers: [String: String] = ["Authorization": appKey + "-" + infoKey]
        
        APIManager.get(api: api, headers: headers) { (true, json, error) in
            if let model = json?.stringValue {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 获取事件报警配置
    static func GetAlarmConfig(appKey: String, infoKey: String, _ callBack: @escaping ([FIIAlarmConfigModel]) -> Void) {
        let api = "/api/event/alarm_config"
        let headers: [String: String] = ["Authorization": appKey + "-" + infoKey]

        APIManager.post(api: api, headers: headers) { (true, json, error) in
            if let model = json?.toModel([FIIAlarmConfigModel].self) {
                callBack(model)
            } else {
                print("redieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 获取系统报警实时事件
    static func GetAlarmRealEvent(appKey: String, infoKey: String, levels: String, _ callBack: @escaping([FIIAlarmRealEventModel]) -> Void) {
        let api = "/api/event/real_evt"
        let headers: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let params: [String: Any] = ["levels": levels]
        
        APIManager.post(api: api, params: params, headers: headers) { (true, json, error) in
            if let model = json?.toModel([FIIAlarmRealEventModel].self) {
                callBack(model)
            } else {
                print("redieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 获取系统报警实时事件数
    static func GetAlarmEventCount(appKey: String, infoKey: String, levels: String, _ callBack: @escaping(String) -> Void) {
        let api = "/api/event/real_evt_count"
        let headers: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let params: [String: Any] = ["levels": levels]
        
        APIManager.post(api: api, params: params, headers: headers) { (true, json, error) in
            if let model = json?.stringValue {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 确认当前报警事件
    static func ConfirmAlarmEvent(appKey: String,
                                  infoKey: String,
                                  msg: String?,
                                  shortMsg: String?,
                                  tel: String?,
                                  evtName: String,
                                  time: String,
                                  _ callBack: @escaping(Bool) -> Void)
    {
        let api = "/api/event/confirm_evt"
        let headers: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let params: [String: Any] = ["msg": msg ?? "",
                                     "shortmsg": shortMsg ?? "",
                                     "tel": tel ?? "",
                                     "evtname": evtName,
                                     "time": time]
        
        APIManager.post(api: api,
                        params: params,
                        headers: headers) { (true, json, error) in
                            if let model = json?.boolValue {
                                callBack(model)
                            } else {
                                print("recieved data = \(String(describing: json))")
                            }
        }
        
    }
    
    /// 查询设备事件
    static func GetEquipmentEvent(appKey: String,
                                  infoKey: String,
                                  times: String,
                                  equipNums: String,
                                  _ callBack: @escaping([FIIEquipEventModel]) -> Void)
    {
        let api = "/api/event/get_equip_evt"
        let headers: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let params: [String: Any] = ["times": times, "equip_nos": equipNums]
        
        APIManager.post(api: api, params: params, headers: headers) { (true, json, error) in
            if let model = json?.toModel([FIIEquipEventModel].self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
        
    }
    
    /// 查询设置事件
    static func GetSettingsEvent(appKey: String,
                                 infoKey: String,
                                 times: String,
                                 equipNums: String,
                                 _ callBack: @escaping([FIIEquipSettingsModel]) -> Void)
    {
        let api = "/api/event/get_set_evt"
        let headers: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let params: [String: Any] = ["times": times, "equip_nos": equipNums]
        
        APIManager.post(api: api, params: params, headers: headers) { (true, json, error) in
            if let model = json?.toModel([FIIEquipSettingsModel].self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
}
