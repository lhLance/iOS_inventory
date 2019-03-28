


//
//  RealTimelController.swift
//  Fii
//
//  Created by yetao on 2019/3/15.
//  Copyright © 2019 Liu Tao. All rights reserved.
//

import UIKit


 let kRealTimeItemMargin:CGFloat = 20;
 let kRealTimeItemW = (UIScreen.width - 3*kRealTimeItemMargin)/2
 let kRealTimeNomalItemH = kRealTimeItemW*3/4


private let reuseIdentifier = "Cell"

class RealTimelController: UICollectionViewController,UICollectionViewDelegateFlowLayout {

    private let titleAry:NSArray = ["孤岛模式","巡航模式","参观模式","顺序模式","分布式模式"];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNoticeData();
        setupCell();
        // Do any additional setup after loading the view.
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}


extension RealTimelController{
    
    private func  setupCell(){

        self.collectionView.backgroundColor = UIColor.white
        self.collectionView.register(UINib(nibName: "RealTimeCollectionCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return titleAry.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! RealTimeCollectionCell
        //        cell.backgroundColor = UIColor.orange;
        // Configure the cell
        if (indexPath.row + 1) % 2 == 0 {
            cell.backgroundColor = UIColor.red;
            
        }else{
            cell.backgroundColor = UIColor.green;
        }
        cell.titleLab.text = (titleAry[indexPath.row] as! String);
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: kRealTimeItemW, height: kRealTimeNomalItemH)
    }
    
    private func initNoticeData(){
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(test),
                                               name: NSNotification.Name(rawValue:"isTest"),
                                               object: nil)
    }
    
    @objc func test(notification:Notification){
        print("收到通知啦....")
        guard let userInfo = notification.userInfo,
            let section = userInfo["one"] ,
            let row = userInfo["two"] else
        {
            print("No userInfo found in notification")
            return
        }
        print("传回索引是  \(section) + \(row)")
    }
    
 
    

    
    
}
