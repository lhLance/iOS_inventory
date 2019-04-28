//
//  DeviceListVC.swift
//  Fii
//
//  Created by Liu Tao on 2019/3/11.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import UIKit
//private let kTitleViewH:CGFloat = 40.0

class DeviceListVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
}


extension DeviceListVC
{
    func setupUI() {
        //你所需要的视图控制器title
        let titleStyle = YTPageStyle()
        //*************设置可根据你项目的实际情况进行修改******************
        //设置titleView（标题栏是否可以滚动，根据你的titles的个数来决定）
        titleStyle.isScrollEnabel = false
        //是否显示遮盖
        titleStyle.isShowCoverView = true
        //切换标题的时候，是否有动画
        titleStyle.isAnimate = true
        //是否显示下划线
        titleStyle.isShowBottomLine = false
        //是否需要缩放字体
        titleStyle.isNeedScale = false
        //*************设置可根据你项目的实际情况进行修改******************
        
        let titles = [LanguageHelper.getString(key: "deivce_Mobile_phone_frame"),LanguageHelper.getString(key: "deivce_Tool_processing_line"),LanguageHelper.getString(key: "deivce_Video_Surveillance")]
        let contentH = UIScreen.height - kStatusBarH  - kNavigationBarH - kTabBarH - SafeAreaBottomHeight - titleStyle.titleViewHeight
        let titleFrame = CGRect(x: 0,
                                y: 0,
                                width: UIScreen.width,
                                height: contentH)
        
        //创建控制器的数组，有几个title，就对应创建几个viewController
        var childVCs = [UIViewController]()
        
        let recommendVc  = MobilePhoneFrameController()
        recommendVc.view.frame = titleFrame
        childVCs.append(recommendVc)
        
        let toolingLineVc = ToolingLineController()
        toolingLineVc.view.frame = titleFrame
        childVCs.append(toolingLineVc)
        
        let  videoMonitorC = VideoMonitorController()
        videoMonitorC.view.frame = titleFrame
        childVCs.append(videoMonitorC)

        //初始化你的整个pageView（包括标题栏（titleView）和内容View（contentView））
        let pageView = YTPageView.init(frame: view.bounds,
                                       titles: titles,
                                       childVCs: childVCs,
                                       parentVC: self,
                                       titleStyle: titleStyle)
        //添加你的pageView到主视图上
        view.addSubview(pageView)
        
    }
    
}
//遵守pageTitleViewDelegate协议
extension DeviceListVC:YTPageTitleViewDelegate
{
    func titleView(_ titleView: YTPageTitleView, targetIndex: Int) {
        
    }
}

extension DeviceListVC:YTPageContenvViewDelegate
{
    func contentView(_ contentView: YTPageContenvView, didEndScroll inIndex: Int) {
        
    }
    
    func contentView(_ contentView: YTPageContenvView, sourceIndex: Int, targetIndex: Int, progress: CGFloat) {
        
    }
}

