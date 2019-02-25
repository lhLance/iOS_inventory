
//
//  APIError.swift
//  Fii
//
//  Created by Liu Tao on 2019/2/25.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import Foundation

enum APIError: Error {
    
    case network(error: Error)
    case business(code: Int, msg: String)
    case parseJSONFail
    case uploadFileFail(msg: String?)
    case unknow
}

extension APIError {
    static let kickOut = 1000
}

extension APIError {
    
    var needShow: Bool {
        switch self {
        case .business:
            return true
        default:
            return false
        }
    }
    
    var showMessage: String {
        switch self {
        case .business(_, let msg):
            return msg
        case .parseJSONFail:
            return "json parse error"
        default: return ""
        }
    }
}
