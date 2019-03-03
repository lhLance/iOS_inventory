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
    
    /// 查询系统事件
    static func GetSystemEvent(appKey: String,
                               infoKey: String,
                               times: String,
                               _ callBack: @escaping([FIISystemEventModel]) -> Void)
    {
        let api = "/api/event/get_sys_evt"
        let headers: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let params: [String: Any] = ["times": times]
        
        APIManager.post(api: api, params: params, headers: headers) { (true, json, error) in
            if let model = json?.toModel([FIISystemEventModel].self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
        
    }
    
    /// 获取所有设备的节点列表
    static func GetEquipList(appKey: String,
                             infoKey: String,
                             _ callBack: @escaping(FIIEquipListModel) -> Void)
    {
        let api = "/api/real/equip_tree"
        let headers: [String: String] = ["Authorization": appKey + "-" + infoKey]
        
        APIManager.post(api: api, headers: headers) { (true, json, error) in
            if let model = json?.toModel(FIIEquipListModel.self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 获取所有设备的实时状态
    static func GetEquipState(appKey: String,
                              infoKey: String,
                              _ callBack: @escaping(FIIEquipRealStateModel) -> Void)
    {
        let api = "/api/real/equip_state"
        let headers: [String: String] = ["Authorization": appKey + "-" + infoKey]
        
        APIManager.post(api: api, params: nil, headers: headers) { (true, json, error) in
            if let model = json?.toModel(FIIEquipRealStateModel.self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 获取当前设备的所有测点状态
    static func GetEquipItemState(appKey: String,
                                  infoKey: String,
                                  equip_no: String,
                                  _ callBack: @escaping(FIIEquipmentItemStateModel) -> Void)
    {
        let api = "/api/real/equip_item_state"
        let headers: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let params: [String: Any] = ["equip_no": equip_no]
        
        APIManager.post(api: api, params: params, headers: headers) { (true, json, error) in
            if let model = json?.toModel(FIIEquipmentItemStateModel.self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 获取当前设备模拟量测点的状态
    static func GetEquipYcpState(appKey: String,
                                 infoKey: String,
                                 equip_no: String,
                                 ycp_no: String,
                                 _ callBack: @escaping(FIIEquipmentItemStateModel) -> Void)
    {
        let api = "/api/real/equip_ycp_state"
        let headers: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let params: [String: Any] = ["equip_no": equip_no, "ycp_no": ycp_no]
        
        APIManager.post(api: api, params: params, headers: headers) { (true, json, error) in
            if let model = json?.toModel(FIIEquipmentItemStateModel.self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 执行表达式
    static func ExpreEval(appKey: String,
                          infoKey: String,
                          expression: String,
                          _ callBack: @escaping(Int) -> Void)
    {
        let api = "/api/real/expre_eval"
        let headers: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let params: [String: Any] = ["expression": expression]
        
        APIManager.post(api: api, params: params, headers: headers) { (true, json, error) in
            if let model = json?.intValue {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 模拟量(ycp)历史数据
    static func GetYcpHistory(appKey: String,
                              infoKey: String,
                              beginTime: String,
                              endTime: String,
                              equipNo: String,
                              ycpNo: String,
                              _ callBack: @escaping([FIIYCPHistoryModel]) -> Void)
    {
        let api = "/api/real/get_ycp_history"
        let headers: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let params: [String: Any] = ["begin_time": beginTime,
                                     "end_time": endTime,
                                     "equip_no": equipNo,
                                     "ycp_no": ycpNo]
        
        APIManager.post(api: api, params: params, headers: headers) { (true, json, error) in
            if let model = json?.toModel([FIIYCPHistoryModel].self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 设备控制命令
    static func EquipControl(appKey: String,
                             infoKey: String,
                             equip_no: String,
                             set_no: String,
                             _ callBack: @escaping(EquipControlModel) -> Void)
    {
        let api = "/api/real/setup"
        let headers: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let params: [String: Any] = ["equip_no": equip_no, "set_no": set_no]
        
        APIManager.post(api: api, params: params, headers: headers) { (true, json, error) in
            if let model = json?.toModel(EquipControlModel.self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 设备控制命令 b
    static func EquipControl_B(appKey: String,
                             infoKey: String,
                             equip_no: String,
                             set_no: String,
                             value: String,
                             _ callBack: @escaping(EquipControlModel) -> Void)
    {
        let api = "/api/real/setup_b"
        let headers: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let params: [String: Any] = ["equip_no": equip_no, "set_no": set_no, "value": value]
        
        APIManager.post(api: api, params: params, headers: headers) { (true, json, error) in
            if let model = json?.toModel(EquipControlModel.self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 设备控制命令 c
    static func EquipControl_C(appKey: String,
                               infoKey: String,
                               equip_no: String,
                               mainInstr: String,
                               minoInstr: String,
                               value: String,
                               type: String,
                               _ callBack: @escaping(EquipControlModel) -> Void)
    {
        let api = "/api/real/setup_c"
        let headers: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let params: [String: Any] = ["equip_no": equip_no,
                                     "main_instr": mainInstr,
                                     "mino_instr": minoInstr,
                                     "value": value,
                                     "type": type]
        
        APIManager.post(api: api, params: params, headers: headers) { (true, json, error) in
            if let model = json?.toModel(EquipControlModel.self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
}
