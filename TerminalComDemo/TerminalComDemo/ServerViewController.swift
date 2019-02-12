//
//  ServerViewController.swift
//  TerminalComDemo
//
//  Created by mac on 2019/2/8.
//  Copyright © 2019 TLLTD. All rights reserved.
//

import UIKit
import SnapKit
import SwiftSocket

class ServerViewController: UIViewController {

    let startBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    func setupView() {
        
        startBtn.backgroundColor = UIColor.green
        view.addSubview(startBtn)
        startBtn.snp.makeConstraints { (make) in
            make.width.equalTo(50)
            make.height.equalTo(25)
            make.center.equalToSuperview()
        }
        startBtn.setTitle("start", for: UIControl.State.normal)
        startBtn.addTarget(self, action: #selector(startBtnTapped), for: UIControl.Event.touchUpInside)
    }

    @objc func startBtnTapped() {
        
        print("start btn tapped...")
        
        testServer()
    }
    
    func echoService(client: TCPClient) {
        
        print("Newclient from:\(client.address)[\(client.port)]")
        
        if let d = client.read(1024 * 10) {
            print("result \(client.send(data: d))")
        } else {
            print("can not read")
        }
        client.close()
    }
    
    func testServer() {
        
        let server = TCPServer(address: "192.168.8.102", port: 9999)
        switch server.listen() {
        case .success:
            while true {
                if let client = server.accept() {
                    echoService(client: client)
                } else {
                    print("accept error")
                }
            }
        case .failure(let error):
            print(error)
        }
    }

}
