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
    
    var sayStr:String?;
    
    var Chats:NSMutableArray!
    var tableView:ChatTableView!
    var me:ChatUserInfo!
    var you:ChatUserInfo!
    
    var longPressGesture : UILongPressGestureRecognizer!;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setUpPressend();
        setUpUI()
        setupChatTable()
        
    }
    
    

}


extension VoiceControllVC:OEEventsObserverDelegate{
    
    private func  setUpPressend(){
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(recognizer:)))
        tabBarController?.tabBar.addGestureRecognizer(longPressGesture);
    
    }
    
    @objc func handleLongPress(recognizer:UILongPressGestureRecognizer)
    {
        if tabBarController?.selectedIndex == 2 {
            if let tabbar:UITabBar = recognizer.view! as? UITabBar
            {
                if recognizer.state == UIGestureRecognizer.State.began
                {
                    print("长按开始-----监听中... \(#function)")
                    startListen()

                }
                
                if recognizer.state == UIGestureRecognizer.State.ended{
                    print("长按结束-----\(tabbar)  \(#function) + \(#file)")
                    stopListen()
                }
            }
        }
    }
    
    private func setUpUI(){
        
        self.startBtn = YHRippleButton(frame: CGRect(x: (self.view.size.width - 150)/2,
                                                     y: self.view.size.height - 150 - SafeAreaBottomHeight - kTabBarH,
                                                     width: 150,
                                                     height: 150),
                                       rippleColor: .blue)
        self.startBtn.setTitle("开始", for: .normal)
        self.startBtn.addTarget(self, action: #selector(startVoiceBtnCkick(btn:)), for: .touchUpInside)
//        self.startBtn.center = view.center
        view.addSubview(self.startBtn)
        
        /*命令词*/
        self.lmGenerator = OELanguageModelGenerator.init()
        self.pocketsphinx = OEPocketsphinxController.sharedInstance()
        self.chineseWords = ["向左移动", "向右移动", "向下移动", "向上移动","开始","停止"]
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
            sendMessage();

            
        }
        self.startBtn.isSelected = !self.startBtn.isSelected
    }
    
    private func startListen(){
        try? self.pocketsphinx.setActive(true)
        self.pocketsphinx.startListeningWithLanguageModel(atPath: self.chineseLmPath,
                                                          dictionaryAtPath: self.chineseDicPath,
                                                          acousticModelAtPath: OEAcousticModel.path(toModel: "AcousticModelChinese"),
                                                          languageModelIsJSGF: false)
    }
    private func stopListen(){
        self.pocketsphinx.stopListening()
    }
    
    func pocketsphinxDidReceiveHypothesis(_ hypothesis: String!, recognitionScore: String!, utteranceID: String!) {
        print("接收到的语音是 \(String(describing: hypothesis)) 分数为 \(String(describing: recognitionScore)) ID为 \(String(describing: utteranceID))")
        sayStr = hypothesis;
        

        
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
        sayStr = nil;
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


extension VoiceControllVC:ChatDataSource,UITextFieldDelegate{
    
    
    func setupChatTable()
    {
        tableView = ChatTableView(frame: CGRect(x: 0,
                                                y: kStatusBarH + kNavigationBar,
                                                width: view.width,
                                                height:view.height - 200 - SafeAreaBottomHeight - kTabBottomH ),
                                  style: .plain)
        tableView.backgroundColor = UIColor.white;
        //创建一个重用的单元格
        tableView!.register(ChatTableViewCell.self, forCellReuseIdentifier: "ChatCell")
        me = ChatUserInfo(name:"Xiaoming" ,logo:("xiaoming.png"))
        you  = ChatUserInfo(name:"Xiaohua", logo:("xiaohua.png"))
        
        let zero =  MessageItem(body:"欢迎使用语言控制", user:you,  date:Date(timeIntervalSinceNow:0), mtype:.someone)

        let zero1 =  MessageItem(body:"你可以说:\n向下移动,向上移动,向左移动,向右移动,开始,停止", user:you,  date:Date(timeIntervalSinceNow:0), mtype:.someone)
//        let fouth =  MessageItem(body:"嗯，下次我们一起去吧！",user:me, date:Date(timeIntervalSinceNow:-90000020), mtype:.mine)
        
        Chats = NSMutableArray()
//        Chats.addObjects(from: [first, third, fouth, fifth, zero, zero1])
        Chats.addObjects(from: [zero,zero1])
        tableView.chatDataSource = self
        tableView.reloadData()
        tableView.added(into: view);
    }
    
    func rowsForChatTable(_ tableView:ChatTableView) -> Int
    {
        return self.Chats.count
    }
    
    func chatTableView(_ tableView:ChatTableView, dataForRow row:Int) -> MessageItem
    {
        return Chats[row] as! MessageItem
    }
    
    @objc func sendMessage()
    {
        var senderStr = sayStr
        if (senderStr == nil)
        {
            senderStr = "我没有听清楚,你可以尝试再说一次:\n向下移动,向上移动,向左移动,向右移动,开始,停止"
            let thatChat =  MessageItem(body:"\(senderStr!)" as NSString, user:you, date:Date(), mtype:ChatType.someone)
            Chats.add(thatChat)
        }
        else
        {
            let thisChat =  MessageItem(body:senderStr! as NSString, user:me, date:Date(), mtype:ChatType.mine)
            let thatChat =  MessageItem(body:"你说的是:\(senderStr!)" as NSString, user:you, date:Date(), mtype:ChatType.someone)
            Chats.add(thisChat)
            Chats.add(thatChat)
        }
        self.tableView.chatDataSource = self
        self.tableView.reloadData()

    }
    
    
    
    
}

