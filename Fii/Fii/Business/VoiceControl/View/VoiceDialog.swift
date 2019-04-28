//
//  VoiceDialog.swift
//  Fii
//
//  Created by yetao on 2019/4/27.
//  Copyright © 2019 Ye Tao. All rights reserved.
//

import UIKit

class VoiceDialog: UIView {

    lazy var textLabel: UILabel! = {
        let textLab = UILabel()
        
        return textLab
    }()
    lazy var view: UIView! = {
        let view = UIView()
        view.frame = bounds
        view.layer.cornerRadius = 10
        return view
    }()
    lazy var voiceImg: UIImageView! = {
        let voiceImg = UIImageView()
        
        return voiceImg
    }()
    lazy var macImg: UIImageView! = {
        let macImg = UIImageView()
        
        return macImg
    }()
    static var height : CGFloat{
        switch UIScreen.main.bounds.width {
        case 320:
            return 115
        default:
            return 130
        }
    }
    
    static let voiceDialog = VoiceDialog.init(frame: CGRect.init(x: UIScreen.main.bounds.width / 2 - height / 2, y: UIScreen.main.bounds.height / 2 - height / 2, width: height, height: height))
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    func setUpUI(){
        view.added(into: self)
        view.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
        }
        
        macImg.added(into: view)
        macImg.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(27)
            make.top.equalToSuperview().offset(21)
            make.width.equalTo(40)
            make.height.equalTo(65)
        }
        voiceImg.added(into: view)
        voiceImg.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-27)
            make.bottom.equalTo(macImg.snp.bottom)
            make.width.equalTo(18)
            make.height.equalTo(55)
        }
        
        textLabel.added(into: view)
        textLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(macImg.snp.bottom).offset(10)
        }
 
        let name: String? = "ic_record"
        let filePath: String? = Bundle.main.path(forResource: name, ofType: "png")
        let image: UIImage? = UIImage(contentsOfFile: filePath!)
        macImg.image = image
        
        //定义帧动画
        var imgArray:[UIImage]! = []
        for i in 1 ... 8
        {
            // 拼接名称
            let name: String? = "ic_record_ripple" + "-\(i)"
            let filePath: String? = Bundle.main.path(forResource: name, ofType: "png")
            // 根据路径获得图片
            let image: UIImage? = UIImage(contentsOfFile: filePath!)
            // 往数组中添加图片
            imgArray.append(image!)
        }
        // 给动画数组赋值
        voiceImg.animationImages = imgArray
        voiceImg.animationRepeatCount = 0
        voiceImg.animationDuration = 1.5
        
    }
    
    
    //调用显示
    static func show(vc:UIViewController){
        vc.view.addSubview(voiceDialog)
        voiceDialog.voiceImg.startAnimating()
    }
    
    //调用消失
    static  func dissmiss(){
        voiceDialog.removeFromSuperview()
        voiceDialog.voiceImg.stopAnimating()
    }


}
