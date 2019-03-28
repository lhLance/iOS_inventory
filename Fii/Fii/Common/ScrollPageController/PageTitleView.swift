//
//  PageTitleView.swift
//  DYZB
//
//  Created by yetao on 2019/3/6.
//  Copyright © 2019 yetao. All rights reserved.
//

import UIKit


//protocol pageTitlViewDelegate:AnyClass {
//    func
//}
protocol pageTitleViewDelegate:class {
    func pageTitleView(titleView:PageTitleView,selectedIndex index:Int);
}


private let kscroolLineH = CGFloat(2);

private let kNormalColor: (CGFloat,CGFloat,CGFloat) = (99,99,99)
private let kSelectColor:(CGFloat,CGFloat,CGFloat) = (200,33,33)

class PageTitleView: UIView {

    //mark 定义属性
    private var currentIndex:Int = 0;
    private var titles:[String];
    weak var delegate:pageTitleViewDelegate?;
    private lazy var titleLables:[UILabel] = [UILabel]();
    private lazy var scrollView:UIScrollView = {
        let scroolView = UIScrollView();
        scroolView.showsHorizontalScrollIndicator = false;
        scroolView.scrollsToTop = false;
        scroolView.bounces = false;
        return scroolView;
    }();
    
    private lazy var scrollLine:UIView = {
        let scrollLine = UIView();
        scrollLine.backgroundColor = UIColor.orange;
        return scrollLine;
    }();
    
    init(frame: CGRect,titles:[String]) {
        self.titles = titles;
        super.init(frame: frame);
        
        setupUI();
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageTitleView{
    private func setupUI()
    {
        addSubview(scrollView);
        scrollView.frame = bounds;
        setupTitleLabels();
        setupBottomLineAndScrollLine();
    }
    
    private func setupTitleLabels(){
        let labelW:CGFloat = frame.width/CGFloat(titles.count);
        let labelH:CGFloat = frame.height - CGFloat(kscroolLineH);
        let labelY:CGFloat = CGFloat(0);

        for (index ,title) in titles.enumerated() {
            let label = UILabel();
            label.text = title;
            label.tag = index;
            label.font = UIFont.systemFont(ofSize: 16);
            label.textColor = colorWithRGBA(red: kNormalColor.0,
                                            green: kNormalColor.1,
                                            blue: kNormalColor.2, alpha: 1.0);
            label.textAlignment = NSTextAlignment.center;
            let labelX:CGFloat = labelW * CGFloat(index);
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH);
            
            scrollView.addSubview(label);
            titleLables.append(label);
            
            //添加手势
            label.isUserInteractionEnabled = true;
            let tapGes = UITapGestureRecognizer(target: self,
                                                action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes);
        }
        
    }
    
    private func setupBottomLineAndScrollLine(){
        let bottomLine = UIView();
        bottomLine.backgroundColor = UIColor.lightGray;
        let lineH = CGFloat(0.5);
        bottomLine.frame = CGRect(x: 0,
                                  y: self.frame.height-lineH,
                                  width: frame.width,
                                  height: lineH);
        addSubview(bottomLine);
        
        guard let firstLab = titleLables.first else { return  };
        firstLab.textColor = colorWithRGBA(red: kSelectColor.0,
                                           green: kSelectColor.1,
                                           blue: kSelectColor.2, alpha: 1.0);
        
        
//        firstLab.textColor = UIColor.orange;
        scrollView.addSubview(scrollLine);
        //#mark 为何这里计算的不太对
        scrollLine.frame = CGRect(x: firstLab.frame.origin.x,
                                  y: self.frame.height - kscroolLineH * 3,
                                  width: firstLab.frame.width,
                                  height: kscroolLineH)
    }
    
    
}

//label点击
extension PageTitleView
{
    @objc private func titleLabelClick(tapGes:UITapGestureRecognizer)
    {
        //获取当前label的下标值
        guard let currentLab = tapGes.view as? UILabel else {
            return
        }
        let oldLabel = titleLables[currentIndex];
        currentIndex = currentLab.tag;
        //切换文字颜色
        currentLab.textColor = colorWithRGBA(red: kSelectColor.0,
                                             green: kSelectColor.1,
                                             blue: kSelectColor.2, alpha: 1.0)
        oldLabel.textColor = colorWithRGBA(red: kNormalColor.0,
                                           green: kNormalColor.1,
                                           blue: kNormalColor.2, alpha: 1.0);
        //改变滚动条位置
        let scroolLineX = CGFloat(currentLab.tag)*scrollLine.frame.width;
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scroolLineX;
        }
        //通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex);
        print("打印数据:\(String(describing: currentLab.text))");
    }
}

extension PageTitleView{
    func setTitleWithProgress(progress:CGFloat,sourceIndex:Int,targetIndex:Int)
    {
        //取出sourceLabel
        let sourceLabel = titleLables[sourceIndex];
        let targetLabel = titleLables[targetIndex];
        
//        处理滑块的逻辑
        
        let moveTotalX = targetLabel.frame.origin.x -  sourceLabel.frame.origin.x;
        let moveX = moveTotalX * progress;
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX;
        
//        颜色的转变
        let colorDelta = (kSelectColor.0 - kNormalColor.0,kSelectColor.1 - kNormalColor.1,kSelectColor.2 - kNormalColor.2);
        
        sourceLabel.textColor = colorWithRGBA(red: kSelectColor.0 - colorDelta.0*progress,
                                              green: kSelectColor.1 - colorDelta.1*progress,
                                              blue: kSelectColor.2 - colorDelta.2*progress, alpha: 1.0);
        targetLabel.textColor = colorWithRGBA(red: kNormalColor.0 + colorDelta.0*progress,
                                              green: kNormalColor.1 + colorDelta.1*progress,
                                              blue: kNormalColor.2 + colorDelta.2*progress, alpha: 1.0);
        
//        sourceLabel.textColor = UIColor.darkGray;
//        targetLabel.textColor = UIColor.orange;
        
        currentIndex = targetIndex;
        print("haha----")
        
    }
    
}
