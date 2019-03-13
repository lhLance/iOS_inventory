//
//  OpenScreenView.swift
//  Fii
//
//  Created by Liu Tao on 2019/3/13.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import UIKit
import SnapKit

class OpenScreenView: UIView {

    var count: Int? {
        didSet {
            reload(count: count ?? 0)
        }
    }
    
    private var scrollView = UIScrollView()
    private var pageControl = UIPageControl()
    
    let imgArr = ["bg1", "bg2", "bg3", "bg4"]
    let circleImgArr = ["bg11", "bg22", "bg33", "bg44"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    func setupView() {
        
        scrollView.added(into: self)
        scrollView.delegate = self
        scrollView.alwaysBounceHorizontal = true
        scrollView.isPagingEnabled = true
        scrollView.backgroundColor = UIColor.cyan
        
        pageControl.added(into: self)
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.currentPageIndicatorTintColor = UIColor.gray
    }

    func reload(count: Int) {
        
        layoutIfNeeded()
        
        scrollView.frame = self.bounds
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: width * CGFloat(count), height: height)
        
        pageControl.center.x = self.width / 2
        pageControl.frame.origin.y = self.height - 10 + pageControl.height
        pageControl.numberOfPages = count
        
        for i in 0..<count {
            let imgView = UIImageView.init(frame: CGRect.init(CGFloat(i) * width , 0, width, height))
            imgView.added(into: scrollView)
            imgView.image = UIImage.init(imgArr[i])
        }
    }
}

extension OpenScreenView: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let page = Int(scrollView.contentOffset.x / scrollView.width)
        
        pageControl.currentPage = page
    }
}
