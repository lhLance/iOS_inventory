//
//  BootStatisticsView.swift
//  Fii
//
//  Created by Liu Tao on 2019/3/27.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import UIKit
import Charts
import SnapKit

class BootStatisticsView: UIView {

    var title: UILabel?
    var chartView: LineChartView!
    var leftAxisFormatter: NumberFormatter?
    var dayLbl: UILabel?
    var startTime: UILabel?
    var endTime: UILabel?
    
    let timeArr: [[Double]] = [[29, 29, 29, 29, 29, 77, 55, 39, 67, 90, 75, 30, 23, 3, 9],
                               [37, 35, 60, 12, 56, 44, 63, 27, 19, 20, 36, 36, 36, 36, 36]]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setupView() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadData),
                                               name: NSNotification.Name(rawValue: "LanguageChanged"),
                                               object: nil)
        
        title = UILabel()
        title?.added(into: self)
        title?.snp.makeConstraints({ (make) in
            make.top.equalTo(5)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
        })
        title?.Text(LanguageHelper.getString(key: "home_start_statistic_title")).Font(.PFRegular(16))
        
        setupChartView()
    }
    
    @objc func reloadData() {
        
        title?.Text(LanguageHelper.getString(key: "home_start_statistic_title"))
        leftAxisFormatter?.negativeSuffix = " " + LanguageHelper.getString(key: "home_start_statistic_min")
        leftAxisFormatter?.positiveSuffix = " " + LanguageHelper.getString(key: "home_start_statistic_min")
        dayLbl?.Text(LanguageHelper.getString(key: "home_start_statistic_day"))
        startTime?.Text(LanguageHelper.getString(key: "home_start_statistic_start_time"))
        endTime?.Text(LanguageHelper.getString(key: "home_start_statistic_work_time"))
    }
    
    func setupChartView() {
        
        chartView = LineChartView()
        chartView.added(into: self)
        chartView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(180)
            make.centerX.equalToSuperview()
            make.top.equalTo(title?.snp.bottom ?? 0).offset(5)
        }
        chartView.chartDescription?.enabled = false
        chartView.leftAxis.enabled = true
        leftAxisFormatter = NumberFormatter()
        leftAxisFormatter?.minimumFractionDigits = 0
        leftAxisFormatter?.maximumFractionDigits = 1
        leftAxisFormatter?.negativeSuffix = " " + LanguageHelper.getString(key: "home_start_statistic_min")
        leftAxisFormatter?.positiveSuffix = " " + LanguageHelper.getString(key: "home_start_statistic_min")
        
        chartView.leftAxis.labelFont = .systemFont(ofSize: 10)
        chartView.leftAxis.labelCount = 8
        chartView.leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter ?? NumberFormatter())
        chartView.rightAxis.enabled = false
        chartView.rightAxis.drawAxisLineEnabled = false
        chartView.xAxis.drawAxisLineEnabled = false
        chartView.xAxis.labelPosition = .bottom
        chartView.drawBordersEnabled = false
        chartView.setScaleEnabled(false)
        chartView.legend.enabled = false
        
        dayLbl = UILabel().then { (l) in
            l.added(into: self)
            l.snp.makeConstraints({ (make) in
                make.width.equalTo(15)
                make.height.equalTo(15)
                make.right.equalTo(-3)
                make.bottom.equalTo(-17)
            })
            l.Text(LanguageHelper.getString(key: "home_start_statistic_day")).TextColor(UIColor.black).Font(UIFont.PFRegular(10))
        }
        
        startTime = UILabel().then { (l) in
            l.added(into: self)
            l.snp.makeConstraints({ (make) in
                make.centerX.equalTo(self.snp.centerX).offset(-40)
                make.top.equalTo(chartView.snp.bottom)
                make.height.equalTo(20)
            })
            l.Text(LanguageHelper.getString(key: "home_start_statistic_start_time")).Font(UIFont.PFRegular(10))
        }
        
        _ = UIView().then({ (v) in
            v.added(into: self)
            v.snp.makeConstraints({ (make) in
                make.width.height.equalTo(8)
                make.right.equalTo(startTime?.snp.left ?? 0).offset(-3)
                make.centerY.equalTo(startTime?.snp.centerY ?? 0)
            })
            v.backgroundColor = UIColor.cyan
        })
        
        endTime = UILabel().then({ (l) in
            l.added(into: self)
            l.snp.makeConstraints({ (make) in
                make.centerX.equalTo(self.snp.centerX).offset(40)
                make.top.equalTo(chartView.snp.bottom)
                make.height.equalTo(20)
            })
            l.Text(LanguageHelper.getString(key: "home_start_statistic_work_time")).Font(UIFont.PFRegular(10))
        })
        
        _ = UIView().then({ (v) in
            v.added(into: self)
            v.snp.makeConstraints({ (make) in
                make.width.height.equalTo(8)
                make.right.equalTo(endTime?.snp.left ?? 0).offset(-3)
                make.centerY.equalTo(endTime?.snp.centerY ?? 0)
            })
            v.backgroundColor = UIColor.yellow
        })
        
        setDataCount(xRange: 15, yRange: 75)
    }
    
    func setDataCount(xRange: Int, yRange: UInt32) {
        
        let colors = ChartColorTemplates.vordiplom()[0...2]
        
        let dataSets = (0..<2).map { i -> LineChartDataSet in
            
            var yVals: [ChartDataEntry] = []
            
            for j in 0..<xRange {
                yVals.append(ChartDataEntry.init(x: Double(j + 1), y: timeArr[i][j]))
            }
            
            let set = LineChartDataSet(values: yVals,
                                       label: "")
            set.lineWidth = 1
            set.drawFilledEnabled = true
            set.drawCirclesEnabled = false
            let color = colors[i % colors.count]
            set.setColor(color)
            set.setCircleColor(color)
            if i == 0 {
                set.fillColor = UIColor.cyan
            } else {
                set.fillColor = UIColor.yellow
            }
            
            return set
        }
        
        dataSets[0].lineDashLengths = [5, 5]
        dataSets[0].colors = ChartColorTemplates.vordiplom()
        dataSets[0].circleColors = ChartColorTemplates.vordiplom()
        
        let data = LineChartData(dataSets: dataSets)
        data.setValueFont(.systemFont(ofSize: 7, weight: .light))
        chartView.data = data
    }

}
