//
//  VideoControlView.swift
//  Fii
//
//  Created by yetao on 2019/4/22.
//  Copyright © 2019 Ye Tao. All rights reserved.
//

import UIKit

//@objc protocol VideoControlView {
//    func setupUI()
//}


class VideoControlView: NavControlView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */


    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    

    
    
}

extension VideoControlView{

    override func setupUI() {
        super.setupUI()
        
        let buttonY:CGFloat = progressOrigit_h + btn_height * 3
        
        let lab = UILabel()
        lab.frame = CGRect(x:margin_x + 10.0, y: buttonY, width: 40, height: 33)
        lab.backgroundColor = UIColor.clear
        lab.text = "预设"
        lab.FontColor(UIFont.PFRegular(14), titleColor).TextAlignment(.center)
        lab.added(into: self)
        
        for i in 0..<3{
            let btn = UIButton()
            btn.setTitle("\(i+1)", for: UIControl.State.normal)
            btn.setTitleColor(titleColor, for: UIControl.State.normal)
            btn.layer.masksToBounds = true
            btn.layer.cornerRadius = 10.0
            btn.layer.borderWidth = 0.5
            btn.tag = 500+i
            btn.addTarget(self, action: #selector(nextStep), for: .touchUpInside);
            btn.layer.borderColor = colorWithRGBA(red: 196, green: 196, blue: 196, alpha: 1.0).cgColor
            btn.frame = CGRect(x: lab.frame.maxX  + CGFloat(i * 95), y: buttonY, width: 87, height: 33)
            btn.added(into: self)
        }
    }

    @objc func presendBtnPressend(_ sender:UIButton){
    
        print("\(#file) ----\(#function)")
    }
}
