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
    var oeeLabel: UILabel?
    
    var useRateLbl: UILabel?
    var presentLbl: UILabel?
    var GIndexLbl: UILabel?
    var useRateValueLbl: UILabel?
    var presentValueLbl: UILabel?
    var GIndexValueLbl: UILabel?
    
    let oeeValue = 40
    
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
        title?.Text("OEE效率分析").Font(.PFRegular(16))
        
        circleView = FiiCircleView()
        circleView?.added(into: self)
        circleView?.snp.makeConstraints({ (make) in
            make.top.equalTo(title?.snp.bottom ?? 0).offset(10)
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.centerX.equalToSuperview().offset(-50)
        })
        circleView?.progress = 0.5
        circleView?.lineWidth = 15
        circleView?.backColor = UIColor.hex(0xf4f4f4)
        circleView?.strokeColor = UIColor.hex(0x84dce1)
        
        oeeLabel = UILabel()
        oeeLabel?.Text("\(oeeValue) %").Font(.PFRegular(18)).TextAlignment(.center)
        oeeLabel?.added(into: self)
        oeeLabel?.snp.makeConstraints({ (make) in
            make.center.equalTo(circleView?.snp.center ?? 0)
            make.width.equalTo(60)
            make.height.equalTo(100)
        })
        
        useRateLbl = UILabel().then({ (l) in
            l.added(into: self)
            l.snp.makeConstraints({ (make) in
                make.top.equalTo(circleView?.snp.top ?? 0)
                make.left.equalTo(circleView?.snp.right ?? 0).offset(40)
            })
            l.Text("可用率:").TextColor(UIColor.gray).Font(.PFRegular(14))
        })
        
        useRateValueLbl = UILabel().then({ (l) in
            l.added(into: self)
            l.snp.makeConstraints({ (make) in
                make.centerY.equalTo(useRateLbl?.snp.centerY ?? 0)
                make.left.equalTo(useRateLbl?.snp.right ?? 0).offset(3)
            })
            l.Text("30 %").TextColor(UIColor.gray).Font(.PFRegular(14))
        })
        
        presentLbl = UILabel().then({ (l) in
            l.added(into: self)
            l.snp.makeConstraints({ (make) in
                make.centerY.equalTo(circleView?.snp.centerY ?? 0)
                make.left.equalTo(circleView?.snp.right ?? 0).offset(40)
            })
            l.Text("表现性:").TextColor(UIColor.gray).Font(.PFRegular(14))
        })
        
        presentValueLbl = UILabel().then({ (l) in
            l.added(into: self)
            l.snp.makeConstraints({ (make) in
                make.centerY.equalTo(presentLbl?.snp.centerY ?? 0)
                make.left.equalTo(presentLbl?.snp.right ?? 0).offset(3)
            })
            l.Text("0.5").TextColor(UIColor.gray).Font(.PFRegular(14))
        })
        
        GIndexLbl = UILabel().then({ (l) in
            l.added(into: self)
            l.snp.makeConstraints({ (make) in
                make.bottom.equalTo(circleView?.snp.bottom ?? 0)
                make.left.equalTo(circleView?.snp.right ?? 0).offset(40)
            })
            l.Text("质量指数:").TextColor(UIColor.gray).Font(.PFRegular(14))
        })
        
        GIndexValueLbl = UILabel().then({ (l) in
            l.added(into: self)
            l.snp.makeConstraints({ (make) in
                make.centerY.equalTo(GIndexLbl?.snp.centerY ?? 0)
                make.left.equalTo(GIndexLbl?.snp.right ?? 0).offset(3)
            })
            l.Text("3").TextColor(UIColor.gray).Font(.PFRegular(14))
        })
    }
}
