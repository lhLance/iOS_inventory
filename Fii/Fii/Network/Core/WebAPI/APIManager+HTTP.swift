
//
//  APIManager+HTTP.swift
//  Fii
//
//  Created by Liu Tao on 2019/2/25.
//  Copyright © 2019 Liu Tao. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

extension APIManager {
    
//    enum HttpStatus: Int {
//        case success = 200
//        case operationSuccess = 201
//        case cannotConnectServer = 1000
//        case appKeyExpired = 1001
//        case userNameOrPasswordError = 1002
//        case paramCannotBeEmpty = 1003
//        case serverError = 1004
//        case userNoAccess = 1005
//        case serverCannotRecVoice = 1006
//        case incompleteAuthParam = 1007
//        case incorrectAuthParam = 1008
//        case programDirectoryNotFound = 1010
//        case cannotReadProgramVersion = 1011
//        case tcpConnectCannotMatchServerice = 1013
//        case serviceNotStartOrServiceRunningError = 1014
//        case incorrectVerificationCode = 1015
//    }
    
    typealias HTTPCallback = (Bool, JSON?, APIError?) -> Void
    
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
    
    static func post(api: String,
                     params: [String: Any]? = nil,
                     headers: [String: String]? = nil,
                     reqCallback: @escaping HTTPCallback)
    {
        sendTo(api: api,
               method: .post,
               params: params,
               headers: headers,
               reqCallback: reqCallback)
    }
    
    static func sendTo(api: String,
                       method: HTTPMethod,
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
                 let httpStatus = json["HttpStatus"]
                 if httpStatus == 200 || httpStatus == 201 {
                    reqCallback(true, json["HttpData"]["data"], nil)
                 } else {
                    let code = json["HttpData"]["code"].intValue
                    let msg = json["HttpData"]["message"].stringValue
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
