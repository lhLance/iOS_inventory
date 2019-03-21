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

#if DEBUG
var base_url = APIManager.BaseURL.dev
#else
var base_url = APIManager.BaseURL.product
#endif

class APIManager {
    
    static let shared = APIManager()
    
    private let sessionManager: SessionManager
    
    typealias requestCallback = (DataResponse<Data>) -> Void
    
    private init() {

        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 5
        sessionManager = SessionManager.init(configuration: config)
    }
    
    func sendRequest(_ path: String,
                     baseUrl: BaseURL = base_url,
                     method: HTTPMethod = .get,
                     parameters: Parameters? = nil,
                     encoding: ParameterEncoding = URLEncoding.default,
                     headers: HTTPHeaders? = nil,
                     callBack:@escaping requestCallback)
    {
        var url = baseUrl.rawValue + path
        
        if path.contains("http") {
            url = path
        }
        
        let dataRequest = sessionManager.request(url,
                                                 method: method,
                                                 parameters: parameters,
                                                 encoding: encoding,
                                                 headers: headers)
        dataRequest.responseData { (data) in
            callBack(data)
        }
    }
}

extension APIManager {
    enum BaseURL: String {
        case dev = "http://10.143.62.150:8088"
        case product = "https://10.143.62.150:8088"
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
