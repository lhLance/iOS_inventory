//
//  AlarmCenterAPI.swift
//  Fii
//
//  Created by Liu Tao on 2019/2/26.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import Foundation
import UIKit

final class AlarmCenterAPI {
    
    /// 登陆后获取APP key
    static func GetAPPKey(userName: String,
                          password: String,
                          _ callBack: @escaping (FIIServiceModel) -> Void)
    {
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
    static func GetAlarmConfig(appKey: String,
                               infoKey: String,
                               _ callBack: @escaping ([FIIAlarmConfigModel]) -> Void)
    {
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
    static func GetAlarmRealEvent(appKey: String,
                                  infoKey: String,
                                  levels: String,
                                  _ callBack: @escaping([FIIAlarmRealEventModel]) -> Void)
    {
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
    static func GetAlarmEventCount(appKey: String,
                                   infoKey: String,
                                   levels: String,
                                   _ callBack: @escaping(String) -> Void)
    {
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
                             _ callBack: @escaping(FiiEquipControlModel) -> Void)
    {
        let api = "/api/real/setup"
        let headers: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let params: [String: Any] = ["equip_no": equip_no, "set_no": set_no]
        
        APIManager.post(api: api, params: params, headers: headers) { (true, json, error) in
            if let model = json?.toModel(FiiEquipControlModel.self) {
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
                             _ callBack: @escaping(FiiEquipControlModel) -> Void)
    {
        let api = "/api/real/setup_b"
        let headers: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let params: [String: Any] = ["equip_no": equip_no, "set_no": set_no, "value": value]
        
        APIManager.post(api: api, params: params, headers: headers) { (true, json, error) in
            if let model = json?.toModel(FiiEquipControlModel.self) {
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
                               _ callBack: @escaping(FiiEquipControlModel) -> Void)
    {
        let api = "/api/real/setup_c"
        let headers: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let params: [String: Any] = ["equip_no": equip_no,
                                     "main_instr": mainInstr,
                                     "mino_instr": minoInstr,
                                     "value": value,
                                     "type": type]
        
        APIManager.post(api: api, params: params, headers: headers) { (true, json, error) in
            if let model = json?.toModel(FiiEquipControlModel.self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 获取设备配置信息
    static func GetEquipConfig(appKey: String,
                               infoKey: String,
                               equipNos: String,
                               _ callBack: @escaping([FiiEquipConfigModel]) -> Void)
    {
        let api = "/api/real/get_equip"
        let headers: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let params: [String: Any] = ["equip_nos": equipNos]
        
        APIManager.post(api: api,
                        params: params,
                        headers: headers) { (true, json, error) in
                            if let model = json?.toModel([FiiEquipConfigModel].self)
                            {
                                callBack(model)
                            } else {
                                print("recieved data = \(String(describing: json))")
                            }
        }
    }
    
    /// 获取模拟量配置信息
    static func GetYCPConfig(appKey: String,
                             infoKey: String,
                             equipNos: String,
                             _ callBack: @escaping([FiiYCPConfigModel]) -> Void)
    {
        let api = "/api/real/get_ycp"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let params: [String: Any] = ["equip_nos": equipNos]
        
        APIManager.post(api: api, params: params, headers: header) { (true, json, error) in
            if let model = json?.toModel([FiiYCPConfigModel].self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 获取状态量配置信息
    static func GetFiiYXPConfig(appKey: String,
                             infoKey: String,
                             equipNos: String,
                             _ callBack: @escaping([FiiYXPConfig]) -> Void)
    {
        
        let api = "/api/real/get_yxp"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let params: [String: Any] = ["equip_nos": equipNos]
        
        APIManager.post(api: api, params: params, headers: header) { (true, json, error) in
            if let model = json?.toModel([FiiYXPConfig].self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 获取设置配置信息
    static func GetSetParam(appKey: String,
                            infoKey: String,
                            equipNos: String,
                            _ callBack: @escaping([FiiYXPConfig]) -> Void)
    {
        let api = "/api/real/get_setparm"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let params: [String: Any] = ["equip_nos": equipNos]
        
        APIManager.post(api: api, params: params, headers: header) { (true, json, error) in
            if let model = json?.toModel([FiiYXPConfig].self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 获取单个测点的模拟量配置信息
    static func GetYCPSingle(appKey: String,
                             infoKey: String,
                             equipNo: String,
                             ycpNo: String,
                             _ callBack: @escaping([FiiYCPConfigModel]) -> Void)
    {
        let api = "/api/real/get_ycp_single"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let params: [String: Any] = ["equip_no": equipNo, "ycp_no": ycpNo]
        
        APIManager.post(api: api, params: params, headers: header) { (true, json, error) in
            if let model = json?.toModel([FiiYCPConfigModel].self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 获取单个测点的状态量配置信息
    static func GetYXPSingle(appKey: String,
                             infoKey: String,
                             equipNo: String,
                             yxpNo: String,
                             _ callBack: @escaping([FiiYXPConfig]) -> Void)
    {
        let api = "/api/real/get_yxp_single"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let params: [String: Any] = ["equip_no": equipNo, "yxp_no": yxpNo]
        
        APIManager.post(api: api, params: params, headers: header) { (true, json, error) in
            if let model = json?.toModel([FiiYXPConfig].self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 获取单个测点的设置配置信息
    static func GetSetParmSingle(appKey: String,
                                 infoKey: String,
                                 equipNo: String,
                                 setNo: String,
                                 _ callBack: @escaping([FiiSetParamModel]) -> Void)
    {
        let api = "/api/real/get_setparm_single"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let params: [String: Any] = ["equip_no": equipNo, "set_no": setNo]
        
        APIManager.post(api: api, params: params, headers: header) { (true, json, error) in
            if let model = json?.toModel([FiiSetParamModel].self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 修改设备配置信息
    static func UpdateEquipConfig(appKey: String, infoKey: String, update: String, _ callBack: @escaping(Int) -> Void)
    {
        let api = "/api/real/update_equip"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let params: [String: Any] = ["update": update]
        
        APIManager.post(api: api, params: params, headers: header) { (true, json, error) in
            if let model = json?.intValue {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
        
    }
    
    /// 修改模拟量配置信息
    static func UpdateYCPConfig(appKey: String, infoKey: String, update: String, _ callBack: @escaping(Int) -> Void)
    {
        let api = "/api/real/update_ycp"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let params: [String: Any] = ["update": update]
        
        APIManager.post(api: api, params: params, headers: header) { (true, json, error) in
            if let model = json?.intValue {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 修改状态量配置信息
    static func UpdateYXPConfig(appKey: String, infoKey: String, update: String, _ callBack: @escaping(Int) -> Void)
    {
        let api = "/api/real/update_yxp"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let params: [String: Any] = ["update": update]
        
        APIManager.post(api: api, params: params, headers: header) { (true, json, error) in
            if let model = json?.intValue {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 修改设置配置信息
    static func UpdateSetConfig(appKey: String, infoKey: String, update: String, _ callBack: @escaping(Int) -> Void)
    {
        let api = "/api/real/update_setparm"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let params: [String: Any] = ["update": update]
        
        APIManager.post(api: api, params: params, headers: header) { (true, json, error) in
            if let model = json?.intValue {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 语音控制命令(byte数据类型)
    static func VoiceByteControl(appKey: String, infoKey: String, dataByte: String, _ callBack: @escaping(String) -> Void)
    {
        let api = "/api/voice/voice_byte"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let params: [String: Any] = ["data_byte": dataByte]
        
        APIManager.post(api: api, params: params, headers: header) { (true, json, error) in
            if let model = json?.stringValue {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 语音控制命令(字符串数据类型)
    static func VoiceStrControl(appKey: String, infoKey: String, dataString: String, _ callBack: @escaping(String) -> Void)
    {
        let api = "/api/voice/voice_string"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let params: [String: Any] = ["data_string": dataString]
        
        APIManager.post(api: api, params: params, headers: header) { (true, json, error) in
            if let model = json?.stringValue {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 获取所有视频配置
    static func GetAllVideoConfig(appKey: String, infoKey: String, _ callBack: @escaping([FiiVideoConfigModel]) -> Void)
    {
        let api = "/api/video/video_config"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        
        APIManager.post(api: api, headers: header) { (true, json, error) in
            if let model = json?.toModel([FiiVideoConfigModel].self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 获取视频设备信息
    static func GetVideoDeiveInfo(appKey: String,
                                  infoKey: String,
                                  equipNo: String,
                                  _ callBack: @escaping([FiiVideoDevInfoModel]) -> Void)
    {
        let api = "/api/video/video_infor"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let params: [String: Any] = ["equip_no": equipNo]
        
        APIManager.post(api: api, params: params, headers: header) { (true, json, error) in
            if let model = json?.toModel([FiiVideoDevInfoModel].self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 生成用户二维码
    static func CreateQRCode(appKey: String, infoKey: String, _ callBack: @escaping(String) -> Void)
    {
        let api = "/api/qrcode/create_qrcode"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        
        APIManager.post(api: api, headers: header) { (true, json, error) in
            if let model = json?.stringValue {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 执行二维码数据
    static func ExcuteQRCode(appKey: String, infoKey: String, qrData: String, _ callBack: @escaping(Bool) -> Void)
    {
        let api = "/api/qrcode/excu_qrcode"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let params: [String: Any] = ["qr_data": qrData]
        
        APIManager.post(api: api, params: params, headers: header) { (true, json, error) in
            if let model = json?.boolValue {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 添加资产维护记录
    static func AddAssetsRecord(appKey: String,
                                infoKey: String,
                                zcid: String,
                                record: String,
                                file: UIImage,
                                _ callBack: @escaping(Bool) -> Void)
    {
        let api = "/api/assets/add_record"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let params: [String: Any] = ["zcid": zcid, "record": record, "file": file]
        
        APIManager.post(api: api, params: params, headers: header) { (true, json, error) in
            if let model = json?.boolValue {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 删除一条资产维护记录
    static func DeleteAssetsRecord(appKey: String,
                                   infoKey: String,
                                   zcid: String,
                                   _ callBack: @escaping(Bool) -> Void)
    {
        let api = "/api/assets/remove_record"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let params: [String: Any] = ["zcid": zcid]
        
        APIManager.post(api: api, params: params, headers: header) { (true, json, error) in
            if let model = json?.boolValue {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 设置资产图片
    static func SetAssetsImage(appKey: String,
                               infoKey: String,
                               zcid: String,
                               bs: String,
                               _ callBack: @escaping(Bool) -> Void)
    {
        let api = "/api/assets/setup_zcimg"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let params: [String: Any] = ["zcid": zcid, "bs": bs]
        
        APIManager.post(api: api, params: params, headers: header) { (true, json, error) in
            if let model = json?.boolValue {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 获取资产图片
    static func GetAssetsImage(appKey: String,
                               infoKey: String,
                               zcid: String,
                               _ callBack: @escaping(String) -> Void)
    {
        let api = "/api/assets/get_zcimg"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let params: [String: Any] = ["zcid": zcid]
        
        APIManager.post(api: api, params: params, headers: header) { (true, json, error) in
            if let model = json?.stringValue {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 获取系统功能组态页
    static func GetAdminModule(appKey: String,
                               infoKey: String,
                               _ callBack: @escaping([FiiGetAddinModuleModel]) -> Void)
    {
        let api = "/api/permis/get_addin_module"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        
        APIManager.post(api: api, headers: header) { (true, json, error) in
            if let model = json?.toModel([FiiGetAddinModuleModel].self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 获取设备功能组态页
    static func GetEquipPages(appKey: String, infoKey: String, _ callBack: @escaping([FiiGetEquipPagesModel]) -> Void)
    {
        let api = "/api/permis/get_equip_pages"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        
        APIManager.post(api: api, headers: header) { (true, json, error) in
            if let model = json?.toModel([FiiGetEquipPagesModel].self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 文件上传
    static func FileUpload(appKey: String, infoKey: String, address: String, _ callBack: @escaping([String]) -> Void)
    {
        let api = "/api/other/upload"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let param: [String: Any] = ["address": address]
        
        APIManager.post(api: api,
                        params: param,
                        headers: header) { (true, json, error) in
            if let model = json?.toModel([String].self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 实时快照
    static func GetLoopCycleList(appKey: String,
                                 infoKey: String,
                                 dataTableIndex: String,
                                 _ callBack: @escaping([FiiLoopTaskDetailModel]) -> Void)
    {
        let api = "/api/GWServiceWebAPI/get_LoopCycleList"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let param: [String: Any] = ["dataTableIndex": dataTableIndex]
        
        APIManager.post(api: api, params: param, headers: header) { (true, json, error) in
            if let model = json?.toModel([FiiLoopTaskDetailModel].self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 获取普通任务:设备控制
    static func GetCommonTaskEquipControl(appKey: String,
                                          infoKey: String,
                                          dataTableIndex: String,
                                          _ callBack: @escaping([FiiCommonTaskEquipControlModel]) -> Void)
    {
        let api = "/api/GWServiceWebAPI/get_CommonTaskEquipControl"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let param: [String: Any] = ["dataTableIndex": dataTableIndex]
        
        APIManager.post(api: api, params: param, headers: header) { (true, json, error) in
            if let model = json?.toModel([FiiCommonTaskEquipControlModel].self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 获取特殊日期安排数据
    static func GetSpecTableData(appKey: String,
                                 infoKey: String,
                                 dataTableIndex: String,
                                 _ callBack: @escaping([FiiSpecTableDataModel]) -> Void)
    {
        let api = "/api/GWServiceWebAPI/get_ProcSpecTableData"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        
        APIManager.post(api: api, headers: header) { (true, json, error) in
            if let model = json?.toModel([FiiSpecTableDataModel].self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 获取每周任务安排数据
    static func GetProcWeekTableData(appKey: String,
                                     infoKey: String,
                                     _ callBack: @escaping([FiiProcWeekTableDataModel]) -> Void)
    {
        let api = "/api/GWServiceWebAPI/get_ProcWeekTableData"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        
        APIManager.post(api: api, headers: header) { (true, json, error) in
            if let model = json?.toModel([FiiProcWeekTableDataModel].self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 获取循环任务数据
    static func GetProcCycleTListData(appKey: String,
                                      infoKey: String,
                                      _ callBack: @escaping([FiiProcCycleTListDataModel]) -> Void)
    {
        let api = "/api/GWServiceWebAPI/get_ProcCycleTListData"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        
        APIManager.post(api: api, headers: header) { (true, json, error) in
            if let model = json?.toModel([FiiProcCycleTListDataModel].self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 设备联动
    static func GetDataForListStr(appKey: String,
                                  infoKey: String,
                                  tType: String,
                                  equip_nos: String,
                                  yc_nos: String,
                                  _ callBack: @escaping(FiiDataForListStrModel) -> Void)
    {
        let api = "/api/GWServiceWebAPI/get_DataForListStr"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let param: [String: Any] = ["tType": tType, "equip_nos": equip_nos, "yc_nos": yc_nos]

        APIManager.post(api: api, params: param, headers: header) { (true, json, error) in
            if let model = json?.toModel(FiiDataForListStrModel.self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 获取设备联动配置列表
    static func GetLinkAgeList(appKey: String,
                               infoKey: String,
                               _ callBack: @escaping([FiiGetLinkageListModel]) -> Void)
    {
        let api = "/api/GWServiceWebAPI/getLinkageList"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        
        APIManager.post(api: api, headers: header) { (true, json, error) in
            if let model = json?.toModel([FiiGetLinkageListModel].self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 新增联动设置
    static func AddLinkAge(appKey: String,
                           infoKey: String,
                           id: Int,
                           equipNo: Int,
                           cType: String,
                           cNo: Int,
                           delay: Int,
                           linkEquipNo: Int,
                           linkNo: Int,
                           optCode: String,
                           remarks: String,
                           _ callBack: @escaping(Int) -> Void)
    {
        let api = "/api/GWServiceWebAPI/addLinkage"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let params: [String: Any] = ["id": id,
                                     "equipNo": equipNo,
                                     "cType": cType,
                                     "cNo": cNo,
                                     "delay": delay,
                                     "linkEquipNo": linkEquipNo,
                                     "linkNo": linkNo,
                                     "optCode": optCode,
                                     "remarks": remarks]
        
        APIManager.post(api: api, params: params, headers: header) { (true, json, error) in
            if let model = json?.intValue {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 删除联动设置
    static func DeleteLinkAge(appKey: String,
                              infoKey: String,
                              id: Int,
                              _ callBack: @escaping(Int) -> Void)
    {
        let api = "/api/GWServiceWebAPI/deleteLinkage"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let params: [String: Any] = ["id": id]
        
        APIManager.post(api: api, params: params, headers: header) { (true, json, error) in
            if let model = json?.intValue {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 修改联动设置
    static func UpdateLinkAge(appKey: String,
                              infoKey: String,
                              id: Int,
                              equipNo: Int,
                              cType: String,
                              cNo: Int,
                              delay: Int,
                              linkEquipNo: Int,
                              linkNo: Int,
                              optCode: String,
                              remarks: String,
                              _ callBack: @escaping(Int) -> Void)
    {
        let api = "/api/GWServiceWebAPI/updateLinkage"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let params: [String: Any] = ["id": id,
                                     "equipNo": equipNo,
                                     "cType": cType,
                                     "cNo": cNo,
                                     "delay": delay,
                                     "linkEquipNo": linkEquipNo,
                                     "linkNo": linkNo,
                                     "optCode": optCode,
                                     "remarks": remarks]
        
        APIManager.post(api: api, params: params, headers: header) { (true, json, error) in
            if let model = json?.intValue {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 新增场景
    static func AddScene(appKey: String,
                         infoKey: String,
                         equipNo: Int,
                         setNo: Int,
                         title: String,
                         _ callBack: @escaping(Int) -> Void)
    {
        let api = "/api/GWServiceWebAPI/addScene"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let params: [String: Any] = ["equipNo": equipNo,
                                     "setNo": setNo,
                                     "title": title]
        
        APIManager.post(api: api,
                        params: params,
                        headers: header) { (true, json, error) in
            if let model = json?.intValue {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 删除场景
    static func DeleteScene(appKey: String,
                            infoKey: String,
                            equipNo: Int,
                            setNo: Int,
                            _ callBack: @escaping(Int) -> Void)
    {
        let api = "/api/GWServiceWebAPI/deleteScene"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let params: [String: Any] = ["equipNo": equipNo,
                                     "setNo": setNo]
        
        APIManager.post(api: api, params: params, headers: header) { (true, json, error) in
            if let model = json?.intValue {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 修改场景设置
    static func updateScene(appKey: String,
                            infoKey: String,
                            equipNo: Int,
                            setNo: Int,
                            title: String,
                            _ callBack: @escaping(Int) -> Void)
    {
        let api = "/api/GWServiceWebAPI/updateScene"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let params: [String: Any] = ["equipNo": equipNo, "setNo": setNo, "title": title]
        
        APIManager.post(api: api, params: params, headers: header) { (true, json, error) in
            if let model = json?.intValue {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 获取报警排表数据
    static func GetAlarmReportData(appKey: String,
                                   infoKey: String,
                                   _ callBack: @escaping([FiiAlarmTBListModel]) -> Void)
    {
        let api = "/api/GWServiceWebAPI/get_AlmReportData"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        
        APIManager.post(api: api, headers: header) { (true, json, error) in
            if let model = json?.toModel([FiiAlarmTBListModel].self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 获取周排表数据
    static func GetWeekAlmReportData(appKey: String,
                                     infoKey: String,
                                     _ callBack: @escaping([FiiWeekAlmReportData]) -> Void)
    {
        let api = "/api/GWServiceWebAPI/get_WeekAlmReportData"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        
        APIManager.post(api: api, headers: header) { (true, json, error) in
            if let model = json?.toModel([FiiWeekAlmReportData].self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 获取特定日期排表数据
    static func GetSpecialAlarmReportData(appKey: String,
                                          infoKey: String,
                                          _ callBack: @escaping([FiiSpecialAlarmReportData]) -> Void)
    {
        let api = "/api/GWServiceWebAPI/get_SpeAlmReportData"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        
        APIManager.post(api: api, headers: header) { (true, json, error) in
            if let model = json?.toModel([FiiSpecialAlarmReportData].self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 清空字段
    static func NullTableCell(appKey: String, infoKey: String, _ callBack: @escaping(Int) -> Void) {
        let api = "/api/GWServiceWebAPI/nullTableCell"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        
        APIManager.post(api: api, headers: header) { (true, json, error) in
            if let model = json?.intValue {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 新增人员信息
    static func InsertEquipGroup(appKey: String,
                                 infoKey: String,
                                 ackLevel: Int,
                                 admin: Int,
                                 email: String,
                                 mobileTel: String,
                                 telPhone: String,
                                 getDataTable: String,
                                 ifName: String,
                                 ifValue: String,
                                 _ callBack: @escaping(Int) -> Void) {
        
        let api = "/api/GWServiceWebAPI/insertEquipGroup"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let params: [String: Any] = ["AckLevel": ackLevel,
                                     "Administrator": admin,
                                     "EMail": email,
                                     "MobileTel": mobileTel,
                                     "Telphone": telPhone,
                                     "getDataTable": getDataTable,
                                     "ifName": ifName,
                                     "ifValue": ifValue]
        
        APIManager.post(api: api, params: params, headers: header) { (true, json, error) in
            if let model = json?.intValue {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 删除设备分组范围数据
    static func DeleteEquipGroup(appKey: String,
                                 infoKey: String,
                                 type: String,
                                 getDataTable: String,
                                 ifName: String,
                                 ifValue: String,
                                 _ callBack: @escaping(Int) -> Void) {
        
        let api = "/api/GWServiceWebAPI/insertEquipGroup"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let params: [String: Any] = ["ifName": ifName,
                                     "getDataTable": getDataTable,
                                     "ifValue": ifValue,
                                     "type": type]
        
        APIManager.post(api: api, params: params, headers: header) { (true, json, error) in
            if let model = json?.intValue {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 获取报警排表信息
    static func GetAdministratorData(appKey: String,
                                     infoKey: String,
                                     _ callBack: @escaping([FiiAdministratorDataModel]) -> Void)
    {
        let api = "/api/GWServiceWebAPI/get_AdministratorData"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        
        APIManager.post(api: api, headers: header) { (true, json, error) in
            if let model = json?.toModel([FiiAdministratorDataModel].self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 获取资产列表
    static func GetGWZiChanTableData(appKey: String,
                                     infoKey: String,
                                     _ callBack: @escaping([FiiGWZiChanTableDataModel]) -> Void)
    {
        let api = "/api/GWServiceWebAPI/get_GWZiChanTableData"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        
        APIManager.post(api: api, headers: header) { (true, json, error) in
            if let model = json?.toModel([FiiGWZiChanTableDataModel].self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 获取视频信息数据
    static func GetVideoInfoData(appKey: String,
                                 infoKey: String,
                                 _ callBack: @escaping([FiiVideoInfoDataModel]) -> Void)
    {
        let api = "/api/GWServiceWebAPI/get_VideoInfoData"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        
        APIManager.post(api: api, headers: header) { (true, json, error) in
            if let model = json?.toModel([FiiVideoInfoDataModel].self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 获取报警信息数据
    static func GetAlramProData(appKey: String,
                                infoKey: String,
                                _ callBack: @escaping([FiiAlarmProcDataModel]) -> Void)
    {
        let api = "/api/GWServiceWebAPI/get_AlarmProcData"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        
        APIManager.post(api: api, headers: header) { (true, json, error) in
            if let model = json?.toModel([FiiAlarmProcDataModel].self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 获取计划信息数据
    static func GetPlanData(appKey: String,
                            infoKey: String,
                            _ callBack: @escaping([FiiPlanDataModel]) -> Void)
    {
        let api = "/api/GWServiceWebAPI/get_PlanData"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        
        APIManager.post(api: api, headers: header) { (true, json, error) in
            if let model = json?.toModel([FiiPlanDataModel].self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 获取设备控制数据
    static func GetSetParmData(appKey: String,
                            infoKey: String,
                            _ callBack: @escaping([FiiSetParmDataModel]) -> Void)
    {
        let api = "/api/GWServiceWebAPI/get_SetParmData"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        
        APIManager.post(api: api, headers: header) { (true, json, error) in
            if let model = json?.toModel([FiiSetParmDataModel].self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 获取系统控制数据
    static func GetExProcCmdData(appKey: String, infoKey: String, _ callBack: @escaping([FiiExProcCmdDataModel]) -> Void)
    {
        let api = "/api/GWServiceWebAPI/get_ExProcCmdData"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        
        APIManager.post(api: api, headers: header) { (true, json, error) in
            if let model = json?.toModel([FiiExProcCmdDataModel].self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 获取普通任务列表数据
    static func GetProcTimeTListData(appKey: String,
                                     infoKey: String,
                                     _ callBack: @escaping([FiiProcTimeTListDataModel]) -> Void)
    {
        let api = "/api/GWServiceWebAPI/get_ProcTimeTListData"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        
        APIManager.post(api: api, headers: header) { (true, json, error) in
            if let model = json?.toModel([FiiProcTimeTListDataModel].self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 获取ycp表数据
    static func GetYcpData(appKey: String,
                           infoKey: String,
                           equip_no: Int,
                           _ callBack: @escaping([FiiGetYcpDataModel]) -> Void)
    {
        let api = "/api/GWServiceWebAPI/getYcp"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let param: [String: Any] = ["equip_no": equip_no]
        
        APIManager.post(api: api, params: param, headers: header) { (true, json, error) in
            if let model = json?.toModel([FiiGetYcpDataModel].self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    
    /// 获取yxp数据表
    static func GetYxpData(appKey: String,
                           infoKey: String,
                           equip_no: Int,
                           _ callBack: @escaping([FiiGetYxpDataModel]) -> Void)
    {
        let api = "/api/GWServiceWebAPI/getYxp"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let param: [String: Any] = ["equip_no": equip_no]
        
        APIManager.post(api: api, params: param, headers: header) { (true, json, error) in
            if let model = json?.toModel([FiiGetYxpDataModel].self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 获取setParm数据
    static func GetSetParmList(appKey: String,
                               infoKey: String,
                               findEquip: Bool,
                               equip_no: String,
                               _ callBack: @escaping([FiiSetparmListModel]) -> Void)
    {
        let api = "/api/GWServiceWebAPI/getSetparmList"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let param: [String: Any] = ["findEquip": findEquip, "equip_no": equip_no]
        
        APIManager.post(api: api, params: param, headers: header) { (true, json, error) in
            if let model = json?.toModel([FiiSetparmListModel].self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 获取设备组数据
    static func GetEquipGroupData(appKey: String, infoKey: String, _ callBack: @escaping([FiiEquipGroupDataModel]) -> Void)
    {
        let api = "/api/GWServiceWebAPI/get_EquipGroupData"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        
        APIManager.post(api: api, headers: header) { (true, json, error) in
            if let model = json?.toModel([FiiEquipGroupDataModel].self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 获取Equip所有设备数据
    static func GetEquipData(appKey: String, infoKey: String, _ callBack: @escaping([FiiEquipDataModel]) -> Void) {
        
        let api = "/api/GWServiceWebAPI/get_EquipData"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        
        APIManager.post(api: api, headers: header) { (true, json, error) in
            if let model = json?.toModel([FiiEquipDataModel].self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 获取图片验证码
    static func GenerateImageData(appKey: String, infoKey: String, equip_no: Int,  _ callBack: @escaping(String) -> Void) {
        
        let api = "/api/GWServiceWebAPI/set_GenerateImageData"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let param: [String: Any] = ["equip_no": equip_no]
        
        
        APIManager.post(api: api, params: param, headers: header) { (true, json, error) in
            if let model = json?.stringValue {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 连接服务器
    static func ConnectService(appKey: String, infoKey: String, _ callBack: @escaping(Bool) -> Void) {
        
        let api = "/api/server/ConnectService"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        
        APIManager.post(api: api, headers: header) { (true, json, error) in
            if let model = json?.boolValue {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 返回欢迎词最新一条保存记录
    static func GetWelcomeSpeech(appKey: String, infoKey: String, _ callBack: @escaping([FiiWelcomeSpeechModel]) -> Void) {
        
        let api = "/api/GWServiceWebAPI/getWelcomeSpeech"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        
        APIManager.post(api: api, headers: header) { (true, json, error) in
            if let model = json?.toModel([FiiWelcomeSpeechModel].self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 版本适配
    static func VersionAdapt(appKey: String, infoKey: String, _ callBack: @escaping(String) -> Void) {
        
        let api = "/api/server/version_adapt"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        
        APIManager.post(api: api, headers: header) { (true, json, error) in
            if let model = json?.stringValue {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 验证cookie存储客户端信息是否过期
    static func GetClientTypeInfo(appKey: String,
                                  infoKey: String,
                                  _ callBack: @escaping(FiiClienTypeInfoModel) -> Void)
    {
        let api = "/api/GWServiceWebAPI/getClientTypeInfo"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        
        APIManager.post(api: api, headers: header) { (true, json, error) in
            if let model = json?.toModel(FiiClienTypeInfoModel.self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 获取文件夹结构
    static func GetFileStructure(appKey: String,
                                 infoKey: String,
                                 filePath: String,
                                 fileName: String,
                                 _ callBack: @escaping([String]) -> Void)
    {
        let api = "/api/GWServiceWebAPI/GetFileStructure"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let param: [String: Any] = ["filePath": filePath, "fielName": fileName]
        
        APIManager.post(api: api, params: param, headers: header) { (true, json, error) in
            if let model = json?.toModel([String].self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 获取setParm表数据
    static func GetSetParmRadioList(appKey: String,
                                    infoKey: String,
                                    setEquip: Int,
                                    setNo: String, _ callBack: @escaping([FiiSetParmDataModel]) -> Void)
    {
        let api = "/api/GWServiceWebAPI/getSetParmRadioList"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let param: [String: Any] = ["Set_equip": setEquip, "Set_no": setNo]
        
        APIManager.post(api: api, params: param, headers: header) { (true, json, error) in
            if let model = json?.toModel([FiiSetParmDataModel].self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 获取用户权限
    static func GetUserItem(appKey: String, infoKey: String, _ callBack: @escaping(FiiUserItemModel) -> Void)
    {
        let api = "/api/Permis/get_user_item"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        
        APIManager.post(api: api, headers: header) { (true, json, error) in
            if let model = json?.toModel(FiiUserItemModel.self) {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
    /// 插入数据
    static func InsertWelcomeSpeech(appKey: String,
                                    infoKey: String,
                                    jsonContent: String,
                                    bgImage: String,
                                    type: Int,
                                    siginalVal: Int,
                                    _ callBack: @escaping(Int) -> Void)
    {
        let api = "/api/GWServiceWebAPI/insertWelcomeSpeech"
        let header: [String: String] = ["Authorization": appKey + "-" + infoKey]
        let param: [String: Any] = ["JSONContent": jsonContent,
                                    "BGImage": bgImage,
                                    "TYPE": type,
                                    "siginalVal": siginalVal]
        
        APIManager.post(api: api, params: param, headers: header) { (true, json, error) in
            if let model = json?.intValue {
                callBack(model)
            } else {
                print("recieved data = \(String(describing: json))")
            }
        }
    }
    
}
