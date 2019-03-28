//
//  MobilePhoneFrameController.swift
//  Fii
//
//  Created by yetao on 2019/3/25.
//  Copyright © 2019 Liu Tao. All rights reserved.
//

import UIKit

private let kItemMargin:CGFloat = 10;
private let kItemW = (UIScreen.width - 3*kItemMargin)/2
private let kNomalItemH = kItemW*4/3
private let kPrettyItemH = kItemW*4/3
private let kHeaderViewH = CGFloat(50)
private let kNomalCellID = "nomanCell"



class MobilePhoneFrameController: UIViewController {

    
    private var titleAry:[(String,String)] = [];
    private lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout();
        layout.itemSize = CGSize(width: kItemW, height: kNomalItemH);
        layout.minimumLineSpacing = kItemMargin;
        layout.minimumInteritemSpacing = kItemMargin;
        layout.sectionInset = UIEdgeInsets(top: kItemMargin,
                                           left: kItemMargin,
                                           bottom: kItemMargin,
                                           right: kItemMargin)
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout);
        collectionView.backgroundColor = colorWithRGBA(red: 57,
                                                       green: 61,
                                                       blue: 79,
                                                       alpha: 1.0);
        collectionView.dataSource = self ;
        collectionView.delegate = self ;
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight];/*随父控件大小而拉升*/
        collectionView.register(UINib(nibName: "CollectionNomalCell", bundle: nil), forCellWithReuseIdentifier: kNomalCellID);
        return collectionView;
    }();
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitData();
        setupUI();

        // Do any additional setup after loading the view.
    }

}

extension MobilePhoneFrameController{
    private func setInitData(){
    
    titleAry = [("螺丝机","devList_screw_machine.png"),
                ("CNC1","devList_cnc1.png"),
                ("FOXBOT","devList_foxbot1.png"),
                ("CNC2","devList_cnc2.png"),
                ("FOXBOT2","devList_foxbot2.png"),
                ("FOXBOT_DJ","devList_Foxbot3.png"),
                ("AGV","devList_agv2"),
                ("缺陷检测器","devList_defect_detection.png"),
                ("FOXBOT5","devList_Foxbot5")];
    }
    
    private func setupUI(){
        collectionView.added(into: view);
    }
    
}
extension MobilePhoneFrameController:UICollectionViewDataSource
{
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNomalCellID, for: indexPath) as! CollectionNomalCell;
            cell.backgroundColor = UIColor.clear;
        cell.titleLab.text = titleAry[indexPath.row].0 ;
        cell.ImageV.image = UIImage(named: titleAry[indexPath.row].1);
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return titleAry.count;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = DeviceDetailController()
        detailController.gifName = titleAry[indexPath.row].0;
        self.navigationController?.pushViewController(detailController, animated: false);
    }
    
    
}

extension MobilePhoneFrameController:UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: kItemW, height: kNomalItemH);
    }
    
}
