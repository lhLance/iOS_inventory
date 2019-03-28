//
//  RealTimeVC.swift
//  Fii
//
//  Created by Liu Tao on 2019/3/11.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//


class RealTimeVC: UIViewController {
    
    var realTimelControllerVc:RealTimelController?;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI();
        //        view.backgroundColor = UIColor.blue
    }
    
}



extension  RealTimeVC
{
    private func setupUI(){
        
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout();
        layout.minimumLineSpacing = kRealTimeItemMargin
        layout.itemSize = CGSize(width: kRealTimeItemW, height: kRealTimeNomalItemH);
        layout.minimumInteritemSpacing = kRealTimeItemMargin;
        layout.sectionInset = UIEdgeInsets(top: kRealTimeItemMargin,
                                           left: kRealTimeItemMargin,
                                           bottom: kRealTimeItemMargin,
                                           right: kRealTimeItemMargin)
        
        realTimelControllerVc = RealTimelController(collectionViewLayout: layout)
        realTimelControllerVc!.view.frame = CGRect(0,
                                                   kNavigationBarH + kStatusBarH,
                                                   self.view.frame.width ,
                                                   self.view.frame.height - kStatusBarH - kNavigationBarH);
        self.view.addSubview(realTimelControllerVc!.view);
        
        
        
    }
    
}
