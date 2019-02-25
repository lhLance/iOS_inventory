//
//  APIManager.swift
//  Fii
//
//  Created by mac on 2019/2/25.
//  Copyright © 2019 Liu Tao. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import RxSwift

class APIManager {
    
    static let shared = APIManager()
    
    private let sessionManager: SessionManager
    
    typealias requestCallback = (DataResponse<Data>) -> Void
    
    private init() {

        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 15
        sessionManager = SessionManager.init(configuration: config)
    }
    
    func sendRequest(_ path: String,
                     method: HTTPMethod = .get,
                     parameters: Parameters? = nil,
                     encoding: ParameterEncoding = URLEncoding.default,
                     headers: HTTPHeaders? = nil,
                     callBack:@escaping requestCallback)
    {
        let dataRequest = sessionManager.request(path,
                                                 method: method,
                                                 parameters: parameters,
                                                 encoding: encoding,
                                                 headers: headers)
        dataRequest.responseData { (data) in
            callBack(data)
        }
    }
}

extension URLRequest {
    
    func printError(_ error: Any) {
        
        let url = self.url?.absoluteString ?? "no url"
        let header = self.allHTTPHeaderFields ?? [:]
        #if DEBUG
        let body = String.init(data: self.httpBody ?? Data(), encoding: String.Encoding.utf8) ?? "nil"
        let info = """
        {
        Request Info
        url:    \(url)
        header: \(header)
        body:   \(body)
        error:  \(error)
        }
        """
        print(info)
        #endif
    }
}
