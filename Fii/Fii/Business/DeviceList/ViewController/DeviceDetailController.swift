//
//  DeviceDetailController.swift
//  Fii
//
//  Created by yetao on 2019/3/27.
//  Copyright © 2019 Liu Tao. All rights reserved.
//

private let kImageW:CGFloat = CGFloat(200.0)
private let kImageH:CGFloat = CGFloat(300.0)
private let kSquareMargin:CGFloat = CGFloat(10)
private let kSquareSize:CGFloat = CGFloat(50.0)



import UIKit

class DeviceDetailController: UIViewController {

    
    var rewindTimer: Timer?
    var forwardTimer: Timer?
    var gifName: String?
    
    var centerPoint:CGPoint = CGPoint(x: UIScreen.width/2.0, y: UIScreen.height/2.0)
    
    var topLeftCenter:CGPoint=CGPoint.zero
    var bottomLeftCenter:CGPoint=CGPoint.zero
    var topRightCenter:CGPoint=CGPoint.zero
    var bottomRightCenter:CGPoint=CGPoint.zero

    lazy var controlV: UIImageView = {
        let controlV = UIImageView()
        controlV.ImageName("machine_bg")
        controlV.backgroundColor = UIColor.white
        controlV.layer.masksToBounds = true
        controlV.layer.cornerRadius = 10.0
        controlV.layer.borderWidth = 0.5
        controlV.layer.borderColor = colorWithRGBA(red: 196, green: 196, blue: 196, alpha: 1.0).cgColor
        return controlV
    }()
    
    lazy var bottomImageV: UIImageView = {
        let bottomImageV = UIImageView()
        bottomImageV.ImageName("machine_bg_bottom")
        return bottomImageV
    }()
    
    lazy var machineV: MachineStateView = {
        let stateAry:NSMutableArray = [("任务状态","已完成"),("运行状态","MtRunning"),("连接状态","已连接"),("异常状态","无")]
        let machineV:MachineStateView = MachineStateView(frame: CGRect.zero, statesAry: stateAry)
        machineV.backgroundColor = UIColor.white
        machineV.layer.masksToBounds = true
        machineV.layer.cornerRadius = 10.0
        machineV.layer.borderWidth = 0.5
        machineV.layer.borderColor = colorWithRGBA(red: 196, green: 196, blue: 196, alpha: 1.0).cgColor
        return machineV
    }()
    
    private lazy var imageView:UIImageView = { [weak self] in /*弱引用*/
        let imageView =  UIImageView()
        
        return imageView
        }()
    

    
    private lazy var leftTopimageView:UIImageView = { [weak self] in /*弱引用*/
        let leftTopImageV = UIImageView(frame: CGRect(x: 0,
                                                      y: 0,
                                                      width: kSquareSize,
                                                      height: kSquareSize),
                                        imageName: "jiao_big",
                                        direct: SquareBorder.topLeft)
        leftTopImageV.center = (self?.topLeftCenter)!
        return leftTopImageV
        }()
    
    private lazy var leftBottomimageView:UIImageView = { [weak self] in /*弱引用*/
        let leftBottomImageV = UIImageView(frame: CGRect(x: 0,
                                                         y: 0,
                                                         width: kSquareSize,
                                                         height: kSquareSize),
                                           imageName: "jiao_big",
                                           direct: SquareBorder.bottomLeft)
        leftBottomImageV.center = (self?.bottomLeftCenter)!
        return leftBottomImageV
        }()
    
    
    
    private lazy var rightTopimageView:UIImageView = { [weak self] in /*弱引用*/
        let rightTopimageV = UIImageView(frame: CGRect(x: 0,
                                                       y: 0,
                                                       width: kSquareSize,
                                                       height: kSquareSize),
                                         imageName: "jiao_big",
                                         direct: SquareBorder.topRight)
        rightTopimageV.center = (self?.topRightCenter)!
        return rightTopimageV
        }()
    
    private lazy var rightBottomimageView:UIImageView = { [weak self] in /*弱引用*/
        let rightBottomimageV = UIImageView(frame: CGRect(x: 0,
                                                          y: 0,
                                                          width: kSquareSize,
                                                          height: kSquareSize),
                                            imageName: "jiao_big",
                                            direct: SquareBorder.bottomRight)
        rightBottomimageV.center = (self?.bottomRightCenter)!
        return rightBottomimageV
        }()
    
    
    let gifMangager = SwiftyGifManager(memoryLimit: 60)
    
    override func viewDidLoad() {
        super.viewDidLoad()


        
        setInitData()
        setUpUI()
        // Do any additional setup after loading the view.
    }
    


}

extension DeviceDetailController{
    
    private func setInitData(){
        self.view.backgroundColor = colorWithRGBA(red: 237, green: 237, blue: 242, alpha: 1.0)
        self.topLeftCenter = CGPoint(x: self.centerPoint.x - kImageW/2.0 - kSquareMargin + kSquareSize/2.0,
                                     y: self.centerPoint.y - kImageH/2.0 - kSquareMargin + kSquareSize/2.0)
        self.bottomLeftCenter = CGPoint(x: self.centerPoint.x - kImageW/2.0 - kSquareMargin + kSquareSize/2.0,
                                        y: self.centerPoint.y + kImageH/2.0 + kSquareMargin - kSquareSize/2.0)
        self.topRightCenter = CGPoint(x: self.centerPoint.x + kImageW/2.0 + kSquareMargin - kSquareSize/2.0,
                                      y: self.centerPoint.y - kImageH/2.0 - kSquareMargin + kSquareSize/2.0)
        self.bottomRightCenter = CGPoint(x: self.centerPoint.x + kImageW/2.0 + kSquareMargin - kSquareSize/2.0,
                                         y: self.centerPoint.y + kImageH/2.0 + kSquareMargin - kSquareSize/2.0)
    }
    
    private func setUpUI(){
        
        controlV.added(into: view)
        controlV.snp.makeConstraints { (make) in
            make.top.equalTo(kStatusBarH + kNavigationBarH + 11)
            make.right.equalTo(-10)
            make.left.equalTo(10)
            make.height.equalTo(428)
        }
        
        imageView.added(into: controlV)
        
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(246)
            make.height.equalTo(276)
        }
        
        bottomImageV.added(into: view)
        bottomImageV.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(controlV.snp.bottom).offset(-10)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        
        
//        leftTopimageView.added(into: view)
//        leftBottomimageView.added(into: view)
//        rightTopimageView.added(into: view)
//        rightBottomimageView.added(into: view)
        

        machineV.added(into: self.view)
        machineV.snp.makeConstraints { (make) in
            make.top.equalTo(controlV.snp.bottom).offset(11)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(92)
        }
        
        
        
        
        
        if let imgName = gifName{
            let gifImage = UIImage(gifName: imgName)
            imageView.setGifImage(gifImage, manager: gifMangager)
        }
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGesture(sender:)))
        imageView.addGestureRecognizer(panGesture)
        imageView.isUserInteractionEnabled = true
        imageView.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(togglePlay))
        imageView.addGestureRecognizer(tapGesture)
        
    }
//    /*绘制网格*/
//    private func addGrid(_ view: UIView?) {
//        let widthView: CGFloat? = view?.frame.size.width
//        let heightView: CGFloat? = view?.frame.size.height
//        let size: CGFloat = 8
//
//        let addLineWidthRect: ((_ rect: CGRect) -> Void)? = { rect in
//            let layer = CALayer()
//            view?.layer.addSublayer(layer)
//            layer.frame = rect
//            layer.backgroundColor = colorWithRGBA(red: 20, green: 43, blue: 54, alpha: 1.0).cgColor
//        }
//
//        var i = 0
//        while i < Int((widthView ?? 0.0))
//        {
//            addLineWidthRect?(CGRect(x: i, y: 0, width: 1, height: Int(heightView ?? 0.0)))
//            i = i + Int(size)
//        }
//        var j = 0
//        while j < Int((heightView ?? 0.0)) {
//            addLineWidthRect?(CGRect(x: 0, y: j, width: Int(widthView ?? 0.0), height: 1))
//            j = j + Int(size)
//        }
//    }
//

    
    @objc func panGesture(sender:UIPanGestureRecognizer){
        
        switch sender.state {
        case .began:
            stop()
            break
            
        case .changed:
            if sender.velocity(in: sender.view).x > 0 {
                forward()
            } else{
                rewind()
            }
            break
            
        default:
            break
        }
    }
    @objc func rewind(){
        self.imageView.showFrameForIndexDelta(-1)
    }
    
    @objc func forward(){
        self.imageView.showFrameForIndexDelta(1)
    }
    
    func stop(){
        self.imageView.stopAnimatingGif()
    }
    
    func play(){
        self.imageView.startAnimatingGif()
    }
    
    @objc func togglePlay(){
        if self.imageView.isAnimatingGif() {
            stop()
        }else {
            play()
        }
    }
    
   func rewindDown(){
        stop()
        rewindTimer = Timer.scheduledTimer(timeInterval: 1.0/30.0,
                                           target: self,
                                           selector: #selector(self.rewind),
                                           userInfo: nil,
                                           repeats: true)
    }
    
    func rewindUp(){
        rewindTimer?.invalidate()
        rewindTimer = nil
    }
    
    func forwardDown(){
        stop()
        forwardTimer = Timer.scheduledTimer(timeInterval: 1.0/30.0,
                                            target: self,
                                            selector: #selector(self.forward),
                                            userInfo: nil,
                                            repeats: true)
    }

    
}
extension DeviceDetailController : SwiftyGifDelegate {
    
    func gifDidStart(sender: UIImageView) {
        print("gifDidStart")
    }
    
    func gifDidLoop(sender: UIImageView) {
        print("gifDidLoop")
    }
    
    func gifDidStop(sender: UIImageView) {
        print("gifDidStop")
    }
}
