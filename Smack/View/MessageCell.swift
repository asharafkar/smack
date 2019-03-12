//
//  MessageCell.swift
//  Smack
//
//  Created by Amir on 3/12/19.
//  Copyright © 2019 Amir Sharafkar. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    func configCell(message: Message){
        messageLabel.text = message.message
        usernameLabel.text = message.username
        userAvatar.image = UIImage(named: message.userAvatarImage)
        userAvatar.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)
    }

}
