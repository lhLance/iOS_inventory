//
//  NavControlView.swift
//  Fii
//
//  Created by yetao on 2019/4/22.
//  Copyright © 2019 Ye Tao. All rights reserved.
//


private let margin_x:CGFloat = 10.0

import UIKit

class NavControlView: UIView {

    var  dataArray:[String]! = ["1","2","3","4","5"]
    var myframe:CGRect = CGRect.zero
    public let btn_height:CGFloat = 66
    public let progressOrigit_h:CGFloat = 33
    let margin_x:CGFloat = 5
    let buttonW:CGFloat = 33
    public let titleColor = colorWithRGBA(red: 55,
                                          green: 86,
                                          blue: 169,
                                          alpha: 1.0)

    
    init(frame: CGRect ,dataAry:[String]) {
        
        super.init(frame: frame)
        self.dataArray = dataAry
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
            setupUI()
    }
    
}


extension NavControlView{
    
   @objc public func setupUI()
    {
        progressView()
        var titleArray  = [" "]
        for i in 0..<1 {
            let buttonView = MonitorShapeButton(frame: CGRect(x: 0,
                                                              y: 50,
                                                              width: 50,
                                                              height: 50),
                                                buttonType: ButtonType(rawValue: UInt32(i)))
            buttonView.addTarget(self, action: #selector(self.buttonClick(_:)), forResponseState: ButtonClickTypeTouchUpInside)
            buttonView.addTarget(self, action: #selector(self.longPressButtonClick(_:)), forResponseState: ButtonClickTypeLongPress)
            self.addSubview(buttonView)
            
            var center = CGPoint.zero
            var image: UIImage?
            switch i {
            case 0:
                //  圆形五个按钮 上下左右 中心
                center = CGPoint(x: self.frame.midX, y: self.height - buttonView.frame.height / 2 - 16)
            default: break
                
            }
            if image != nil {
                
                buttonView.image = image
            }
            buttonView.setTitle(titleArray[i])
            buttonView.center = center
            buttonView.tag = i
        }
        
    }
    
    
    @objc func buttonClick(_ button: MonitorShapeButton?) {
        
        print("单击事件,按钮 tag 值 ‘%zd’  点击位置 ‘%@’", tag, getSelectPartString(withButtonView: button)!)
    }
    
    @objc func longPressButtonClick(_ button: MonitorShapeButton?) {
        print("\(#file) ----\(#function) 单击事件,按钮 tag 值 ‘%zd’  点击位置 ‘%@’", tag, getSelectPartString(withButtonView: button)!)
    }
    
    func getSelectPartString(withButtonView button: MonitorShapeButton?) -> String? {
        var partString: String = ""
        switch button?.selectButtonPosition {
        case SelectButtonPositionTop?:
            partString = "上"
        case SelectButtonPositionButtom?:
            partString = "下"
        case SelectButtonPositionCenter?:
            partString = "中"
        case SelectButtonPositionLeft?:
            partString = "左"
        case SelectButtonPositionRight?:
            partString = "右"
        default:
            break
        }
        return partString
    }
}

extension NavControlView:YTSegmentControlDelegate{
    
    func progressView(){
        
        
        var titleAry:[String] = ["光圈","倍速","焦点"]

        
        for i in 0..<titleAry.count
        {
            let progressOrigitH = progressOrigit_h + btn_height * CGFloat(i)
            let label = UILabel()
            label.frame = CGRect(x:margin_x + 10.0,
                                 y: progressOrigitH,
                                 width: 40,
                                 height: 33)
            label.text = titleAry[i]
            label.FontColor(UIFont.PFRegular(14), titleColor).TextAlignment(.center)
            label.added(into: self)
            
            
            if i == 0
            {
                let itles  = [" ", " "]
                let selegmentV = YTSegmentControl(frame: CGRect(x: label.frame.maxX + margin_x, y: progressOrigitH, width: self.frame.size.width - label.frame.maxX - 20 - margin_x*2, height: 33), titles: itles)
                selegmentV.delegate = self as YTSegmentControlDelegate
                selegmentV.added(into: self)
            }
            else
            {
                let progressV = YTProgressLineView.init(frame: CGRect.init(x: label.frame.maxX + margin_x, y: progressOrigitH, width: self.frame.size.width - label.frame.maxX*2 - buttonW*2, height: 33), dataArr: dataArray)
                progressV.tag = 100+i
                self.addSubview(progressV)
                
                let preStepBtn = UIButton()
                preStepBtn.tag = 200+i
                preStepBtn.setBackgroundImage(UIImage(named: "virtual_btn_jian"), for: UIControl.State.normal)
                preStepBtn.frame = CGRect(x: progressV.frame.maxX + 15, y: progressOrigitH, width: buttonW, height: 33)
                preStepBtn.addTarget(self, action: #selector(preStep), for: .touchUpInside);
                self.addSubview(preStepBtn)
                
                let nextStepBtn = UIButton()
                nextStepBtn.tag = 300+i
                nextStepBtn.setBackgroundImage(UIImage(named: "virtual_btn_yinliangjia"), for: UIControl.State.normal)
                nextStepBtn.frame = CGRect(x: preStepBtn.frame.maxX + 10, y: progressOrigitH, width: buttonW, height: 33)
                nextStepBtn.addTarget(self, action: #selector(nextStep), for: .touchUpInside);
                self.addSubview(nextStepBtn)
            }
        }
        
        
    }

    //1、没有标签的进度条 上一步
    @objc func preStep(_ sender: UIButton) {
        
        let tag = sender.tag - 100;
        let progressV:YTProgressLineView = self.TagView(tag)  as! YTProgressLineView
        guard progressV.index! >  0  else {
            return
        }
        progressV.index = progressV.index - 1
    }
    
    //1、没有标签的进度条 下一步
    @objc func nextStep(_ sender: UIButton)
    {
        let tag = sender.tag - 200;
        let progressV:YTProgressLineView = self.TagView(tag)  as! YTProgressLineView
        guard  progressV.index! < self.dataArray.count else {
            return
        }
        progressV.index = progressV.index + 1
    }

    func ytsegmentedControl(_ control: YTSegmentControl?, didSeletRow row: Int) {
        print("点击是:\(row)")
    }
    
}
