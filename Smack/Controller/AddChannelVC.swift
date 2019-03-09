//
//  AddChannelVC.swift
//  Smack
//
//  Created by Amir on 3/8/19.
//  Copyright © 2019 Amir Sharafkar. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var descriptionText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func closeModalPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createChannelPressed(_ sender: UIButton) {
        
        guard let channelName = nameText.text, nameText.text != "" else { return }
        guard let channelDescription = descriptionText.text, descriptionText.text != "" else { return }
        
        SocketService.instance.addChannel(channelName: channelName, channelDescription: channelDescription) { (success) in
            
            if success{
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    

}
