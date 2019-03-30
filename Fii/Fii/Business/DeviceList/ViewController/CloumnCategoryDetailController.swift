


//
//  CloumnCategoryDetailController.swift
//  Fii
//
//  Created by yetao on 2019/3/15.
//  Copyright © 2019 Liu Tao. All rights reserved.
//

import UIKit

let kCategoryMenuWidth = CGFloat(95)

private let kcurrentScreenW = CGFloat(UIScreen.width - kCategoryMenuWidth)
private let kItemMargin: CGFloat = 10
private let kItemW = (kcurrentScreenW - 3 * kItemMargin)/2
private let kNomalItemH = kItemW*3/4


private let reuseIdentifier = "Cell"

class CloumnCategoryDetailController: UICollectionViewController, UICollectionViewDelegateFlowLayout {


    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNoticeData()
        setupCell()
    }
    
    private func setupCell() {
        
        collectionView.backgroundColor = UIColor.white
        collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
    }
    
    private func initNoticeData(){
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(test),
                                               name: NSNotification.Name(rawValue:"isTest"),
                                               object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}


extension CloumnCategoryDetailController{
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int
    {

        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int
    {

        return 20
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = UIColor.orange
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize
    {
        return CGSize(width: 0, height: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    

    
    @objc func test(notification: Notification) {
        
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
