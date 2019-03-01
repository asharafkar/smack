//
//  ChannelVC.swift
//  Smack
//
//  Created by Amir on 2/23/19.
//  Copyright © 2019 Amir Sharafkar. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userAvatarImage : UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController()?.rearViewRevealWidth = self.view.frame.size.width * 0.7
        NotificationCenter.default.addObserver(self, selector: #selector(userDataDidChange(_: )), name: NOTIFICATION_USER_DATA_DID_CHANGE, object: nil)
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: self)
    }
    
    @objc func userDataDidChange(_ notif: Notification){
        if AuthService.instance.isLoggedIn{
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            userAvatarImage.image = UIImage(named: UserDataService.instance.avatarName)
            userAvatarImage.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        }else{
            loginBtn.setTitle("Login", for: .normal)
            userAvatarImage.image = UIImage(named: "menuProfileIcon")
            userAvatarImage.backgroundColor = UIColor.clear
        }
    }
}
