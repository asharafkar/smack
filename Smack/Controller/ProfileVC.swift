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
    }
    
    @IBAction func logoutPressed(_ sender: UIButton) {
        
    }
    
}
