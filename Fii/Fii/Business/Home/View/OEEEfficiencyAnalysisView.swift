//
//  OEEEfficiencyAnalysisView.swift
//  Fii
//
//  Created by Liu Tao on 2019/3/27.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import UIKit
import SnapKit
import Charts

// OEE = 可用率 X 表现性 X 质量指数
// 可用率 = 操作时间 / 计划工作时间
// 表现性 = 理想周期时间 /（操作时间 / 总产量）= 总产量 /（操作时间 X 理论生产速率）
// 质量指数 = 良品 / 总产量

class OEEEfficiencyAnalysisView: UIView {

    var title: UILabel?
    var circleView: FiiCircleView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    func setupView() {
        
        title = UILabel()
        title?.added(into: self)
        title?.snp.makeConstraints({ (make) in
            make.top.equalTo(5)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
        })
        title?.Text("OEE效率分析").Font(UIFont.PFRegular(16))
        
        circleView = FiiCircleView()
        circleView?.added(into: self)
        circleView?.snp.makeConstraints({ (make) in
            make.width.equalTo(120)
            make.height.equalTo(120)
            make.center.equalToSuperview()
        })
        circleView?.strokeColor = UIColor.hex(0xE94444)
        circleView?.backColor = UIColor.hex(0xCECECE)
        circleView?.progress = Float(50) / 100
    }
    
    
    
}
