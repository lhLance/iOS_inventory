//
//  OpenScreenView.swift
//  Fii
//
//  Created by Liu Tao on 2019/3/13.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import UIKit
import Then
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
    let titleArr = ["Foxconn Industry Internet",
                    "A Fully Automated Workshop",
                    "Industrial Big Data Platform",
                    "Artificial Intelligence"]
    let subTitleArr = ["全球领先的工业互联网智能制造和科技服务解决方案",
                       "以无人化、无纸化、影像全纪录来贯彻智能化的运作，实现自主的关灯作业工厂",
                       "上线、云端、联网、互通、反馈的智慧数据平台",
                       "视觉 + 语音 + 判断 + 预测 重新型塑未来制造产业"]
    
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
        scrollView.showsHorizontalScrollIndicator = false
        
        pageControl.added(into: self)
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.currentPageIndicatorTintColor = UIColor.gray
    }

    func reload(count: Int) {
        
        layoutIfNeeded()
        
        scrollView.frame = bounds
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: width * CGFloat(count), height: height)
        
        pageControl.centerX = width / 2
        pageControl.origin.y = height - 60 + pageControl.height
        pageControl.numberOfPages = count
        
        for i in 0..<count {
            _ = UIImageView().then { (imgV) in
                imgV.frame = CGRect(CGFloat(i) * width,
                                    0,
                                    width,
                                    height)
                imgV.added(into: scrollView)
                imgV.image = UIImage(imgArr[i])
                
                _ = UIImageView().then({ (subImgV) in
                    subImgV.frame = CGRect(0.2 * width,
                                           0.3 * width,
                                           0.6 * width,
                                           0.6 * width)
                    subImgV.added(into: imgV)
                    subImgV.image = UIImage(circleImgArr[i])
                })
                
                let titleLbl = UILabel().then({ (title) in
                    title.Text(titleArr[i]).TextAlignment(.center).TextColor(UIColor.white).Font(.Kmedium(26))
                    title.added(into: imgV)
                    title.snp.makeConstraints({ (make) in
                        make.width.equalToSuperview()
                        make.height.equalTo(40)
                        make.top.equalTo(width)
                        make.centerX.equalToSuperview()
                    })
                })
                
                _ = UILabel().then({ (subT) in
                    subT.numberOfLines = 0
                    subT.lineBreakMode = .byWordWrapping
                    subT.Text(subTitleArr[i]).TextAlignment(.center).TextColor(UIColor.white).Font(.Kmedium(15))
                    subT.added(into: imgV)
                    subT.snp.makeConstraints({ (make) in
                        make.width.equalTo(width * 0.8)
                        make.height.equalTo(80)
                        make.top.equalTo(titleLbl.snp.bottom).offset(5)
                        make.centerX.equalToSuperview()
                    })
                })
                
                let skipBtn = UIButton().then { (btn) in
                    btn.backgroundColor = UIColor.lightGray
                    btn.cornerRadius = 20
                    btn.Text("跳过").TitleColor(UIColor.white).Font(.Kmedium(16))
                    btn.added(into: imgV)
                    btn.snp.makeConstraints({ (make) in
                        make.width.equalTo(160)
                        make.height.equalTo(40)
                        make.top.equalTo(pageControl.snp.bottom).offset(15)
                        make.centerX.equalToSuperview()
                    })
                    btn.addTarget(self, action: #selector(skipBtnTapped), for: .touchUpInside)
                }
                
                if i == count - 1 {
                    skipBtn.isHidden = false
                } else {
                    skipBtn.isHidden = true
                }
            }
        }
    }
    
    @objc func skipBtnTapped() {
        print("skipBtnTapped")
    }
}

extension OpenScreenView: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let page = Int(scrollView.contentOffset.x / scrollView.width)
        
        pageControl.currentPage = page
    }
}
