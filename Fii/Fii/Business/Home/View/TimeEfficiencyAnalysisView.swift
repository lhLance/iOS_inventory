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
    var chartView: PieChartView?
    
    let parties = ["A", "B", "C", "D", "E", "F",
                   "G", "H", "I", "J", "K", "L",
                   "M", "N", "O", "P", "Q", "R",
                   "S", "T", "U", "V", "W", "X",
                   "Y", "Z"]
    
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
            make.top.equalTo(0)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
        })
        title?.Text("时间效率分析").Font(UIFont.PFRegular(16))
        
        setupPieChartView()
    }
    
    func setupPieChartView() {
        
        chartView = PieChartView()
        chartView?.added(into: self)
        chartView?.snp.makeConstraints({ (make) in
            make.height.equalTo(200)
            make.width.equalToSuperview()
            make.center.equalToSuperview()
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
        
        setDataCount(6, range: 99)
    }
    
    func setDataCount(_ count: Int, range: UInt32) {
        
        let entries = (0..<count).map { (i) -> PieChartDataEntry in
            // IMPORTANT: In a PieChart, no values (Entry) should have the same xIndex (even if from different DataSets),
            // since no values can be drawn above each other.
            return PieChartDataEntry(value: Double(arc4random_uniform(range) + range / 5),
                                     label: parties[i % parties.count])
        }
        
        let set = PieChartDataSet(values: entries, label: "Election Results")
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
