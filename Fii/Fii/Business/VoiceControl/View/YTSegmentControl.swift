//
//  YTSegmentControl.swift
//  MyFirstSwift
//
//  Created by yetao on 2019/4/18.
//  Copyright © 2019 yetao. All rights reserved.
//

import UIKit

private let margin:CGFloat = 2.0

protocol YTSegmentControlDelegate: class
{
    func ytsegmentedControl(_ control: YTSegmentControl?, didSeletRow row: Int)
}


class YTSegmentControl: UIView {

    /**
     选中label的颜色（默认灰色）
     */
    var normalLabelColor: UIColor? = colorWithRGBA(red: 235, green: 235, blue: 235, alpha: 1.0)
    /**
     未选中label的背景颜色（默认白色）
     */
    var selectedViewColor: UIColor? = colorWithRGBA(red: 255, green: 255, blue: 255, alpha: 1.0)
    /**
     数据源
     */
    var titles: [String] = []
    weak var delegate: YTSegmentControlDelegate?
    var frontLabelbgView: UIView?
    private lazy var bgView: UIView? = {
        let bgView = UIView()
        return bgView
    }()
    
     init(frame: CGRect ,titles: [String]?) {
        super.init(frame: frame)
        self.titles = titles!
        isUserInteractionEnabled = true
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI() {
        
        let width: CGFloat = frame.size.width / CGFloat(titles.count)
        let height:CGFloat = frame.size.height
        self.backgroundColor = normalLabelColor
        layer.borderWidth = 1
        let tempColor:UIColor = (selectedViewColor != nil) ? selectedViewColor! : UIColor.gray
        layer.borderColor = tempColor.cgColor
        layer.cornerRadius = 8.0
        bgView!.clipsToBounds = true
        
        for i in 0..<titles.count {
            let titleLb = UILabel()
            titleLb.isUserInteractionEnabled = true
            titleLb.tag = 1000 + i
            titleLb.text = titles[i]
            titleLb.backgroundColor = UIColor.clear
            titleLb.textColor = (normalLabelColor != nil) ? normalLabelColor : UIColor.black
            titleLb.font = UIFont.systemFont(ofSize: 14)
            titleLb.frame = CGRect(x: CGFloat(width * CGFloat(i)), y: 0, width: width, height: height)
            titleLb.textAlignment = .center
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.selectedLabel(_:)))
            titleLb.addGestureRecognizer(tap)
            addSubview(titleLb)
        }
        bgView!.frame = CGRect(x: margin, y: margin , width: width - margin * 2 , height: height - margin * 2)
        bgView!.backgroundColor = (selectedViewColor != nil) ? selectedViewColor : UIColor.gray
        bgView!.layer.cornerRadius = 8.0
        bgView!.clipsToBounds = true
        addSubview(bgView!)
        
        
        let topLabelView = UIView(frame: bounds)
        topLabelView.backgroundColor = UIColor.clear
        bgView!.addSubview(topLabelView)
        frontLabelbgView = topLabelView
        
        for i in 0..<titles.count {
            let titleLb = UILabel()
            titleLb.isUserInteractionEnabled = true
            titleLb.text = titles[i]
            titleLb.backgroundColor = UIColor.clear
            titleLb.textColor = UIColor.white
            titleLb.font = UIFont.systemFont(ofSize: 14)
            titleLb.frame = CGRect(x: CGFloat(width * CGFloat(i)), y: 0, width: width , height: height )
            titleLb.textAlignment = .center
            topLabelView.addSubview(titleLb)
        }
    }
    
    
    @objc func selectedLabel(_ sender: UITapGestureRecognizer?) {
        let width: CGFloat = frame.size.width / CGFloat(titles.count)
        UIView.animate(withDuration: 0.3, animations: {
            self.bgView?.frame.origin.x = CGFloat(((sender?.view?.tag ?? 0) - 1000)) * width + margin
            self.frontLabelbgView!.frame.origin.x = CGFloat(-((sender?.view?.tag ?? 0) - 1000)) * width + margin 
            self.bgView!.layoutIfNeeded()
        })
        if responds(to: #selector(self.selectedLabel(_:))) {
            
            delegate?.ytsegmentedControl(self, didSeletRow: (sender?.view?.tag ?? 0) - 1000)
        }
    }
    
    func setTitles(_ titles: [String]?) {
        if titles != nil {
            self.titles = titles!
            removeFromSuperview()
            setUpUI()
        }
    }


}
