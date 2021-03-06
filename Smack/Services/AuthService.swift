//
//  AuthService.swift
//  Smack
//
//  Created by Amir on 2/26/19.
//  Copyright © 2019 Amir Sharafkar. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService{
    
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    var isLoggedIn : Bool{
        get{
           return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        
        set{
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken: String{
        get{
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set{
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail: String{
        get{
            return defaults.value(forKey: USER_EMAIL_KEY) as! String
        }
        set{
            defaults.set(newValue, forKey: USER_EMAIL_KEY)
        }
    }
    
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler){
        
        let lowerCaseEmail = email.lowercased()
        
        let body : [String : Any] = ["email" : lowerCaseEmail, "password" : password]
        
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
            
            if response.result.error == nil{
                completion(true)
                
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler){
        
        let lowerCaseEmail = email.lowercased()
        
        let body : [String : String] = ["email" : lowerCaseEmail, "password" : password]
        
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            
            if response.result.error == nil{
                
                guard let data = response.data else {return}
                
                do{
                 let json = try JSON(data: data)
                     self.userEmail = json["user"].stringValue
                    self.authToken = json["token"].stringValue
                }catch{
                    print(error as! String)
                }
                
                self.isLoggedIn = true
                
                completion(true)
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
            
        }
    }
    
    func createUser(username: String, email: String, avatarName: String, avatarColor: String, completion: @escaping CompletionHandler){
        

        let lowerEmail = email.lowercased()
        
        let body : [String: Any] = ["name" : username, "email" : lowerEmail, "avatarName" : avatarName, "avatarColor" : avatarColor]
        
        let header = ["Content-Type" : "application/json; charset=utf-8", "Authorization" : "Bearer \(authToken)"]
        
        Alamofire.request(URL_USER_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            
            if response.result.error == nil{
                
                guard let data = response.data else {return}
                
                self.setUserInfo(data: data)
                
                
                completion(true)
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
            
        }
    }
    
    func findUserByEmail(completion: @escaping CompletionHandler){
        
        Alamofire.request("\(URL_USER_BY_EMAIL)\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            guard let data = response.data else {return}
            self.setUserInfo(data: data)
           
        }
    }
    
    func setUserInfo(data: Data){
        do{
            let json = try JSON(data: data)
            let id = json["_id"].stringValue
            let avatarColor = json["avatarColor"].stringValue
            let avatarName = json["avatarName"].stringValue
            let email = json["email"].stringValue
            let name = json["name"].stringValue
            
            UserDataService.instance.setUserData(id: id, color: avatarColor, avatarName: avatarName, email: email, name: name)
        }catch{
            
        }
    }
    
}



















