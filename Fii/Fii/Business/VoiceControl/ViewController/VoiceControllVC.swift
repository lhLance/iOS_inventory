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
    
    var Chats:NSMutableArray!
    var tableView:ChatTableView!
    var me:ChatUserInfo!
    var you:ChatUserInfo!
    var txtMsg:UITextField!
    
    var longPressGesture : UILongPressGestureRecognizer!;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setUpPressend();
        setUpUI()
        
        
        
        
//        setupChatTable()
//        setupSendPanel()
        
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
                    self.startBtn.setTitle("监听中...", for: UIControl.State.normal)
                    try? self.pocketsphinx.setActive(true)
                    self.pocketsphinx.startListeningWithLanguageModel(atPath: self.chineseLmPath,
                                                                      dictionaryAtPath: self.chineseDicPath,
                                                                      acousticModelAtPath: OEAcousticModel.path(toModel: "AcousticModelChinese"),
                                                                      languageModelIsJSGF: false)
                }
                
                if recognizer.state == UIGestureRecognizer.State.ended{
                    print("长按结束-----\(tabbar)  \(#function) + \(#file)")
                    self.startBtn.setTitle("开始", for: UIControl.State.normal)
                    self.pocketsphinx.stopListening()
                }
            }
        }
    }
    
    private func setUpUI(){
        
        //        self.speechLab = UILabel(frame: CGRect(x:100,
        //                                               y: 100,
        //                                               width: 200,
        //                                               height: 50))
        //        self.speechLab.backgroundColor = UIColor.yellow
        //        self.speechLab.textAlignment = NSTextAlignment.center
        //        self.view.addSubview(self.speechLab)
        
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
//        if !self.startBtn.isSelected
//        {
//            print("\(#function)+ \(#file)")
//
//            self.startBtn.setTitle("监听中...", for: UIControl.State.normal)
//            try? self.pocketsphinx.setActive(true)
//            self.pocketsphinx.startListeningWithLanguageModel(atPath: self.chineseLmPath,
//                                                              dictionaryAtPath: self.chineseDicPath,
//                                                              acousticModelAtPath: OEAcousticModel.path(toModel: "AcousticModelChinese"),
//                                                              languageModelIsJSGF: false)
//        }
//        else{
//
//            print("\(#function) + \(#file)")
//            self.startBtn.setTitle("开始", for: UIControl.State.normal)
//            self.pocketsphinx.stopListening()
//        }
//        self.startBtn.isSelected = !self.startBtn.isSelected
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


extension VoiceControllVC:ChatDataSource,UITextFieldDelegate{
    
    
    func setupChatTable()
    {
        tableView = ChatTableView(frame: CGRect(x: 0,
                                                y: 20,
                                                width: view.width,
                                                height:view.height ),
                                  style: .plain)
        //创建一个重用的单元格
        tableView!.register(ChatTableViewCell.self, forCellReuseIdentifier: "ChatCell")
        me = ChatUserInfo(name:"Xiaoming" ,logo:("xiaoming.png"))
        you  = ChatUserInfo(name:"Xiaohua", logo:("xiaohua.png"))
        
        let zero =  MessageItem(body:"最近去哪玩了？", user:you,  date:Date(timeIntervalSinceNow:-90096400), mtype:.someone)
        
        let zero1 =  MessageItem(body:"去了趟苏州，明天发照片给你哈？", user:me,  date:Date(timeIntervalSinceNow:-90086400), mtype:.mine)
        
        let first =  MessageItem(body:"你看这风景怎么样，我周末去苏州拍的！", user:me,  date:Date(timeIntervalSinceNow:-90000600), mtype:.mine)
        
        let third =  MessageItem(body:"太赞了，我也想去那看看呢！",user:you, date:Date(timeIntervalSinceNow:-90000060), mtype:.someone)
        
        let fouth =  MessageItem(body:"嗯，下次我们一起去吧！",user:me, date:Date(timeIntervalSinceNow:-90000020), mtype:.mine)
        
        let fifth =  MessageItem(body:"三年了，我终究没能看到这个风景",user:you, date:Date(timeIntervalSinceNow:0), mtype:.someone)
        
        Chats = NSMutableArray()
        Chats.addObjects(from: [first, third, fouth, fifth, zero, zero1])
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
    
    /////////
    
    func setupSendPanel()
    {
        let screenWidth = UIScreen.main.bounds.width
        let sendView = UIView(frame:CGRect(x: 0,
                                           y: self.view.frame.size.height - 156,
                                           width: screenWidth,
                                           height: 56))
        
        sendView.backgroundColor=UIColor.lightGray
        sendView.alpha=0.9
        
        txtMsg = UITextField(frame:CGRect(x: 7,
                                          y: 10,
                                          width: screenWidth - 95,
                                          height: 36))
        txtMsg.backgroundColor = UIColor.white
        txtMsg.textColor=UIColor.black
        txtMsg.font=UIFont.boldSystemFont(ofSize: 12)
        txtMsg.layer.cornerRadius = 10.0
        txtMsg.returnKeyType = UIReturnKeyType.send
        
        //Set the delegate so you can respond to user input
        txtMsg.delegate=self
        sendView.addSubview(txtMsg)
        self.view.addSubview(sendView)
        
        let sendButton = UIButton(frame:CGRect(x: screenWidth - 80,
                                               y: 10,
                                               width: 72,
                                               height: 36))
        sendButton.backgroundColor=UIColor(red: 0x37/255, green: 0xba/255, blue: 0x46/255, alpha: 1)
        sendButton.addTarget(self, action:#selector(sendMessage) ,
                             for:UIControl.Event.touchUpInside)
        sendButton.layer.cornerRadius=6.0
        sendButton.setTitle("发送", for:UIControl.State())
        sendView.addSubview(sendButton)
    }
    
    func textFieldShouldReturn(_ textField:UITextField) -> Bool
    {
        sendMessage()
        return true
    }
    
    @objc func sendMessage()
    {
        //composing=false
        let sender = txtMsg
        let thisChat =  MessageItem(body:sender!.text! as NSString, user:me, date:Date(), mtype:ChatType.mine)
        let thatChat =  MessageItem(body:"你说的是：\(sender!.text!)" as NSString, user:you, date:Date(), mtype:ChatType.someone)
        
        Chats.add(thisChat)
        Chats.add(thatChat)

        self.tableView.chatDataSource = self
        self.tableView.reloadData()
        //self.showTableView()
        sender?.resignFirstResponder()
        sender?.text = ""
    }
    
    
    
    
}

