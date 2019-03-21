//
//  RongCloudAPI.swift
//  Fii
//
//  Created by Liu Tao on 2019/3/21.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

final class RongCloudAPI {
    
    typealias HTTPCallback = (Bool, JSON?, APIError?) -> Void
    
    static func getToken(userId: String,
                         name: String,
                         portraitUri: String,
                         _ callBack:@escaping (FiiRongCloudModel) -> Void)
    {
        let api = "http://api-cn.ronghub.com/user/getToken.json"
        let param: [String: Any] = ["userId": userId, "name": name, "portraitUri": portraitUri]
        
        RongCloudAPI.get(api: api, params: param, headers: nil) { (true, json, error) in
            if let model = json?.toModel(FiiRongCloudModel.self) {
                callBack(model)
            } else {
                callBack(FiiRongCloudModel())
            }
        }
    }
    
    static func get(api: String,
                     params: [String: Any]? = nil,
                     headers: [String: String]? = nil,
                     reqCallback: @escaping HTTPCallback)
    {
        sendTo(api: api,
               method: .get,
               params: params,
               headers: headers,
               reqCallback: reqCallback)
    }
    
    static func sendTo(api: String,
                       method: HTTPMethod = .get,
                       params: Parameters?,
                       headers: HTTPHeaders?,
                       reqCallback:@escaping HTTPCallback)
    {
        let encodings: [HTTPMethod: Any] = [
            HTTPMethod.get: URLEncoding.default,
            HTTPMethod.post: JSONEncoding.default
        ]
        let encoding = encodings[method] as! ParameterEncoding
        
        let callBack = { (resp: DataResponse<Data>) in
            switch resp.result {
            case .success(let value):
                let json = JSON(value)
                let httpStatus = json["code"]
                if httpStatus == 200 {
                    reqCallback(true, json, nil)
                } else {
                    let code = json["code"].intValue
                    let msg = "error"
                    reqCallback(false, nil, APIError.business(code: code, msg: msg))
                }
            case .failure(let error):
                reqCallback(false, nil, APIError.unknow)
                print(error)
            }
        }
        
        APIManager.shared.sendRequest(api,
                                      method: method,
                                      parameters: params,
                                      encoding: encoding,
                                      headers: headers,
                                      callBack: callBack)
    }
}
