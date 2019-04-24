//
//  MobilePhoneFrameController.swift
//  Fii
//
//  Created by yetao on 2019/3/25.
//  Copyright © 2019 Liu Tao. All rights reserved.
//

import UIKit

private let kItemMargin:CGFloat = 16
private let kItemW = 166
private let kNomalItemH = 141
private let kPrettyItemH = kItemW*4/3
private let kHeaderViewH = CGFloat(50)
private let kNomalCellID = "nomanCell"
private let titleColor = colorWithRGBA(red: 71, green: 71, blue: 71, alpha: 1.0)



class MobilePhoneFrameController: UIViewController {

    
    private var titleAry:[(String,String)] = []
    private lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNomalItemH)
        layout.minimumLineSpacing = kItemMargin/*垂直间隔*/
        layout.minimumInteritemSpacing = 11/*水平间隔*/
        layout.sectionInset = UIEdgeInsets(top: kItemMargin,
                                           left: kItemMargin,
                                           bottom: kItemMargin,
                                           right: kItemMargin)
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = colorWithRGBA(red: 237,
                                                       green: 237,
                                                       blue: 242,
                                                       alpha: 1.0)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight] /*随父控件大小而拉升*/
        collectionView.register(UINib(nibName: "CollectionNomalCell", bundle: nil), forCellWithReuseIdentifier: kNomalCellID)
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitData()
        setupUI()

        // Do any additional setup after loading the view.
    }

}

extension MobilePhoneFrameController{
    private func setInitData(){
    
    titleAry = [(LanguageHelper.getString(key: "deivce_Screw_machine"),"devList_screw_machine.png"),
                (LanguageHelper.getString(key: "machine_CNC1_Harbin_open_five_axis"),"devList_cnc1.png"),
                (LanguageHelper.getString(key: "foxbot1"),"devList_foxbot1.png"),
                (LanguageHelper.getString(key: "machine_cnc2fanuc_three-axis"),"devList_cnc2.png"),
                (LanguageHelper.getString(key: "foxbot2"),"devList_foxbot2.png"),
                (LanguageHelper.getString(key: "agv1"),"devList_agv2"),
                (LanguageHelper.getString(key: "deivce_Feeder"),"devList_defect_detection.png")]
    }
    
    private func setupUI(){
        collectionView.added(into: view)
    }
    
}
extension MobilePhoneFrameController:UICollectionViewDataSource
{
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNomalCellID, for: indexPath) as! CollectionNomalCell
            cell.backgroundColor = UIColor.clear
        cell.titleLab.text = titleAry[indexPath.row].0
        cell.titleLab.Font(UIFont.PFRegular(14)).TextAlignment(.center).TextColor(titleColor)
        cell.ImageV.image = UIImage(named: titleAry[indexPath.row].1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return titleAry.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = DeviceDetailController()
        detailController.gifName = titleAry[indexPath.row].0
        self.navigationController?.pushViewController(detailController, animated: false)
    }
    
    
}

extension MobilePhoneFrameController:UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: kItemW, height: kNomalItemH)
    }
    
}
