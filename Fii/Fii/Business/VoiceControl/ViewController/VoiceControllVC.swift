//
//  VoiceControllVC.swift
//  Fii
//
//  Created by Liu Tao on 2019/3/11.
//  Copyright © 2019年 Liu Tao. All rights reserved.
//

import UIKit
private let ChineseModel = "LanguageModelFilesOfChinese"
private let btnWidth:CGFloat = 118
private let btnHeight:CGFloat = 79


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
    var longPressGesture : UILongPressGestureRecognizer!;
    var sayStr:String?;
    
    
    var dataSource:NSMutableArray = NSMutableArray()
    var tableView:UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        createTipsData()
        initSomething()
        initChatTableView()
        setUpPressend();
        setUpUI()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        ScrollTableViewToBottom()
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
        

        let wigW:CGFloat = CGFloat((self.view.width) - btnWidth)/2;
        let wigH:CGFloat = CGFloat((self.view.height - btnHeight - 5 - SafeAreaBottomHeight - kTabBarH));
        startBtn = UIButton(frame: CGRect(x: wigW,
                                               y: wigH,
                                               width: btnWidth,
                                               height: btnHeight))
        startBtn.setBackgroundImage(UIImage(named: "msg_voice"), for: UIControl.State.normal)
        startBtn.setTitle(LanguageHelper.getString(key: "start"), for: .normal)
        startBtn.setTitleColor(UIColor.white,for: .normal)
        startBtn.addTarget(self, action: #selector(startVoiceBtnCkick(btn:)), for: .touchUpInside)
        startBtn.contentMode = UIView.ContentMode.scaleAspectFill
        startBtn.added(into: view)
        
        /*命令词*/
        lmGenerator = OELanguageModelGenerator.init()
        pocketsphinx = OEPocketsphinxController.sharedInstance()
        chineseWords = ["向左移动", "向右移动", "向下移动", "向上移动","开始","停止"]
        openEarsEventsObserver = OEEventsObserver.init()
        openEarsEventsObserver.delegate = self
        
        errString = self.lmGenerator.generateLanguageModel(from: self.chineseWords as? [Any],
                                                                withFilesNamed: ChineseModel,
                                                                forAcousticModelAtPath: OEAcousticModel.path(toModel: "AcousticModelChinese"))as?String
        chineseLmPath = self.lmGenerator.pathToSuccessfullyGeneratedLanguageModel(withRequestedName: ChineseModel)
        chineseDicPath = self.lmGenerator.pathToSuccessfullyGeneratedDictionary(withRequestedName: ChineseModel)
        
    }
    
    @objc func startVoiceBtnCkick(btn:UIButton)
    {


        
        if !startBtn.isSelected
        {
            checkVoiceAllow()
            VoiceDialog.show(vc: self)

            print("\(#function)+ \(#file)")
            sayStr = ""
            self.startBtn.setTitle(LanguageHelper.getString(key: "voice_listening"), for: UIControl.State.normal)
            try? self.pocketsphinx.setActive(true)
            self.pocketsphinx.startListeningWithLanguageModel(atPath: self.chineseLmPath,
                                                              dictionaryAtPath: self.chineseDicPath,
                                                              acousticModelAtPath: OEAcousticModel.path(toModel: "AcousticModelChinese"),
                                                              languageModelIsJSGF: false)
        }
        else{

            VoiceDialog.dissmiss()

            print("\(#function) + \(#file)")
            self.startBtn.setTitle(LanguageHelper.getString(key: "start"), for: UIControl.State.normal)
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
    
    func checkVoiceAllow()
    {
        var allow = false
        let audioSession = AVAudioSession.sharedInstance()
        //首先要判断是否允许访问麦克风
        audioSession.requestRecordPermission { (allowed) in
            if !allowed{
                let alert = UIAlertController(title: "无法访问您的麦克风", message: "请到设置 -> 隐私 -> 麦克风 ，打开访问权限", preferredStyle: UIAlertController.Style.alert)
                let btnOK = UIAlertAction(title: "好的", style: .default, handler: nil)
                alert.addAction(btnOK)
                self.present(alert, animated: true, completion: nil)
                
                allow = false
            }else{
                allow = true
            }
        }
        if allow == false {
            return
        }
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

extension VoiceControllVC :UITableViewDelegate,UITableViewDataSource{
    
    func createTipsData() {
        for i: Int in 0..<2 {
            let chatCellFrame:YTChatCellFrame = YTChatCellFrame()
            let message:YTChatMessage = YTChatMessage()
            var messageText = String()
            if i == 0 {
                message.currentUserType = userType.me
                message.userName = " "
                message.messageType = 0
                messageText = LanguageHelper.getString(key: "voice_tips_welocome")
            }else if i == 1 {
                let tipStr = "\(LanguageHelper.getString(key: "voice_tips_word"))  \n \(LanguageHelper.getString(key: "voice_tips_Key_Word"))"
                message.currentUserType = userType.me
                message.userName = " "
                message.messageType = 0;
                messageText = tipStr
            }
            message.message = messageText
            
            chatCellFrame.message = message
            
            dataSource.add(chatCellFrame)
        }
    }
    
    // 初始化一些数据
    func initSomething() {
        
        self.view.backgroundColor = BACKGROUND_Color
        
        if #available(iOS 11.0, *) {
            
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        self.title = LanguageHelper.getString(key: "voice")
        
    }
    
    //创建tabbleView
    func initChatTableView() {
        let contentH = UIScreen.height - kStatusBarH  - kNavigationBarH - kTabBarH - SafeAreaBottomHeight - btnHeight - 5
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: kStatusBarH  + kNavigationBarH, width: screenW, height: contentH))
        tableView.backgroundColor = BACKGROUND_Color
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(YTChatMessageCell.self, forCellReuseIdentifier: "YTChatMessageCell")
        self.view.addSubview(tableView)
        
    }
    
    
    //tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = YTChatMessageCell.cellWithTableView(tableView: tableView)
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        let chatCellFrame:YTChatCellFrame = dataSource.object(at: indexPath.row) as! YTChatCellFrame
        
        cell.chatCellFrame = chatCellFrame
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let chatCellFrame:YTChatCellFrame = dataSource.object(at: indexPath.row) as! YTChatCellFrame
        
        return chatCellFrame.cellHeight;
    }
    
    //重设tabbleview的frame并根据是否在底部来执行滚动到底部的动画（不在底部就不执行，在底部才执行）
    func resetChatList() {
        
        let offSetY:CGFloat = tableView.contentSize.height - tableView.height;
        //判断是否滚动到底部，会有一个误差值
        if tableView.contentOffset.y > offSetY - 5 || tableView.contentOffset.y > offSetY + 5 {
            ScrollTableViewToBottom()
        }
    }
    
    //滚动到底部
    func ScrollTableViewToBottom() {
        
        let indexPath:NSIndexPath = NSIndexPath.init(row: self.dataSource.count - 1, section: 0)
        self.tableView.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.bottom, animated: false)
    }
    @objc func sendMessage() {
        
        let message:YTChatMessage = YTChatMessage()
        var messageText = sayStr
        if (messageText?.count == 0)
        {
            messageText = LanguageHelper.getString(key: "voice_tips_word_again") + "\n" + LanguageHelper.getString(key: "voice_tips_Key_Word")
            message.currentUserType = userType.me
            message.userName = " "
            message.messageType = 0;
        }
        else
        {
            message.currentUserType = userType.other
            message.userName = " "
            message.messageType = 0
        }
        message.message = messageText!
        createDataSource(message: message)
        refreshChatList()
    }
    
    //创建一条数据
    func createDataSource(message:YTChatMessage) {
        let cellFrame = YTChatCellFrame()
        cellFrame.message = message
        dataSource.add(cellFrame)
        
    }
    
    //刷新UI
    func refreshChatList() {
        let indexPath:NSIndexPath = NSIndexPath.init(row: dataSource.count - 1, section: 0)
        tableView.insertRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.none)
        self.tableView.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.bottom, animated: true)
    }
    
}

