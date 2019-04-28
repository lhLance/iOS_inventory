//
//  YTPageView.swift
//  Fii
//
//  Created by yetao on 2019/4/16.
//  Copyright © 2019 Liu Tao. All rights reserved.
//

import UIKit

class YTPageView: UIView {
    
    fileprivate var titles: [String]
    fileprivate var childVCs: [UIViewController]
    fileprivate var parentVC: UIViewController
    fileprivate var titleStyle: YTPageStyle
    
    init(frame: CGRect,
         titles: [String],
         childVCs: [UIViewController],
         parentVC: UIViewController,
         titleStyle: YTPageStyle)
    {
        self.titles = titles
        self.childVCs = childVCs
        self.parentVC = parentVC
        self.titleStyle = titleStyle
        
        super.init(frame:frame)    //init之前必须初始化所有的属性
        setupUI()
        
    }
    
    //调用xib的时候会调用此方法，但不希望外界调用它，所以抛错误
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        // 添加titleView
        let contentH = (kStatusBarH + kTabBarH + SafeAreaBottomHeight + kNavigationBar + titleStyle.titleViewHeight)
        let titleFrame = CGRect(x: 0,
                                y: kNavigationBar + kStatusBarH,
                                width: bounds.width,
                                height: titleStyle.titleViewHeight)
        let titleView = YTPageTitleView(frame: titleFrame,
                                        titles: titles,
                                        style: titleStyle)
        
        titleView.backgroundColor = UIColor.white
        addSubview(titleView)
        
        // 添加contentView
        let contentFrame = CGRect(x:0,
                                  y: titleFrame.maxY,
                                  width: bounds.size.width,
                                  height: bounds.size.height - contentH)
        let contentView = YTPageContenvView(frame: contentFrame,
                                            childVs: childVCs,
                                            parentVc: parentVC)
        contentView.backgroundColor = UIColor.random
        addSubview(contentView)
        
        // 两个View联系起来
        titleView.delegate = (contentView as YTPageTitleViewDelegate)
        contentView.delegate = (titleView as YTPageContenvViewDelegate)
    }
}



