//
//  RealTimeVC.swift
//  Fii
//
//  Created by Liu Tao on 2019/3/11.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

let kRealTimeItemMargin: CGFloat = 10

class RealTimeVC: UIViewController {
    
    var collectionView: UICollectionView?
    
    let kRealTimeItemW = (UIScreen.width - 2 * kRealTimeItemMargin)
    let kRealTimeNomalItemH = CGFloat(117)
    let titleAry: NSArray = [(LanguageHelper.getString(key: "realTime_Island"), "IslandMode.gif"),
                             (LanguageHelper.getString(key: "realTime_loop"), "loopMode.gif"),
                             (LanguageHelper.getString(key: "realTime_Visit"), "VisitMode.gif"),
                             (LanguageHelper.getString(key: "realTime_Sequential"), "SequentialMode.gif"),
                             (LanguageHelper.getString(key: "realTime_Distributional"), "DistributionalMode.gif")]
    
    let gifManager = SwiftyGifManager(memoryLimit: 100)
    
    private let reuseIdentifier = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }
    
    private func setupUI() {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0 // 水平间隔
        layout.minimumLineSpacing = 10.0 // 垂直行间距
        layout.itemSize = CGSize(width: kRealTimeItemW, height: kRealTimeNomalItemH)
        layout.minimumInteritemSpacing = kRealTimeItemMargin
        layout.sectionInset = UIEdgeInsets(top: kRealTimeItemMargin,
                                           left: kRealTimeItemMargin,
                                           bottom: kRealTimeItemMargin,
                                           right: kRealTimeItemMargin)
        
        collectionView = UICollectionView(frame: CGRect(0,
                                                        kNavigationBarH + kStatusBarH,
                                                        view.width,
                                                        view.height - kStatusBarH - kNavigationBarH),
                                          collectionViewLayout: layout)
        collectionView!.added(into: view)
        collectionView!.alwaysBounceVertical = true
        collectionView!.backgroundColor = UIColor.lightText
        collectionView!.register(UINib(nibName: "RealTimeCollectionCell", bundle: nil),
                                forCellWithReuseIdentifier: reuseIdentifier)
        
        collectionView!.delegate = self
        collectionView!.dataSource = self
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

extension RealTimeVC: UICollectionViewDelegate, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return titleAry.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! RealTimeCollectionCell
        let modeltTuple:(String, String) = titleAry[indexPath.row] as! (String, String)
        
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
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.item {
        case 0:
            let vc = RealtimePlayerVC()
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = RealtimePlayerVC()
            navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = RealtimePlayerVC()
            navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = RealtimePlayerVC()
            navigationController?.pushViewController(vc, animated: true)
        case 4:
            let vc = RealtimePlayerVC()
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}
