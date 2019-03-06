//
//  APPKeyModel.swift
//  Fii
//
//  Created by Liu Tao on 2019/2/26.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import Foundation

class FIIServiceModel: Codable {
    
    var appkey: String?
    var infokey: String?
    var version: String?
    var authName: String?
}

class FIIAlarmConfigModel: Codable {
    
    var ID: Int?
    var SnapshotName: String?
    var SnapshotLevelMin: String?
    var SnapshotLevelMax: String?
    var MaxCount: String?
    var IsShow: String?
    var IconRes: String?
    var Reserve1: String?
    var Reserve2: String?
    var Reserve3: String?
}

class FIIAlarmRealEventModel: Codable {
    
    var related_video: String?
    var ZiChanID: String?
    var PlanNo: String?
    var bConfirmed: String?
    var User_Confirmed: String?
    var Dt_Confirmed: String?
    var Level: Int?
    var EventMsg: String?
    var Proc_advice_Msg: String?
    var Related_pic: String?
    var Wavefile: String?
    var Equipno: Int?
    var `Type`: String?
    var Ycyxno: Int?
    var Time: String?
}

class FIIEquipEventModel: Codable {
    
    var equip_nm: String?
    var event: String?
    var time: String?
}

class FIIEquipSettingsModel: Codable {
    
    var equip_nm: String?
    var event: String?
    var `operator`: String?
    var time: String?
}

class FIISystemEventModel: Codable {
    
    var event: String?
    var time: String?
}

class FIIEquipListModel: Codable {
    
    var Name: String?
    var IsExpanded: String?
    var Image: String?
    var EquipNo: String?
    var EquipStateYcNo: String?
    var CeDianConfig: String?
    var ClickShowPage: String?
    var GWEquipTreeItems: [FIIEquipListModel]?
}

class FIIEquipRealStateModel: Codable {
    
    var related_video: String?
    var ZiChanID: String?
    var PlanNo: String?
    var related_pic: String?
    var m_iEquipNo: Int?
    var m_Bufang: Bool?
    var m_EquipNm: String?
    var m_State: Int?
}

class FIIEquipmentItemStateModel: Codable {
    
    var EquipItem: [EquipItemModel]
    var YCItemDict: [YCItemDictModel]
    var YXItemDict: [YXItemDictModel]
}

extension FIIEquipmentItemStateModel {
    
    class EquipItemModel: Codable {
        
        var related_video: String
        var ZiChanID: String
        var PlanNo: String
        var related_pic: String
        var m_iEquipNo: Int
        var m_Bufang: Bool
        var m_EquipNm: String
        var m_State: Int
    }
    
    class YCItemDictModel: Codable {
        
        var related_video: String?
        var ZiChanID: String?
        var PlanNo: String?
        var related_pic: String?
        var m_iEquipNo: Int?
        var m_Bufang: Bool?
        var m_iYCNo: Int?
        var m_YCNm: String?
        var m_Unit: String?
        var m_YCValue: Float?
        var m_IsAlarm: Bool?
        var m_AdviceMsg: String?
        var m_bHasHistoryCcurve: Bool?
    }
    
    class YXItemDictModel: Codable {
        
        var related_video: String?
        var ZiChanID: String?
        var PlanNo: String?
        var related_pic: String?
        var m_iEquipNo: Int?
        var m_Bufang: Bool?
        var m_iYXNo: Int?
        var m_YXNm: String?
        var m_YXValue: Bool?
        var m_YXState: String?
        var m_FullYXState: String?
        var m_IsAlarm: Bool?
        var m_AdviceMsg: String?
    }
}

class FIIYCPHistoryModel: Codable {
    
    var dataTime: String?
    var mySeriesPointType: String?
    var value: String?
}

class FiiEquipControlModel: Codable {
    
    var code: Int?
    var message: String?
    var data: String?
}

class FiiEquipConfigModel: Codable {
    
    var sta_n: Int?
    var equip_no: Int?
    var equip_nm: String?
    var equip_detail: String?
    var acc_cyc: Int?
    var related_pic: String?
    var proc_advice: String?
    var out_of_contact: String?
    var contacted: String?
    var event_wav: String?
    var local_addr: String?
    var equip_addr: String?
    var communication_param: String?
    var communication_time_param: String?
    var raw_equip_no: Int?
    var tabname: String?
    var alarm_scheme: Int?
    var attrib: Int?
    var sta_IP: String?
    var AlarmRiseCycle: Int?
    var Reserve1: String?
    var Reserve2: String?
    var Reserve3: String?
    var related_video: String?
    var ZiChanID: String?
    var PlanNo: String?
    var SafeTime: String?
}

class FiiSetParamModel: Codable {
    
    var sta_n: Int?
    var equip_no: Int?
    var set_no: Int?
    var set_nm: String?
    var set_type: String?
    var main_instruction: String?
    var minor_instruction: String?
    var record: Bool?
    var action: String?
    var value: String?
    var canexecution: Bool?
    var VoiceKeys: String?
    var EnableVoice: Bool?
    var qr_equip_no: String?
    var Reserve1: String?
    var Reserve2: String?
    var Reserve3: String?
}

class FiiYCPConfigModel: Codable {
    
    var sta_n: Int?
    var equip_no: Int?
    var yc_no: Int?
    var yc_nm: String?
    var mapping: Bool?
    var yc_min: Float?
    var yc_max: Float?
    var physic_min: Float?
    var physic_max: Float?
    var val_min: Float?
    var restore_min: Float?
    var restore_max: Float?
    var val_max: Float?
    var val_trait: Int?
    var main_instruction: String?
    var minor_instruction: String?
    var safe_bgn: String?
    var sade_end: String?
    var alarm_acceptable_time: Int?
    var restore_acceptable_time: Int?
    var alarm_repeat_time: Int?
    var proc_advice: String?
    var lvl_level: Int?
    var outmin_evt: String?
    var outmax_evt: String?
    var wave_file: String?
    var related_pic: String?
    var alarm_scheme: Int?
    var curve_rcd: Bool?
    var curve_limit: Float?
    var alarm_shield: String?
    var unit: String?
    var AlarmRiseCycle: Int?
    var Reserve1: String?
    var Reserve2: String?
    var Reserve3: String?
    var related_video: String?
    var ZiChanID: String?
    var PlanNo: String?
    var SafeTime: String?
}

class FiiYXPConfig: Codable {
    
    var sta_n: Int?
    var equip_no: Int?
    var yx_no: Int?
    var yx_nm: String?
    var proc_advice_r: String?
    var proc_advice_d: String?
    var level_r: Int?
    var level_d: Int?
    var evt_01: String?
    var evt_10: String?
    var main_instruction: String?
    var minor_instruction: String?
    var safe_bgn: String?
    var safe_end: String?
    var alarm_acceptable_time: Int?
    var restore_acceptable_time: Int?
    var alarm_repeat_time: Int?
    var wave_file: String?
    var related_pic: String?
    var alarm_scheme: Int?
    var inversion: Bool?
    var initval: Int?
    var val_trait: Int?
    var alarm_shield: String?
    var AlarmRiseCycle: Int?
    var Reserve1: String?
    var Reserve2: String?
    var Reserve3: String?
    var related_video: String?
    var ZiChanID: String?
    var PlanNo: String?
    var SafeTime: String?
}

class FiiVideoConfigModel: Codable {
    
    var sta_n: Int?
    var equip_no: Int?
    var equip_nm: String?
    var equip_detail: String?
    var acc_cyc: Int?
    var related_pic: String?
    var proc_advice: String?
    var out_of_contact: String?
    var contacted: String?
    var event_wav: String?
    var communication_drv: String?
    var local_addr: String?
    var equip_addr: String?
    var communication_param: String?
    var communication_time_param: String?
    var raw_equip_no: String?
    var tabname: String?
    var alarm_scheme: Int?
    var attrib: Int?
    var sta_IP: String?
    var AlarmRiseCycle: Int?
    var Reserve1: String?
    var Reserve2: String?
    var Reserve3: String?
    var related_video: String?
    var ZiChanID: String?
    var PlanNo: String?
    var SafeTime: String?
    var 字段1: String?
    var 字段2: String?
}

class FiiVideoDevInfoModel: Codable {
    
    var sta_n: Int?
    var EquipNum: Int?
    var ID: Int?
    var ChannelName: String?
    var ChannelType: Int?
    var ChannelNum: String?
    var ControlEquip: Int?
    var Path: String?
    var Reserve1: String?
    var Reserve2: String?
    var Reserve3: String?
    var Action: String?
}

class FiiGetAddinModuleModel: Codable {
    
    var ID: String?
    var Name: String?
    var ClassName: String?
    var HelpPath: String?
    var MultiScreens: String?
    var WebPage: String?
}

class FiiGetEquipPagesModel: Codable {
    
    var ID: String?
    var Name: String?
    var Pages: String?
    var HelpPath: String?
    var MultiScreens: String?
    var WebPage: String?
}

class FiiLoopTaskDetailModel: Codable {
    
    var TableID: String?
    var DoOrder: String?
    var `Type`: String?
    var equip_no: String?
    var set_no: String?
    var value: String?
    var proc_code: String?
    var set_name: String?
    var SleepTime: String?
    var SleepUnit: String?
}

class FiiCommonTaskEquipControlModel: Codable {
    
    var ID: String?
    var TableID: String?
    var Time: String?
    var TimeDur: String?
    var equip_no: String?
    var set_no: String?
    var value: String?
    var sta_n: String?
    var set_nm: String?
}

class FiiSpecTableDataModel: Codable {
    
    var ID: String?
    var DateName: String?
    var BeginDate: String?
    var EndDate: String?
    var TableID: String?
}

class FiiProcWeekTableDataModel: Codable {
    
    var Mon: String?
    var Tues: String?
    var Wed: String?
    var Thurs: String?
    var Fri: String?
    var Sat: String?
    var Sun: String?
}

class FiiDataForListStrModel: Codable {
    
    var userName: String?
    var expirationDate: String?
}

class FiiProcCycleTListDataModel: Codable {
    
    var TableID: String?
    var TableName: String?
    var BeginTime: String?
    var EndTime: String?
    var ZhenDianDo: String?
    var ZhidingDo: String?
    var CycleMustFinish: String?
    var ZhidingTime: String?
    var MaxCycleNum: String?
    var Reserve1: String?
    var Reserve2: String?
    var Reserve3: String?
    var Reference: String?
}

class FiiGetLinkageListModel: Codable {
    
    var ID: String?
    var iequip_no: String?
    var iycyx_no: String?
    var iycyx_type: String?
    var delay: String?
    var oequip_no: String?
    var ProcDesc: String?
    var Enable: String?
}

class FiiAlarmTBListModel: Codable {
    
    var sta_n: String?
    var group_no: String?
    var Administrator: String?
    var id: String?
}

class FiiWeekAlmReportData: Codable {
    
    var sta_n: String?
    var group_no: String?
    var Administrator: String?
    var week_day: String?
    var begin_time: String?
    var end_time: String?
    var remark: String?
    var id: String?
}

