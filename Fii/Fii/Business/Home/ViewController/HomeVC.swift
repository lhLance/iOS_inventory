//
//  HomeVC.swift
//  Fii
//
//  Created by Liu Tao on 2019/3/11.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import UIKit
import Then
import SnapKit

class HomeVC: UIViewController {

    var scrollView: UIScrollView?
    var containerView: UIView?
    var timeView: TimeEfficiencyAnalysisView?
    var equipmentRatioView: EquipmentWorkRatioAnalysisView?
    var oeeeView: OEEEfficiencyAnalysisView?
    var numOfPartsView: NumberOfPartsView?
    var bootStaticView: BootStatisticsView?
    var refreshControl: UIRefreshControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setupView()
    }
    
    func setupView() {
        
        scrollView = UIScrollView().then({ (s) in
            s.alwaysBounceVertical = true
            s.showsVerticalScrollIndicator = false
            s.added(into: view)
            s.snp.makeConstraints({ (make) in
                make.edges.equalToSuperview()
            })
        })
        
        refreshControl = UIRefreshControl().then({ (r) in
            r.added(into: scrollView ?? UIView())
            r.addTarget(self, action: #selector(loadData(_:)), for: .valueChanged)
        })
        
        containerView = UIView().then({ (c) in
            c.added(into: scrollView ?? UIScrollView())
            c.snp.makeConstraints({ (make) in
                make.width.equalToSuperview()
                make.edges.equalToSuperview()
            })
            c.backgroundColor = UIColor.groupTableViewBackground
            
            timeView = TimeEfficiencyAnalysisView().then({ (t) in
                t.added(into: c)
                t.snp.makeConstraints({ (make) in
                    make.height.equalTo(205)
                    make.top.equalTo(20)
                    make.left.equalTo(20)
                    make.right.equalTo(-20)
                })
                t.cornerRadius = 6.0
                t.backgroundColor = UIColor.white
            })
            
            equipmentRatioView = EquipmentWorkRatioAnalysisView().then({ (t) in
                t.added(into: c)
                t.snp.makeConstraints({ (make) in
                    make.height.equalTo(220)
                    make.top.equalTo(timeView?.snp.bottom ?? 0).offset(15)
                    make.left.equalTo(20)
                    make.right.equalTo(-20)
                })
                t.cornerRadius = 6.0
                t.backgroundColor = UIColor.white
            })
            
            oeeeView = OEEEfficiencyAnalysisView().then({ (t) in
                t.added(into: c)
                t.snp.makeConstraints({ (make) in
                    make.top.equalTo(equipmentRatioView?.snp.bottom ?? 0).offset(15)
                    make.left.equalTo(20)
                    make.right.equalTo(-20)
                    make.height.equalTo(200)
                })
                t.cornerRadius = 6.0
                t.backgroundColor = UIColor.white
            })
            
            numOfPartsView = NumberOfPartsView().then({ (t) in
                t.added(into: c)
                t.snp.makeConstraints({ (make) in
                    make.top.equalTo(oeeeView?.snp.bottom ?? 0).offset(15)
                    make.left.equalTo(20)
                    make.right.equalTo(-20)
                    make.height.equalTo(260)
                })
                t.cornerRadius = 6.0
                t.backgroundColor = UIColor.white
            })
            
            bootStaticView = BootStatisticsView().then({ (t) in
                t.added(into: c)
                t.snp.makeConstraints({ (make) in
                    make.top.equalTo(numOfPartsView?.snp.bottom ?? 0).offset(15)
                    make.left.equalTo(20)
                    make.right.equalTo(-20)
                    make.height.equalTo(260)
                    make.bottom.equalTo(-20)
                })
                t.cornerRadius = 6.0
                t.backgroundColor = UIColor.white
            })
        })
    }
    
    @objc func loadData(_ refreshControl: UIRefreshControl) {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
            refreshControl.endRefreshing()
            print("end refreshing...")
        }
        
        print("loadData...")
    }

}
