//
//  VoiceControllVC.swift
//  Fii
//
//  Created by Liu Tao on 2019/3/11.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import UIKit
private let ChineseModel = "LanguageModelFilesOfChinese"

class VoiceControllVC: UIViewController {

    var openEarsEventsObserver:OEEventsObserver!
    var lmGenerator:OELanguageModelGenerator!
    var pocketsphinx:OEPocketsphinxController!
    var englishWords:NSArray! = []
    var chineseWords:NSArray! = []
    var startBtn:UIButton!
    var chineseLmPath:String = ""
    var chineseDicPath:String = ""
    var errString:String! = ""
    var speechLab:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setUpUI()
        
    }
    
    

}



extension VoiceControllVC:OEEventsObserverDelegate{
    
    
    private func setUpUI(){
        
        self.speechLab = UILabel(frame: CGRect(x:100,
                                               y: 100,
                                               width: 200,
                                               height: 50))
        self.speechLab.backgroundColor = UIColor.yellow
        self.speechLab.textAlignment = NSTextAlignment.center
        self.view.addSubview(self.speechLab)
        
        self.startBtn = YHRippleButton(frame: CGRect(x: 0,
                                                     y: 0,
                                                     width: 200,
                                                     height: 200),
                                       rippleColor: .blue)
        self.startBtn.setTitle("开始", for: .normal)
        self.startBtn.addTarget(self, action: #selector(startVoiceBtnCkick(btn:)), for: .touchUpInside)
        self.startBtn.center = view.center
        view.addSubview(self.startBtn)
        
        /*命令词*/
        self.lmGenerator = OELanguageModelGenerator.init()
        self.pocketsphinx = OEPocketsphinxController.sharedInstance()
        self.chineseWords = ["左边", "上边", "向下移动", "右边","四分之三","在中国","向左移动"]
        self.openEarsEventsObserver = OEEventsObserver.init()
        self.openEarsEventsObserver.delegate = self
        
        self.errString = self.lmGenerator.generateLanguageModel(from: self.chineseWords as? [Any],
                                                                withFilesNamed: ChineseModel,
                                                                forAcousticModelAtPath: OEAcousticModel.path(toModel: "AcousticModelChinese"))as?String
        self.chineseLmPath = self.lmGenerator.pathToSuccessfullyGeneratedLanguageModel(withRequestedName: ChineseModel)
        self.chineseDicPath = self.lmGenerator.pathToSuccessfullyGeneratedDictionary(withRequestedName: ChineseModel)
        
    }
    
    @objc func startVoiceBtnCkick(btn:UIButton)
    {
        if !self.startBtn.isSelected
        {
            print("\(#function)+ \(#file)")
            
            self.startBtn.setTitle("监听中...", for: UIControl.State.normal)
            try? self.pocketsphinx.setActive(true)
            self.pocketsphinx.startListeningWithLanguageModel(atPath: self.chineseLmPath,
                                                              dictionaryAtPath: self.chineseDicPath,
                                                              acousticModelAtPath: OEAcousticModel.path(toModel: "AcousticModelChinese"),
                                                              languageModelIsJSGF: false)
        }
        else{
            
            print("\(#function) + \(#file)")
            self.startBtn.setTitle("开始", for: UIControl.State.normal)
            self.pocketsphinx.stopListening()
        }
        self.startBtn.isSelected = !self.startBtn.isSelected
    }

    
    func pocketsphinxDidReceiveHypothesis(_ hypothesis: String!, recognitionScore: String!, utteranceID: String!) {
        print("接收到的语音是 \(String(describing: hypothesis)) 分数为 \(String(describing: recognitionScore)) ID为 \(String(describing: utteranceID))")
        self.speechLab.text = hypothesis
        
    }
    
    func pocketsphinxDidStartListening() {
        print("\(#function)已经开始接听")
    }
    
    func pocketsphinxDidDetectSpeech() {
        print("\(#function)已经发现语音")
    }
    
    func pocketsphinxDidDetectFinishedSpeech() {
        print("\(#function)一段时间没有监听到语音")
    }
    
    func pocketsphinxDidStopListening() {
        print("\(#function)已经停止监听")
    }
    
    func pocketsphinxDidSuspendRecognition() {
        print("\(#function)已经暂停识别")
    }
    
    func pocketsphinxDidResumeRecognition() {
        print("\(#function)已经恢复识别")
    }
    
    func pocketSphinxContinuousSetupDidFail(withReason reasonForFailure: String!) {
        print("\(#function)监听设置不成功,返回失败的原因: \(String(describing: reasonForFailure))")
        
    }
    
    func pocketSphinxContinuousTeardownDidFail(withReason reasonForFailure: String!) {
        print("\(#function)监听关闭不成功,返回失败原因:\(String(describing: reasonForFailure))") 
        
    }
    
    func pocketsphinxTestRecognitionCompleted() {
        
    }
    
}
