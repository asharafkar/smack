//
//  ProfileVC.swift
//  Smack
//
//  Created by Amir on 3/1/19.
//  Copyright © 2019 Amir Sharafkar. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var avatarImage: CircleImage!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func closePressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func setupView(){
        usernameLbl.text = UserDataService.instance.name
        emailLbl.text = UserDataService.instance.email
        avatarImage.image = UIImage(named: UserDataService.instance.avatarName)
        avatarImage.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(self.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
        
    }
    
    @IBAction func logoutPressed(_ sender: UIButton) {
        UserDataService.instance.logout()
        NotificationCenter.default.post(name: NOTIFICATION_USER_DATA_DID_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
    
}
