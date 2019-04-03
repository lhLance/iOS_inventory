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
        title?.Text("开机统计").Font(UIFont.PFRegular(16))
        
        setupChartView()
    }
    
    func setupChartView() {
        
        chartView = LineChartView()
        chartView.added(into: self)
        chartView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(200)
            make.center.equalToSuperview()
        }
        chartView.chartDescription?.enabled = false
        chartView.leftAxis.enabled = false
        chartView.rightAxis.drawAxisLineEnabled = false
        chartView.xAxis.drawAxisLineEnabled = false
        chartView.drawBordersEnabled = false
        chartView.setScaleEnabled(true)
        
        let l = chartView.legend
        l.horizontalAlignment = .right
        l.verticalAlignment = .top
        l.orientation = .vertical
        l.drawInside = false
        
        setDataCount(20, range: 60)
    }
    
    func setDataCount(_ count: Int, range: UInt32) {
        let colors = ChartColorTemplates.vordiplom()[0...2]
        
        let block: (Int) -> ChartDataEntry = { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(range) + 3)
            return ChartDataEntry(x: Double(i), y: val)
        }
        let dataSets = (0..<3).map { i -> LineChartDataSet in
            let yVals = (0..<count).map(block)
            let set = LineChartDataSet(values: yVals, label: "DataSet \(i)")
            set.lineWidth = 1
//            set.circleRadius = 4
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
