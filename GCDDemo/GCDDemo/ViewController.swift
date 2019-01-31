//
//  ViewController.swift
//  GCDDemo
//
//  Created by Liu Tao on 2018/3/11.
//  Copyright © 2018年 Liu Tao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let concurrentQueue = DispatchQueue(label: "concurrent", attributes: .concurrent)
    let serialQueue = DispatchQueue(label: "serial")
    let imageUrl = "http://ww1.sinaimg.cn/large/85cccab3tw1esjheer9apg20dw0dz7wh.jpg"

    override func viewDidLoad() {
        super.viewDidLoad()

//        synConcurrent()
//        synSerial()
        asynConcurrent()
        asynSerial()
//        lockQuestion()
    }

    // 同步函数、并行队列
    func synConcurrent() {
        concurrentQueue.sync {
            for i in 0..<10 {
                print("同步函数、并行队列: \(i)")
            }
        }
    }

    // 同步函数、串行队列
    func synSerial() {
        serialQueue.sync {
            for i in 0..<10 {
                print("同步函数、串行队列: \(i)")
            }
        }
    }

    // 异步函数、并行队列
    func asynConcurrent() {
        concurrentQueue.async {
            for i in 0..<10 {
                print("异步函数、并行队列: \(i)")
            }
        }
    }

    // 异步函数、串行队列
    func asynSerial() {
        // 同步队列
        serialQueue.async {
            for i in 0..<10 {
                print("异步函数、串行队列: \(i)")
            }
        }

        // 主线程
        /*
        for i in 0..<10 {
            print("异步函数、串行队列: \(i)")
        }*/
    }

    func lockQuestion() {
        DispatchQueue.main.sync {
            printMain()
        }
    }

    func printMain() {
        print("main queue")
    }

    func downloadImage() {

    }

}
