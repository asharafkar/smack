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
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    var avatarName: String = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    var bgColor : UIColor?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordText.delegate = self
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            userAvatarImage.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
            if avatarName.contains("light") && bgColor == nil{
                userAvatarImage.backgroundColor = UIColor.lightGray
            }
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
        
        let red = CGFloat(arc4random_uniform(255)) / 255
        let green = CGFloat(arc4random_uniform(255)) / 255
        let blue = CGFloat(arc4random_uniform(255)) / 255
        
        bgColor = UIColor(displayP3Red: red, green: green, blue: blue, alpha: 1)
        UIView.animate(withDuration: 1.3){
            self.userAvatarImage.backgroundColor = self.bgColor
        }
        avatarColor = "[\(red), \(green), \(blue), 1]"
        
    }
    
    @IBAction func createAccountPressed(_ sender: UIButton) {
        
        spinner.isHidden = false
        spinner.startAnimating()
        
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
                                NotificationCenter.default.post(name: NOTIFICATION_USER_DATA_DID_CHANGE, object: nil)
                                self.spinner.isHidden = true
                                self.spinner.stopAnimating()
                                self.dismiss(animated: true, completion: nil)
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
    
    func setupView(){
        spinner.isHidden = true
        usernameText.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedString.Key.foregroundColor: smackPurplePlaceHolder])
         emailText.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedString.Key.foregroundColor: smackPurplePlaceHolder])
        passwordText.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor: smackPurplePlaceHolder])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(){
        view.endEditing(true)
    }
}
