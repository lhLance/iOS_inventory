//
//  TimeEfficiencyAnalysisView.swift
//  Fii
//
//  Created by Liu Tao on 2019/3/27.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import UIKit
import SnapKit
import Charts

class TimeEfficiencyAnalysisView: UIView {
    
    var title: UILabel?
    var goodLbl: UILabel?
    var startTlbl: UILabel?
    var endTlbl: UILabel?
    var chartView: PieChartView?
    var OEEStateLbl: UILabel?
    
    let OEEState = [LanguageHelper.getString(key: "home_time_efficency_analyse_good"),
                    LanguageHelper.getString(key: "home_time_efficency_analyse_decent"),
                    LanguageHelper.getString(key: "home_time_efficency_analyse_middle"),
                    LanguageHelper.getString(key: "home_time_efficency_analyse_bad")]
    let OEENameArr = [LanguageHelper.getString(key: "home_time_efficency_analyse_work"),
                      LanguageHelper.getString(key: "home_time_efficency_analyse_wait"),
                      LanguageHelper.getString(key: "home_time_efficency_analyse_start"),
                      LanguageHelper.getString(key: "home_time_efficency_analyse_offline"),
                      LanguageHelper.getString(key: "home_time_efficency_analyse_alarm")]
    let OEEtimeArr = [8, 6, 5, 2, 3]
    let OEEtimeColorArr = [UIColor.hex(0xb7da73),
                           UIColor.hex(0xebdea4),
                           UIColor.hex(0x84dce1),
                           UIColor.hex(0xb0b0b0),
                           UIColor.hex(0xda7373)]
    
    
    var workLbl: UILabel?
    var waitLbl: UILabel?
    var bootLbl: UILabel?
    var offlineLbl: UILabel?
    var alarmLbl: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    func setupView() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadData),
                                               name: NSNotification.Name(rawValue: "LanguageChanged"),
                                               object: nil)
        
        setupTimeEView()
        setupPieChartView()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setupTimeEView() {
        
        title = UILabel()
        title?.added(into: self)
        title?.snp.makeConstraints({ (make) in
            make.top.equalTo(10)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        })
        title?.Text(LanguageHelper.getString(key: "home_time_efficency_analyse_title")).Font(.PFRegular(16))
        
        startTlbl = UILabel().then({ (l) in
            l.added(into: self)
            l.snp.makeConstraints({ (make) in
                make.left.equalTo(50)
                make.top.equalTo(title?.snp.bottom ?? 0)
                make.height.equalTo(15)
            })
            l.Text("0").TextColor(UIColor.gray).Font(.PFRegular(15))
        })
        
        workLbl = UILabel().then { (l) in
            l.added(into: self)
            l.snp.makeConstraints({ (make) in
                make.left.equalTo(15)
                make.top.equalTo(startTlbl?.snp.bottom ?? 0).offset(10)
                make.height.equalTo(15)
                make.width.equalTo(25)
            })
            l.Text(LanguageHelper.getString(key: "home_time_efficency_analyse_work")).TextColor(UIColor.hex(0x000000)).Font(.PFRegular(12))
        }
        
        let lineView = FiiLineView()
        lineView.added(into: self)
        lineView.snp.makeConstraints { (make) in
            make.width.equalTo(UIScreen.width * 0.4)
            make.height.equalTo(6)
            make.centerY.equalTo(workLbl?.snp.centerY ?? 0).offset(3)
            make.left.equalTo(workLbl?.snp.right ?? 0).offset(10)
        }
        lineView.progress = Float(OEEtimeArr[0]) * 0.1
        lineView.strokeColor = UIColor.hex(0xb7da73)
        lineView.backColor = UIColor.hex(0xf4f4f4)
        
        _ = UILabel().then { (l) in
            l.added(into: self)
            l.snp.makeConstraints({ (make) in
                make.centerY.equalTo(lineView.snp.centerY).offset(-3)
                make.left.equalTo(lineView.snp.right).offset(8)
            })
            l.Text("\(OEEtimeArr[0])").TextColor(UIColor.gray).Font(.PFRegular(12))
        }
        
        endTlbl = UILabel().then({ (l) in
            l.added(into: self)
            l.snp.makeConstraints({ (make) in
                make.right.equalTo(lineView.snp.right)
                make.centerY.equalTo(startTlbl?.snp.centerY ?? 0)
            })
            l.Text("24h").TextColor(UIColor.gray).Font(.PFRegular(15))
        })
        
        waitLbl = UILabel().then { (l) in
            l.added(into: self)
            l.snp.makeConstraints({ (make) in
                make.left.equalTo(15)
                make.top.equalTo(workLbl?.snp.bottom ?? 0).offset(10)
                make.height.equalTo(15)
                make.width.equalTo(25)
            })
            l.Text(LanguageHelper.getString(key: "home_time_efficency_analyse_wait")).TextColor(UIColor.hex(0x000000)).Font(.PFRegular(12))
        }
        
        let lineView2 = FiiLineView()
        lineView2.added(into: self)
        lineView2.snp.makeConstraints { (make) in
            make.width.equalTo(UIScreen.width * 0.4)
            make.height.equalTo(6)
            make.centerY.equalTo(waitLbl?.snp.centerY ?? 0).offset(3)
            make.left.equalTo(waitLbl?.snp.right ?? 0).offset(10)
        }
        lineView2.progress = Float(OEEtimeArr[1]) * 0.1
        lineView2.strokeColor = UIColor.hex(0xebdea4)
        lineView2.backColor = UIColor.hex(0xf4f4f4)
        
        _ = UILabel().then { (l) in
            l.added(into: self)
            l.snp.makeConstraints({ (make) in
                make.centerY.equalTo(lineView2.snp.centerY).offset(-3)
                make.left.equalTo(lineView2.snp.right).offset(8)
            })
            l.Text("\(OEEtimeArr[1])").TextColor(UIColor.gray).Font(.PFRegular(12))
        }
        
        bootLbl = UILabel().then { (l) in
            l.added(into: self)
            l.snp.makeConstraints({ (make) in
                make.left.equalTo(15)
                make.top.equalTo(waitLbl?.snp.bottom ?? 0).offset(10)
                make.height.equalTo(15)
                make.width.equalTo(25)
            })
            l.Text(LanguageHelper.getString(key: "home_time_efficency_analyse_start")).TextColor(UIColor.hex(0x000000)).Font(.PFRegular(12))
        }
        
        let lineView3 = FiiLineView()
        lineView3.added(into: self)
        lineView3.snp.makeConstraints { (make) in
            make.width.equalTo(UIScreen.width * 0.4)
            make.height.equalTo(6)
            make.centerY.equalTo(bootLbl?.snp.centerY ?? 0).offset(3)
            make.left.equalTo(bootLbl?.snp.right ?? 0).offset(10)
        }
        lineView3.progress = Float(OEEtimeArr[2]) * 0.1
        lineView3.strokeColor = UIColor.hex(0x84dce1)
        lineView3.backColor = UIColor.hex(0xf4f4f4)
        
        _ = UILabel().then { (l) in
            l.added(into: self)
            l.snp.makeConstraints({ (make) in
                make.centerY.equalTo(lineView3.snp.centerY).offset(-3)
                make.left.equalTo(lineView3.snp.right).offset(8)
            })
            l.Text("\(OEEtimeArr[2])").TextColor(UIColor.gray).Font(.PFRegular(12))
        }
        
        offlineLbl = UILabel().then { (l) in
            l.added(into: self)
            l.snp.makeConstraints({ (make) in
                make.left.equalTo(15)
                make.top.equalTo(bootLbl?.snp.bottom ?? 0).offset(10)
                make.height.equalTo(15)
                make.width.equalTo(25)
            })
            l.Text(LanguageHelper.getString(key: "home_time_efficency_analyse_offline")).TextColor(UIColor.hex(0x000000)).Font(.PFRegular(12))
        }
        
        let lineView4 = FiiLineView()
        lineView4.added(into: self)
        lineView4.snp.makeConstraints { (make) in
            make.width.equalTo(UIScreen.width * 0.4)
            make.height.equalTo(6)
            make.centerY.equalTo(offlineLbl?.snp.centerY ?? 0).offset(3)
            make.left.equalTo(offlineLbl?.snp.right ?? 0).offset(10)
        }
        lineView4.progress = Float(OEEtimeArr[3]) * 0.1
        lineView4.strokeColor = UIColor.hex(0xb0b0b0)
        lineView4.backColor = UIColor.hex(0xf4f4f4)
        
        _ = UILabel().then { (l) in
            l.added(into: self)
            l.snp.makeConstraints({ (make) in
                make.centerY.equalTo(lineView4.snp.centerY).offset(-3)
                make.left.equalTo(lineView4.snp.right).offset(8)
            })
            l.Text("\(OEEtimeArr[3])").TextColor(UIColor.gray).Font(.PFRegular(12))
        }
        
        alarmLbl = UILabel().then { (l) in
            l.added(into: self)
            l.snp.makeConstraints({ (make) in
                make.left.equalTo(15)
                make.top.equalTo(offlineLbl?.snp.bottom ?? 0).offset(10)
                make.height.equalTo(15)
                make.width.equalTo(25)
            })
            l.Text(LanguageHelper.getString(key: "home_time_efficency_analyse_alarm")).TextColor(UIColor.hex(0x000000)).Font(.PFRegular(12))
        }
        
        let lineView5 = FiiLineView()
        lineView5.added(into: self)
        lineView5.snp.makeConstraints { (make) in
            make.width.equalTo(UIScreen.width * 0.4)
            make.height.equalTo(6)
            make.centerY.equalTo(alarmLbl?.snp.centerY ?? 0).offset(3)
            make.left.equalTo(alarmLbl?.snp.right ?? 0).offset(10)
        }
        lineView5.progress = Float(OEEtimeArr[4]) * 0.1
        lineView5.strokeColor = UIColor.hex(0xda7373)
        lineView5.backColor = UIColor.hex(0xf4f4f4)
        
        _ = UILabel().then { (l) in
            l.added(into: self)
            l.snp.makeConstraints({ (make) in
                make.centerY.equalTo(lineView5.snp.centerY).offset(-3)
                make.left.equalTo(lineView5.snp.right).offset(8)
            })
            l.Text("\(OEEtimeArr[4])").TextColor(UIColor.gray).Font(.PFRegular(12))
        }
    }

    func setupPieChartView() {
        
        chartView = PieChartView()
        chartView?.added(into: self)
        chartView?.snp.makeConstraints({ (make) in
            make.top.equalTo(title?.snp.bottom ?? 0)
            make.bottom.equalTo(0)
            make.width.equalTo(UIScreen.width * 0.45)
            make.right.equalTo(20)
        })
        chartView?.usePercentValuesEnabled = false
        chartView?.drawSlicesUnderHoleEnabled = false
        chartView?.chartDescription?.enabled = false
        chartView?.setExtraOffsets(left: 5, top: 10, right: 5, bottom: 5)
        
        chartView?.drawCenterTextEnabled = true
        chartView?.centerAttributedText = nil
        
        chartView?.holeRadiusPercent = 0.7
        chartView?.drawHoleEnabled = true
        chartView?.rotationAngle = 0
        chartView?.rotationEnabled = true
        chartView?.highlightPerTapEnabled = false
        
        chartView?.legend.enabled = false
        
        setDataCount(5, range: 99)
        
        OEEStateLbl = UILabel().then({ (l) in
            l.added(into: chartView ?? UIView())
            l.snp.makeConstraints({ (make) in
                make.center.equalToSuperview()
            })
            if OEEtimeArr[4] == 0 {
                l.Text(OEEState[0])
            } else if OEEtimeArr[4] == 1 {
                l.Text(OEEState[1])
            } else if OEEtimeArr[4] > 1 || OEEtimeArr[4] < 2 {
                l.Text(OEEState[2])
            } else {
                l.Text(OEEState[3])
            }
        })
    }
    
    func setDataCount(_ count: Int, range: UInt32) {
        
        let entries = (0..<count).map { (i) -> PieChartDataEntry in
            return PieChartDataEntry(value: Double(OEEtimeArr[i]),
                                     label: "")
        }
        
        let set = PieChartDataSet(values: entries, label: "")
        set.sliceSpace = 2
        
        set.colors = ChartColorTemplates.vordiplom()
            + ChartColorTemplates.joyful()
            + ChartColorTemplates.colorful()
            + ChartColorTemplates.liberty()
            + ChartColorTemplates.pastel()
            + [UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)]
        
        set.valueLineWidth = 0
        set.valueLinePart1OffsetPercentage = 0.8
        set.valueLinePart1Length = 0.2
        set.valueLinePart2Length = 0.4
        set.xValuePosition = .insideSlice
        set.yValuePosition = .outsideSlice
        
        let data = PieChartData(dataSet: set)
        
        chartView?.data = data
        chartView?.highlightValues(nil)
    }
    
    @objc func reloadData() {
        
        title?.Text(LanguageHelper.getString(key: "home_time_efficency_analyse_title"))
        workLbl?.Text(LanguageHelper.getString(key: "home_time_efficency_analyse_work"))
        waitLbl?.Text(LanguageHelper.getString(key: "home_time_efficency_analyse_wait"))
        bootLbl?.Text(LanguageHelper.getString(key: "home_time_efficency_analyse_start"))
        offlineLbl?.Text(LanguageHelper.getString(key: "home_time_efficency_analyse_offline"))
        alarmLbl?.Text(LanguageHelper.getString(key: "home_time_efficency_analyse_alarm"))
    }
}
