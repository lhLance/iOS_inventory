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
    var nameListView: UIView?
    var title2: UILabel?
    var spectrumMapView: UIView?
    var chartView: PieChartView?
    
    let partiesTitleArr = ["待机", "断开", "通电", "报警", "运行"]
    let partiesArr = [1, 2, 4.5, 2, 0.5]
    let OEEtimeArr = [[0 , 2],
                      [2, 4],
                      [4, 9],
                      [10, 18],
                      [18, 24]]
    let OEEtimeColorArr = [UIColor.red,
                           UIColor.blue,
                           UIColor.green,
                           UIColor.yellow,
                           UIColor.cyan]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    func setupView() {
        
        setupTimeEView()
        setupPieChartView()
    }
    
    func setupTimeEView() {
        
        title = UILabel()
        title?.added(into: self)
        title?.snp.makeConstraints({ (make) in
            make.top.equalTo(10)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        })
        title?.Text("时间效率分析").Font(.PFRegular(16))
        
        spectrumMapView = UIView().then({ (s) in
            s.added(into: self)
            s.snp.makeConstraints({ (make) in
                make.top.equalTo(title?.snp.bottom ?? 0).offset(5)
                make.left.right.equalToSuperview()
                make.height.equalTo(120)
            })
            
            for (index, item) in OEEtimeArr.enumerated() {
                let l = CALayer()
                l.frame = CGRect(28 + (CGFloat(item[0]) / 24) * (UIScreen.width - 52),
                                 40,
                                 CGFloat(item[1] - item[0]) / 24 * (UIScreen.width - 52),
                                 70)
                s.layer.addSublayer(l)
                l.backgroundColor = OEEtimeColorArr[index].cgColor
            }
            
            _ = CALayer().then({ (l) in
                l.frame = CGRect(26, 110, UIScreen.width - 48, 1)
                l.backgroundColor = UIColor.gray.cgColor
                s.layer.addSublayer(l)
            })
            
            _ = CALayer().then({ (l) in
                l.frame = CGRect(28, 110, 1, 5)
                l.backgroundColor = UIColor.gray.cgColor
                s.layer.addSublayer(l)
            })
            
            _ = UILabel().then({ (l) in
                l.frame = CGRect(16, 113, (UIScreen.width - 52) / 5, 15)
                l.added(into: s)
                l.Text("0:00").Font(UIFont.PFRegular(12)).TextColor(UIColor.gray)
            })
            
            _ = CALayer().then({ (l) in
                l.frame = CGRect(28 + (UIScreen.width - 52) / 5, 110, 1, 5)
                l.backgroundColor = UIColor.gray.cgColor
                s.layer.addSublayer(l)
            })
            
            _ = UILabel().then({ (l) in
                l.frame = CGRect(16 + (UIScreen.width - 52) / 5, 113, (UIScreen.width - 52) / 5, 15)
                l.added(into: s)
                l.Text("5:00").Font(UIFont.PFRegular(12)).TextColor(UIColor.gray)
            })
            
            _ = CALayer().then({ (l) in
                l.frame = CGRect(28 + 2 * (UIScreen.width - 52) / 5, 110, 1, 5)
                l.backgroundColor = UIColor.gray.cgColor
                s.layer.addSublayer(l)
            })
            
            _ = UILabel().then({ (l) in
                l.frame = CGRect(16 + 2 * (UIScreen.width - 52) / 5, 113, (UIScreen.width - 52) / 5, 15)
                l.added(into: s)
                l.Text("10:00").Font(UIFont.PFRegular(12)).TextColor(UIColor.gray)
            })
            
            _ = CALayer().then({ (l) in
                l.frame = CGRect(28 + 3 * (UIScreen.width - 52) / 5, 110, 1, 5)
                l.backgroundColor = UIColor.gray.cgColor
                s.layer.addSublayer(l)
            })
            
            _ = UILabel().then({ (l) in
                l.frame = CGRect(16 + 3 * (UIScreen.width - 52) / 5, 113, (UIScreen.width - 52) / 5, 15)
                l.added(into: s)
                l.Text("15:00").Font(UIFont.PFRegular(12)).TextColor(UIColor.gray)
            })
            
            _ = CALayer().then({ (l) in
                l.frame = CGRect(28 + 4 * (UIScreen.width - 52) / 5, 110, 1, 5)
                l.backgroundColor = UIColor.gray.cgColor
                s.layer.addSublayer(l)
            })
            
            _ = UILabel().then({ (l) in
                l.frame = CGRect(16 + 4 * (UIScreen.width - 52) / 5, 113, (UIScreen.width - 52) / 5, 15)
                l.added(into: s)
                l.Text("20:00").Font(UIFont.PFRegular(12)).TextColor(UIColor.gray)
            })
            
            _ = CALayer().then({ (l) in
                l.frame = CGRect(28 + 5 * (UIScreen.width - 52) / 5, 110, 1, 5)
                l.backgroundColor = UIColor.gray.cgColor
                s.layer.addSublayer(l)
            })
            
            _ = UILabel().then({ (l) in
                l.frame = CGRect(16 + 5 * (UIScreen.width - 52) / 5, 113, (UIScreen.width - 52) / 5, 15)
                l.added(into: s)
                l.Text("24:00").Font(UIFont.PFRegular(12)).TextColor(UIColor.gray)
            })
        })
        
        nameListView = UIView().then({ (v) in
            v.added(into: self)
            v.snp.makeConstraints({ (make) in
                make.left.right.equalToSuperview()
                make.top.equalTo(spectrumMapView?.snp.bottom ?? 0)
                make.height.equalTo(35)
            })
            
            let startLbl = UILabel().then({ (l) in
                l.Text("开机").Font(.PFRegular(14))
                l.added(into: v)
                l.snp.makeConstraints({ (make) in
                    make.center.equalToSuperview()
                    make.top.bottom.equalToSuperview()
                })
            })
            
            let awaitIcon = UIView().then({ (l) in
                l.backgroundColor = UIColor.yellow
                l.cornerRadius = 5
                l.added(into: v)
                l.snp.makeConstraints({ (make) in
                    make.right.equalTo(startLbl.snp.left).offset(-9)
                    make.width.height.equalTo(10)
                    make.centerY.equalToSuperview()
                })
            })
            
            let awaitLbl = UILabel().then({ (l) in
                l.Text("待机").Font(.PFRegular(14))
                l.added(into: v)
                l.snp.makeConstraints({ (make) in
                    make.right.equalTo(awaitIcon.snp.left).offset(-3)
                    make.centerY.equalToSuperview()
                })
            })
            
            let workIcon = UIView().then({ (l) in
                l.backgroundColor = UIColor.green
                l.cornerRadius = 5
                l.added(into: v)
                l.snp.makeConstraints({ (make) in
                    make.right.equalTo(awaitLbl.snp.left).offset(-9)
                    make.width.height.equalTo(10)
                    make.centerY.equalToSuperview()
                })
            })
            
            _ = UILabel().then({ (l) in
                l.Text("工作").Font(UIFont.PFRegular(14))
                l.added(into: v)
                l.snp.makeConstraints({ (make) in
                    make.right.equalTo(workIcon.snp.left).offset(-3)
                    make.centerY.equalToSuperview()
                })
            })
            
            let startIcon = UIView().then({ (s) in
                s.backgroundColor = UIColor.blue
                s.cornerRadius = 5
                s.added(into: v)
                s.snp.makeConstraints({ (make) in
                    make.left.equalTo(startLbl.snp.right).offset(3)
                    make.width.height.equalTo(10)
                    make.centerY.equalToSuperview()
                })
            })
            
            let offlineLbl = UILabel().then({ (l) in
                l.Text("离线").Font(UIFont.PFRegular(14))
                l.added(into: v)
                l.snp.makeConstraints({ (make) in
                    make.left.equalTo(startIcon.snp.right).offset(9)
                    make.centerY.equalToSuperview()
                })
            })
            
            let offlineIcon = UIView().then({ (o) in
                o.added(into: v)
                o.cornerRadius = 5
                o.backgroundColor = UIColor.gray
                o.snp.makeConstraints({ (make) in
                    make.left.equalTo(offlineLbl.snp.right).offset(3)
                    make.width.height.equalTo(10)
                    make.centerY.equalToSuperview()
                })
            })
            
            let alarmLbl = UILabel().then({ (l) in
                l.Text("报警").Font(UIFont.PFRegular(14))
                l.added(into: v)
                l.snp.makeConstraints({ (make) in
                    make.left.equalTo(offlineIcon.snp.right).offset(9)
                    make.centerY.equalToSuperview()
                })
            })
            
            _ = UIView().then({ (i) in
                i.added(into: v)
                i.backgroundColor = UIColor.red
                i.cornerRadius = 5
                i.snp.makeConstraints({ (make) in
                    make.left.equalTo(alarmLbl.snp.right).offset(3)
                    make.width.height.equalTo(10)
                    make.centerY.equalToSuperview()
                })
            })
        })
    }
    
    func setupPieChartView() {
        
        title2 = UILabel().then({ (l) in
            l.Text("设备工作时间占比分析").Font(UIFont.PFRegular(16))
            l.added(into: self)
            l.snp.makeConstraints({ (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(nameListView?.snp.bottom ?? 0)
                make.height.equalTo(60)
            })
        })
        
        chartView = PieChartView()
        chartView?.added(into: self)
        chartView?.snp.makeConstraints({ (make) in
            make.top.equalTo(title2?.snp.bottom ?? 0)
            make.height.equalTo(160)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        })
        chartView?.usePercentValuesEnabled = true
        chartView?.drawSlicesUnderHoleEnabled = false
        chartView?.chartDescription?.enabled = false
        chartView?.setExtraOffsets(left: 5, top: 10, right: 5, bottom: 5)
        
        chartView?.drawCenterTextEnabled = true
        chartView?.centerAttributedText = nil
        
        chartView?.drawHoleEnabled = false
        chartView?.rotationAngle = 0
        chartView?.rotationEnabled = true
        chartView?.highlightPerTapEnabled = true
        
        let l = chartView?.legend
        l?.horizontalAlignment = .right
        l?.verticalAlignment = .top
        l?.orientation = .vertical
        l?.drawInside = false
        l?.xEntrySpace = 7
        l?.yEntrySpace = 0
        l?.yOffset = 0
        
        setDataCount(5, range: 99)
    }
    
    func setDataCount(_ count: Int, range: UInt32) {
        
        let entries = (0..<count).map { (i) -> PieChartDataEntry in
            // IMPORTANT: In a PieChart, no values (Entry) should have the same xIndex (even if from different DataSets),
            // since no values can be drawn above each other.
            return PieChartDataEntry(value: Double(partiesArr[i]),
                                     label: partiesTitleArr[i % partiesTitleArr.count])
        }
        
        let set = PieChartDataSet(values: entries, label: "")
        set.sliceSpace = 2
        
        set.colors = ChartColorTemplates.vordiplom()
            + ChartColorTemplates.joyful()
            + ChartColorTemplates.colorful()
            + ChartColorTemplates.liberty()
            + ChartColorTemplates.pastel()
            + [UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)]
        
        set.valueLinePart1OffsetPercentage = 0.8
        set.valueLinePart1Length = 0.2
        set.valueLinePart2Length = 0.4
        set.xValuePosition = .insideSlice
        set.yValuePosition = .outsideSlice
        
        let data = PieChartData(dataSet: set)
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        data.setValueFont(.systemFont(ofSize: 11, weight: .light))
        data.setValueTextColor(.black)
        
        chartView?.data = data
        chartView?.highlightValues(nil)
    }

}
