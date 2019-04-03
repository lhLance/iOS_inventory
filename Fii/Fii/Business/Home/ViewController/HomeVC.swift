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
    var oeeeView: OEEEfficiencyAnalysisView?
    var numOfPartsView: NumberOfPartsView?
    var bootStaticView: BootStatisticsView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setupView()
    }
    
    func setupView() {
        
        scrollView = UIScrollView.init().then({ (s) in
            s.alwaysBounceVertical = true
            s.showsVerticalScrollIndicator = false
            s.added(into: view)
            s.snp.makeConstraints({ (make) in
                make.edges.equalToSuperview()
            })
        })
        
        containerView = UIView().then({ (c) in
            c.added(into: scrollView ?? UIScrollView())
            c.snp.makeConstraints({ (make) in
                make.width.equalToSuperview()
                make.edges.equalToSuperview()
            })
            
            timeView = TimeEfficiencyAnalysisView().then({ (t) in
                t.added(into: c)
                t.snp.makeConstraints({ (make) in
                    make.top.left.right.equalToSuperview()
                    make.height.equalTo(200)
                })
            })
            
            oeeeView = OEEEfficiencyAnalysisView().then({ (t) in
                t.added(into: c)
                t.snp.makeConstraints({ (make) in
                    make.top.equalTo(timeView?.snp.bottom ?? 0)
                    make.left.right.equalToSuperview()
                    make.height.equalTo(200)
                })
            })
            
            numOfPartsView = NumberOfPartsView().then({ (t) in
                t.added(into: c)
                t.snp.makeConstraints({ (make) in
                    make.top.equalTo(oeeeView?.snp.bottom ?? 0)
                    make.left.right.equalToSuperview()
                    make.height.equalTo(200)
                })
            })
            
            bootStaticView = BootStatisticsView().then({ (t) in
                t.added(into: c)
                t.snp.makeConstraints({ (make) in
                    make.top.equalTo(numOfPartsView?.snp.bottom ?? 0)
                    make.left.right.equalToSuperview()
                    make.height.equalTo(200)
                    make.bottom.equalTo(0)
                })
            })
        })
    }

}
