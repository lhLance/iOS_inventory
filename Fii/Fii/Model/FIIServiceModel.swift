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
