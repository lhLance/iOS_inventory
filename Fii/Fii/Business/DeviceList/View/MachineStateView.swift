//
//  MachineStateView.swift
//  Fii
//
//  Created by yetao on 2019/4/23.
//  Copyright © 2019 Ye Tao. All rights reserved.
//

import UIKit

class MachineStateView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    private var stateAry:NSMutableArray? = nil
    
    init(frame: CGRect,statesAry:NSMutableArray) {
        super.init(frame: frame)
        stateAry = statesAry
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUPUI(statesAry: stateAry!)
    }
    
    
}


extension MachineStateView{
    
        func setUPUI(statesAry:NSMutableArray){
            
            if statesAry.count < 1 {
                return
            }
            let marginV:CGFloat = 0
            let labWidth:CGFloat = (self.width - (marginV * CGFloat(statesAry.count + 1))) / CGFloat(statesAry.count)
            let labHight:CGFloat = 30
            
            let titleBackV:UIView = UIView()
            titleBackV.frame = CGRect(x: 0, y: 0, width: self.width, height: 30)
            titleBackV.ac_shadeView(withColorList:  [colorWithRGBA(red: 51, green: 87, blue: 171, alpha: 1.0),
                                                     colorWithRGBA(red: 212, green: 22, blue: 62, alpha: 1.0)],
                                    direction: UIView.ACShadeDirection.leftToRight)
            titleBackV.added(into: self)
            
            for (index,tuple) in statesAry.enumerated()
            {
                let value:(String,String) = tuple as! (String,String)
                
                let titleLab = UILabel();
                titleLab.frame = CGRect(x: marginV + (labWidth + marginV) * CGFloat(index) , y: 0, width: labWidth, height: labHight)
                titleLab.backgroundColor = UIColor.clear
                titleLab.textAlignment = NSTextAlignment.center
                titleLab.text = value.0
                titleLab.FontColor(.PFRegular(14), UIColor.white).TextAlignment(.center)
                titleLab.added(into: titleBackV)
                
                let stateLab = UILabel()
                stateLab.frame = CGRect(x: marginV + (labWidth + marginV) * CGFloat(index) , y: titleLab.frame.maxY , width: labWidth, height: self.height - labHight)
                stateLab.backgroundColor = UIColor.clear
                stateLab.text = value.1
                stateLab.FontColor(.PFRegular(13), colorWithRGBA(red: 155, green: 189, blue: 146, alpha: 1.0)).TextAlignment(.center)
                if index == 0 || index == 2{
                    stateLab.textColor = colorWithRGBA(red: 28, green: 150, blue: 214, alpha: 1.0)
                }
                else{
                    stateLab.textColor = colorWithRGBA(red: 218, green: 115, blue: 115, alpha: 1.0)
                }
                stateLab.added(into: self)
                
            }
        }
        
    
    
}
