//
//  EquipmentWorkRatioAnalysisView.swift
//  Fii
//
//  Created by Thomas Lau on 2019/4/9.
//  Copyright © 2019 Liu Tao. All rights reserved.
//

import UIKit
import SnapKit
import Charts

class EquipmentWorkRatioAnalysisView: UIView {

    var title2: UILabel?
    var chartView: PieChartView?
    
    let partiesTitleArr = [LanguageHelper.getString(key: "home_device_efficency_analyse_wait"),
                           LanguageHelper.getString(key: "home_device_efficency_analyse_offline"),
                           LanguageHelper.getString(key: "home_device_efficency_analyse_charge"),
                           LanguageHelper.getString(key: "home_device_efficency_analyse_alarm"),
                           LanguageHelper.getString(key: "home_device_efficency_analyse_operate")]
    let partiesArr = [1, 2, 4.5, 2, 0.5]
    
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
        
        setupPieChartView()
    }
    
    func setupPieChartView() {
        
        title2 = UILabel().then({ (l) in
            l.Text(LanguageHelper.getString(key: "home_device_efficency_analyse_title")).Font(.PFRegular(16))
            l.added(into: self)
            l.snp.makeConstraints({ (make) in
                make.centerX.equalToSuperview()
                make.top.equalToSuperview()
                make.height.equalTo(40)
            })
        })
        
        chartView = PieChartView()
        chartView?.added(into: self)
        chartView?.snp.makeConstraints({ (make) in
            make.top.equalTo(title2?.snp.bottom ?? 0)
            make.height.equalTo(180)
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
    
    @objc func reloadData() {
        
        setDataCount(5, range: 99)
    }
}
