//
//  CustomerServiceVC.swift
//  Fii
//
//  Created by Liu Tao on 2019/3/21.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import UIKit
import WebKit

class CustomerServiceVC: UIViewController {

    let urlStr = "https://cschat-ccs.aliyun.com/index.htm?tntInstId=_1ERC6BE&scene=SCE00004113"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    func setupView() {
        
        let webView = WKWebView()
        webView.added(into: view)
        webView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        webView.load(URLRequest(url: URL(string: urlStr)!))
    }

}
