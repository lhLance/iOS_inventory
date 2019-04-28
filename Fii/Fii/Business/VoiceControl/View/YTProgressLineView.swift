//
//  YTProgressLineView.swift
//  Fii
//
//  Created by yetao on 2019/4/18.
//  Copyright © 2019 Ye Tao. All rights reserved.
//

import UIKit

class YTProgressLineView: UIView {
    /// 未完成
    var lineUndoView:UIView = UIView()
    /// 已完成
    var lineDoneView:UIView = UIView()
    //数据数组
    var dataArray:[String] = [String]()
    //标志位
    //     var markI:UILabel?
    
    ///当前的索引
    var index:Int!{
        
        didSet{
            
            //如果超出标签，则不做操作
            guard index! >=  0 && index! <= self.dataArray.count else {
                return
            }
            
            //每个的宽度
            let per_W = self.frame.size.width / CGFloat (self.dataArray.count)
            
            //重新设置 完成视图的frame
            self.lineDoneView.frame = CGRect.init(x: lineUndoView.frame.origin.x, y: lineUndoView.frame.origin.y, width: per_W * CGFloat (index!), height: self.lineUndoView.frame.size.height)
            self.lineDoneView.layer.cornerRadius = lineUndoView.layer.cornerRadius
            
            if index ==  self.dataArray.count{
                if #available(iOS 11.0, *) {
                    self.lineDoneView.layer.maskedCorners = [CACornerMask.layerMinXMinYCorner , CACornerMask.layerMinXMaxYCorner,CACornerMask.layerMaxXMinYCorner , CACornerMask.layerMaxXMaxYCorner]
                } else {
                    // Fallback on earlier versions
                }
            }
            else{
                if #available(iOS 11.0, *) {
                    self.lineDoneView.layer.maskedCorners = [CACornerMask.layerMinXMinYCorner , CACornerMask.layerMinXMaxYCorner]
                } else {
                    // Fallback on earlier versions
                }
                /*左边半圆角,只支持iOS11以上*/
            }
        }
    }
    
    
    init(frame:CGRect,dataArr:[String]) {
        
        super.init(frame: frame)
        
        //默认选择第一个
        index = 0
        
        //加载数据
        self.dataArray = dataArr
        
        //未完成线段绘制
        let line_W = frame.size.width
        lineUndoView.frame  =  CGRect.init(x: 0, y: 0, width: line_W, height: self.frame.size.height)
        lineUndoView.layer.cornerRadius = 10
//        lineUndoView.center = CGPoint.init(x: self.center.x, y: self.frame.size.height / 2)
        lineUndoView.backgroundColor = colorWithRGBA(red: 235, green: 235, blue: 235, alpha: 1.0)
        self.addSubview(lineUndoView)
        
        //已经完成的初始化
        lineDoneView.frame = CGRect.zero
        lineDoneView.backgroundColor = colorWithRGBA(red: 54, green: 86, blue: 169, alpha: 1.0)
        self.addSubview(lineDoneView)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
