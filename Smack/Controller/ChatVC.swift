//
//  ChatVC.swift
//  Smack
//
//  Created by Amir on 2/23/19.
//  Copyright © 2019 Amir Sharafkar. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var channelNameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    }
    
    @objc func userDataDidChange(_ notif: Notification){
        
        if AuthService.instance.isLoggedIn {
            onLoginGetMessages()
        }else{
            channelNameLabel.text = "Please Login"
        }
    }
    
    @objc func changeCurrentChannel(_ notif: Notification){
        channelNameLabel.text = "#\(MessageService.instance.currentChannel?.channelTitle ?? "")"
    }

    func onLoginGetMessages(){
        MessageService.instance.findAllChannel { (success) in
            
            if success{
                
            }
        }
    }

}
