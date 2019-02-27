//
//  RegisterVC.swift
//  Smack
//
//  Created by Amir on 2/24/19.
//  Copyright © 2019 Amir Sharafkar. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var userAvatarImage: UIImageView!
    
    var avatarName: String = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordText.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            userAvatarImage.image = UIImage(named: UserDataService.instance.avatarName)
        }
    }

    @IBAction func registerBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: self)
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pickAvatarPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "to_avatar", sender: nil)
    }
    
    
    @IBAction func pickBGColorPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func createAccountPressed(_ sender: UIButton) {
        
        guard let email = emailText.text, emailText.text != "" else {
            return
        }
        
        guard let password = passwordText.text, passwordText.text != "" else {
            return
        }
        
        guard let username = usernameText.text, usernameText.text != "" else {
            return
        }
        
        AuthService.instance.registerUser(email: email, password: password) { (success) in
            if success {
                print("user has been registered!")
                AuthService.instance.loginUser(email: email, password: password, completion: { (success) in
                    if success{
                        AuthService.instance.createUser(username: username, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if success{
                                self.performSegue(withIdentifier: "to_channel", sender: nil)
                            }
                        })
                    }
                })
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
}
