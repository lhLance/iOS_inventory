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
        title?.Text("开机统计").Font(.PFRegular(16))
        
        setupChartView()
    }
    
    func setupChartView() {
        
        chartView = LineChartView()
        chartView.added(into: self)
        chartView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(200)
            make.centerX.equalToSuperview()
            make.top.equalTo(title?.snp.bottom ?? 0).offset(5)
        }
        chartView.chartDescription?.enabled = false
        chartView.leftAxis.enabled = true
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.minimumFractionDigits = 0
        leftAxisFormatter.maximumFractionDigits = 1
        leftAxisFormatter.negativeSuffix = " 分钟"
        leftAxisFormatter.positiveSuffix = " 分钟"
        
        chartView.leftAxis.labelFont = .systemFont(ofSize: 10)
        chartView.leftAxis.labelCount = 8
        chartView.leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter)
        chartView.rightAxis.enabled = false
        chartView.rightAxis.drawAxisLineEnabled = false
        chartView.xAxis.drawAxisLineEnabled = false
        chartView.xAxis.labelPosition = .bottom
        chartView.drawBordersEnabled = false
        chartView.setScaleEnabled(true)

        setDataCount(xRange: 16, yRange: 75)
    }
    
    func setDataCount(xRange: Int, yRange: UInt32) {
        
        let colors = ChartColorTemplates.vordiplom()[0...2]
        let titleArr = ["开机时间", "工作时间"]
        
        let block: (Int) -> ChartDataEntry = { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(yRange) + 3)
            return ChartDataEntry(x: Double(i), y: val)
        }
        
        let dataSets = (0..<2).map { i -> LineChartDataSet in
            let yVals = (0..<xRange).map(block)
            let set = LineChartDataSet(values: yVals, label: titleArr[i])
            set.lineWidth = 1
            set.drawFilledEnabled = true
            set.drawCirclesEnabled = false
            let color = colors[i % colors.count]
            set.setColor(color)
            set.setCircleColor(color)
            
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
