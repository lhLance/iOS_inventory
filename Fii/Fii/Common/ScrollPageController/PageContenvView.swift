//
//  PageContenvView.swift
//  DYZB
//
//  Created by yetao on 2019/3/6.
//  Copyright © 2019 yetao. All rights reserved.
//

import UIKit

protocol  PageContentViewDelegate:class {
    func pageContentView(contentView:PageContenvView,progress:CGFloat,sourceIndex:Int,targetIndex:Int)
}


private let ContentCellID = "ContentCellID"

private let kTitleViewH:CGFloat = 40;

class PageContenvView: UIView {
    
    private var startOffsetX:CGFloat = 0;
    private var childVcs:[UIViewController];
    private weak var parentViewController:UIViewController?;
    weak var delegate:PageContentViewDelegate?
    private var isForbidScrolldelegate:Bool = false;
    
    private lazy var collectionView:UICollectionView = { [weak self] in /*弱引用*/
        let layout = UICollectionViewFlowLayout();
        layout.itemSize = (self?.bounds.size)!;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = .horizontal;
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout);
        collectionView.showsHorizontalScrollIndicator = false;//水平指示不显示
        collectionView.isPagingEnabled = true;//分页显示
        collectionView.bounces = false;//不超出内容的滚动
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        return collectionView;
        
    }();
    
    
    init(frame: CGRect,childVcs:[UIViewController],parentViewController:UIViewController?) {
        self.parentViewController = parentViewController;
        self.childVcs = childVcs;
        super.init(frame: frame);
        setupUI();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//amrk 设置界面

extension PageContenvView
{
    private func setupUI(){
        for childVc in childVcs{
            parentViewController?.addChild(childVc);
        }
        addSubview(collectionView);
        collectionView.frame = bounds;
    }
}


extension PageContenvView:UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count;
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath);
        
        for view in cell.contentView.subviews
        {
            view.removeFromSuperview();
        }
        let childVc = childVcs[indexPath.item];
        childVc.view.frame = cell.contentView.bounds;
        cell.contentView.addSubview(childVc.view);
        
        return cell;
    }
    
    
    
}

extension PageContenvView:UICollectionViewDelegate
{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //定义获取需要的数据
        
        if  isForbidScrolldelegate{return};
        
        var progress:CGFloat = 0;
        var sourceIndex:Int = 0;
        var targetIndex:Int = 0;
        //判断左滑还是右划
        let currentOffsetX = scrollView.contentOffset.x;
        let scrollViewW = scrollView.bounds.width;
        if currentOffsetX > startOffsetX {
            //左滑
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX/scrollViewW)
            sourceIndex = Int(currentOffsetX/scrollViewW);
            targetIndex = sourceIndex + 1;
            if targetIndex >= childVcs.count{
                targetIndex = childVcs.count - 1;
            }
            if currentOffsetX - startOffsetX == scrollViewW
            {
                progress = 1;
                targetIndex = sourceIndex;
            }
            print("向左滑动")

        }else{
            //右划
            progress = 1 - (currentOffsetX/scrollViewW - floor(currentOffsetX/scrollViewW));
            targetIndex = Int(currentOffsetX/scrollViewW);
            
            sourceIndex = targetIndex + 1;
            if sourceIndex >= childVcs.count{
                sourceIndex = childVcs.count - 1;
            }
            print("向右滑动")
        }
        
        print("progress:\(progress)  sourceIndex = \(sourceIndex)  targetIndex = \(targetIndex)" );
        
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex);
        
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrolldelegate = false;
        startOffsetX = scrollView.contentOffset.x;
    }
}

extension PageContenvView{
    
    func setCurrentIndex(currentIndex:Int){
        isForbidScrolldelegate = true;
        let offsetX = CGFloat(currentIndex)*collectionView.frame.width;
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false);
    };
    
}
