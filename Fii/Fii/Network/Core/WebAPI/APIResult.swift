//
//  APIResult.swift
//  Fii
//
//  Created by Liu Tao on 2019/2/25.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import Foundation

enum APIResult<T> {
    
    case success(value: T)
    case fail(error: APIError)
    
    var value: T? {
        switch self {
        case .success(value: let value):
            return value
        case .fail(_):
            return nil
        }
    }
    
    var error: APIError? {
        switch self {
        case .success(_):
            return nil
        case .fail(let error):
            return error
        }
    }
    
    var isSuccess: Bool {
        return self.value != nil
    }
}
