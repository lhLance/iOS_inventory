//
//  DeviceListVC.swift
//  Fii
//
//  Created by Liu Tao on 2019/3/11.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import UIKit
private let kTitleViewH:CGFloat = 40.0;

class DeviceListVC: UIViewController {
    
    //    let  cloumnCategoryMenuTableVc = CloumnCategoryMenuTableController();
    //    var cloumnCategoryDetailCellVc:CloumnCategoryDetailController?;
    
    //MARK 懒加载
    private lazy var pageTitleView:PageTitleView = { [weak self]in
        let titleFrame = CGRect(x: CGFloat(0), y: kNavigationBar + kStatusBarH, width: UIScreen.width, height: CGFloat(kTitleViewH));
        let titles = ["手机中框","刀具加工线","视频监控"];
        let titleView = PageTitleView(frame: titleFrame, titles: titles);
        titleView.delegate = self;
        return titleView;
        }();
    
    
    private lazy var pageContentView:PageContenvView = { [weak self] in
        let contentH = UIScreen.height - kStatusBarH - kNavigationBar - kTitleViewH - kTabBarH - SafeAreaBottomHeight;
        let titleFrame = CGRect(x: CGFloat(0), y: kStatusBarH + kNavigationBar+kTitleViewH, width:UIScreen.width , height: contentH);
        var childVcs = [UIViewController]();
        
        let recommendVc  = MobilePhoneFrameController();
        childVcs.append(recommendVc);
        
        
        let toolingLineVc = ToolingLineController();
        childVcs.append(toolingLineVc);
        
        for _ in 0..<1{
            let vc = UIViewController();
            vc.view.backgroundColor = UIColor.random;
            childVcs.append(vc);
        }
        
        let contentView = PageContenvView(frame: titleFrame, childVcs:childVcs
            , parentViewController: self)
        contentView.delegate = self;
        return contentView;
        }();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI();
        // Do any additional setup after loading the view.
    }
    
}


extension DeviceListVC
{
    // mark
    private func setupUI()
    {
        //不需要调整uiscrollview的内边距
        //        automaticallyAdjustsScrollViewInsets = false;
        //        setupNavigationBar();
        self.view.addSubview(pageTitleView);
        self.view.addSubview(pageContentView);
        pageContentView.backgroundColor = UIColor.orange;
        
    }
    
    //    private func setupNavigationBar()
    //    {
    //        let btn = UIButton();
    //        btn .setImage(UIImage(named: "cm_logo_capture"), for: UIControl.State.normal);
    //        btn.sizeToFit();
    //        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn);
    //        let size = CGSize(width: 40, height: 40);
    //        let historyItem = UIBarButtonItem(imageName: "cm_nav_history_white_HL", highImageName: "cm_nav_history_white_HL", size: size) ;
    //        let searchBtnItem = UIBarButtonItem(imageName: "cm_nav_search_inner", highImageName: "cm_nav_search_inner", size: size);
    //        let scanItem = UIBarButtonItem(imageName: "cm_nav_richscan", highImageName: "cm_nav_richscan", size: size);
    //        navigationItem.rightBarButtonItems = [historyItem,searchBtnItem,scanItem]
    //    }
}
//遵守pageTitleViewDelegate协议
extension DeviceListVC:pageTitleViewDelegate
{
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        print(index);
        pageContentView.setCurrentIndex(currentIndex: index);
    }
    
}

extension DeviceListVC:PageContentViewDelegate
{
    func pageContentView(contentView: PageContenvView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex);
    }
    
    
    
}

