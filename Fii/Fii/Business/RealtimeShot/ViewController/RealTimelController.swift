


//
//  RealTimelController.swift
//  Fii
//
//  Created by yetao on 2019/3/15.
//  Copyright © 2019 Liu Tao. All rights reserved.
//

import UIKit

let kRealTimeItemMargin: CGFloat = 20
let kRealTimeItemW = (UIScreen.width - 2 * kRealTimeItemMargin)
let kRealTimeNomalItemH = CGFloat(100)

private let reuseIdentifier = "Cell"

class RealTimelController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    
    
//    LanguageHelper.getString(key: "me_log_out")).TitleColor(UIColor.red).Font(.PFRegular(16)
    
    private let titleAry: NSArray = [(LanguageHelper.getString(key: "realTime_Island"),"IslandMode.gif"),(LanguageHelper.getString(key: "realTime_loop"),"loopMode.gif"),(LanguageHelper.getString(key: "realTime_Visit"),"VisitMode.gif"),(LanguageHelper.getString(key: "realTime_Sequential"),"SequentialMode.gif"),(LanguageHelper.getString(key: "realTime_Distributional"),"DistributionalMode.gif")]
    
    
    
    
    let gifManager = SwiftyGifManager(memoryLimit:100)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNoticeData()
        setupCell()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}


extension RealTimelController{
    
    private func  setupCell(){

        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = UIColor.lightText
        collectionView.register(UINib(nibName: "RealTimeCollectionCell", bundle: nil),
                                forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return titleAry.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! RealTimeCollectionCell

        let modeltTuple:(String,String) = titleAry[indexPath.row] as! (String, String);

        cell.titleLab.text = modeltTuple.0
        let gifImage = UIImage(gifName: modeltTuple.1)
        cell.iconImg.setGifImage(gifImage, manager: gifManager, loopCount: -1)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: kRealTimeItemW, height: kRealTimeNomalItemH)
    }
    
    private func initNoticeData(){
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(test),
                                               name: NSNotification.Name(rawValue:"isTest"),
                                               object: nil)
    }
    
    @objc func test(notification:Notification) {
        
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
