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

    
    
    private lazy var imageView:UIImageView = { [weak self] in /*弱引用*/
        let imageView =  UIImageView(frame: CGRect(x: 0,
                                                   y: 0,
                                                   width: kImageW,
                                                   height: kImageH))
        imageView.center = centerPoint
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
        self.view.backgroundColor = colorWithRGBA(red: 10, green: 33, blue: 44, alpha: 1.0)
        self.imageView.backgroundColor = colorWithRGBA(red: 8, green: 24, blue: 32, alpha: 1.0)
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
        
        imageView.added(into: view)
        leftTopimageView.added(into: view)
        leftBottomimageView.added(into: view)
        rightTopimageView.added(into: view)
        rightBottomimageView.added(into: view)
        
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
