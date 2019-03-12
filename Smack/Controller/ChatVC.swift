//
//  ChatVC.swift
//  Smack
//
//  Created by Amir on 2/23/19.
//  Copyright © 2019 Amir Sharafkar. All rights reserved.
//

import UIKit

class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var channelNameLabel: UILabel!
    @IBOutlet weak var messageText: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendButton: UIButton!
    var isTyping = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.bindToKeyboard()
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.handleTap))
        view.addGestureRecognizer(tap)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        sendButton.isHidden = true
        
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        NotificationCenter.default.addObserver(self, selector: #selector(userDataDidChange(_:)), name: NOTIFICATION_USER_DATA_DID_CHANGE, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeCurrentChannel(_:)), name: NOTIFICATION_CURRENT_CHANNEL, object: nil)
        
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail { (success) in
                NotificationCenter.default.post(name: NOTIFICATION_USER_DATA_DID_CHANGE, object: nil)
            }
        }
        
        MessageService.instance.findAllChannel { (success) in
            
        }
        
        SocketService.instance.getChatMessage { (success) in
            self.tableView.reloadData()
            if MessageService.instance.messages.count > 0{
                let endIndex = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
                self.tableView.scrollToRow(at: endIndex, at: .bottom, animated: true)
            }
        }
    }
    
    @objc func userDataDidChange(_ notif: Notification){
        
        if AuthService.instance.isLoggedIn {
            onLoginGetMessages()
        }else{
            channelNameLabel.text = "Please Login"
            tableView.reloadData()
        }
    }
    
    @objc func changeCurrentChannel(_ notif: Notification){
        updateWithChannel()
    }
    
    func updateWithChannel(){
        channelNameLabel.text = "#\(MessageService.instance.currentChannel?.channelTitle ?? "")"
        getMessage()
    }

    func onLoginGetMessages(){
        MessageService.instance.findAllChannel { (success) in
            
            if success{
                if MessageService.instance.channels.count > 0{
                    MessageService.instance.currentChannel = MessageService.instance.channels[0]
                    self.updateWithChannel()
                }else{
                    self.channelNameLabel.text = "No channels yet!"
                }
            }
        }
    }
    
    func getMessage(){
        guard let channelId = MessageService.instance.currentChannel?.id else { return }
        MessageService.instance.findAllMessagesForChannel(channelId: channelId) { (success) in
            if success{
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func sendMessagePressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn{
            guard let channelId = MessageService.instance.currentChannel?.id else { return }
            guard let message = messageText.text else { return }
            
            SocketService.instance.sendMessage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId) { (success) in
                
                if success{
                    self.messageText.text = ""
                    self.messageText.resignFirstResponder()
                }
            }
            
        }
    }
    
    @objc func handleTap(){
        view.endEditing(true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell{
            let message = MessageService.instance.messages[indexPath.row]
            cell.configCell(message: message)
            return cell
        }else{
            return UITableViewCell()
        }
    }

    @IBAction func messageEditting(_ sender: Any) {
        if messageText.text == "" {
            isTyping = false
            sendButton.isHidden = true
        }else{
            if isTyping == false{
                sendButton.isHidden = false
            }
            isTyping = true
        }
    }
    
    
}
