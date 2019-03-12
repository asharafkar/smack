//
//  UserDataService.swift
//  Smack
//
//  Created by Amir on 2/27/19.
//  Copyright © 2019 Amir Sharafkar. All rights reserved.
//

import Foundation

class UserDataService{
    
    static let instance = UserDataService()
    
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
    func setUserData(id: String, color: String, avatarName: String, email: String, name: String){
        self.id = id
        self.avatarColor = color
        self.avatarName = avatarName
        self.email = email
        self.name = name
    }
    
    func setAvatarName(avatarName: String){
        self.avatarName = avatarName
    }
    
    func returnUIColor(components: String) -> UIColor{
        
        let scanner = Scanner(string: components)
        let skipped = CharacterSet(charactersIn: "[], ")
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skipped
        
        var red, green, blue, alpha: NSString?
        
        scanner.scanUpToCharacters(from: comma, into: &red)
        scanner.scanUpToCharacters(from: comma, into: &green)
        scanner.scanUpToCharacters(from: comma, into: &blue)
        scanner.scanUpToCharacters(from: comma, into: &alpha)
        
        let defaultColor = UIColor.lightGray
        
        guard let redUnwrapped = red else {return defaultColor}
        guard let blueUnwrapped = red else {return defaultColor}
        guard let greenUnwrapped = red else {return defaultColor}
        guard let alphaUnwrapped = red else {return defaultColor}
        
        let redFloat = CGFloat(redUnwrapped.floatValue)
        let greenFloat = CGFloat(greenUnwrapped.floatValue)
        let blueFloat = CGFloat(blueUnwrapped.floatValue)
        let alphaFloat = CGFloat(alphaUnwrapped.floatValue)
        
        let newUIColor = UIColor(displayP3Red: redFloat, green: greenFloat, blue: blueFloat, alpha: alphaFloat)
        
        return newUIColor
    }
    
    func logout(){
        id = ""
        avatarName = ""
        avatarColor = ""
        email = ""
        name = ""
        AuthService.instance.isLoggedIn = false
        MessageService.instance.clearChannels()
        MessageService.instance.clearMessage()
    }
    
}
