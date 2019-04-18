//
//  YTPageStyle.swift
//  Fii
//
//  Created by yetao on 2019/4/16.
//  Copyright © 2019 Liu Tao. All rights reserved.
//

import UIKit

class YTPageStyle {
    
    //标题视图的高度
    var titleViewHeight: CGFloat = 40.0
    //title文字颜色
    //上传github后的版本测试。。。
//    var normalColor: UIColor = colorWithRGBA(red: 121, green: 121, blue: 121, alpha: 1.0)
//    var selectColor: UIColor = colorWithRGBA(red: 255, green: 255, blue: 255, alpha: 1.0)
    
    var normalColor: UIColor = colorWithRGBA(red: 255, green: 0, blue: 255, alpha: 1.0)
    var selectColor: UIColor = colorWithRGBA(red: 0, green: 255, blue: 255, alpha: 1.0)

    var titleFont : UIFont = UIFont.boldSystemFont(ofSize: 17)
    var isScrollEnabel: Bool = true    //默认不能滚动
    var titleMargin: CGFloat = 20.0   //可以滚动的时候的间距
    var isShowBottomLine: Bool = false  //是否需要显示下划线
    var isAnimate: Bool = true         //默认有动画
    var isNeedScale: Bool = false       //是否需要缩放
    var isShowCoverView: Bool = true              //是否显示遮盖
    var maxScale: CGFloat = 1.2        //最大缩放1.2
    var bottomLineColor: UIColor = UIColor.green  //下划线颜色(默认绿色)
    var bottomLineHeight: CGFloat = 2
    
    var coverViewColor: UIColor = UIColor.gray   //遮盖的颜色
    var coverViewAlpha: CGFloat = 0.5              //遮盖透明度
    var coverViewHeight: CGFloat = 40              //遮盖高度
    var coverViewCoradius: CGFloat = 0           //遮盖圆角
    var coverMargin: CGFloat = 5.0                 //间距
    
}
