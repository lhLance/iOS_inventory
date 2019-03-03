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

class EquipControlModel: Codable {
    
    var code: Int?
    var message: String?
    var data: String?
}
